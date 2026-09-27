import '../migrations.dart';

/// Schéma initial : utilisateurs, rôles, sessions, 2FA, audit chaîné,
/// infrastructure de synchronisation et entité `tags`.
const m0001Initial = Migration(1, 'initial', r'''
CREATE EXTENSION IF NOT EXISTS citext;

-- ── Utilisateurs et droits ──────────────────────────────────────────────

CREATE TABLE users (
  id uuid PRIMARY KEY,
  email citext NOT NULL UNIQUE,
  display_name text NOT NULL,
  password_hash text NOT NULL,
  status text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'disabled')),
  -- Secrets TOTP chiffrés (AES-256-GCM, clé VOYAJ_MASTER_KEY).
  totp_secret_enc text,
  totp_pending_secret_enc text,
  totp_enabled_at timestamptz,
  -- Dernier pas de temps TOTP accepté (anti-rejeu).
  totp_last_step bigint,
  last_login_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE user_recovery_codes (
  id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  code_hash text NOT NULL,
  used_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX user_recovery_codes_user_idx ON user_recovery_codes (user_id);

CREATE TABLE roles (
  id uuid PRIMARY KEY,
  key text NOT NULL UNIQUE,
  name text NOT NULL,
  description text,
  is_system boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE role_permissions (
  role_id uuid NOT NULL REFERENCES roles (id) ON DELETE CASCADE,
  permission text NOT NULL,
  PRIMARY KEY (role_id, permission)
);

CREATE TABLE user_roles (
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  role_id uuid NOT NULL REFERENCES roles (id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, role_id)
);

-- ── Sessions ────────────────────────────────────────────────────────────

CREATE TABLE sessions (
  id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  device_id uuid NOT NULL,
  device_name text NOT NULL,
  platform text NOT NULL,
  app_version text,
  -- Jetons stockés hachés (SHA-256) : une fuite de la base ne les expose pas.
  access_token_hash text NOT NULL UNIQUE,
  access_expires_at timestamptz NOT NULL,
  refresh_token_hash text NOT NULL UNIQUE,
  -- Jeton de rafraîchissement précédent : sa réutilisation révèle un vol.
  previous_refresh_hash text,
  refreshed_at timestamptz,
  refresh_expires_at timestamptz NOT NULL,
  ip text,
  user_agent text,
  created_at timestamptz NOT NULL DEFAULT now(),
  last_seen_at timestamptz NOT NULL DEFAULT now(),
  revoked_at timestamptz,
  revoke_reason text
);
CREATE INDEX sessions_user_active_idx ON sessions (user_id) WHERE revoked_at IS NULL;
CREATE INDEX sessions_previous_refresh_idx ON sessions (previous_refresh_hash);

-- Étape intermédiaire « mot de passe correct, code 2FA attendu ».
CREATE TABLE auth_challenges (
  token_hash text PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  device jsonb NOT NULL,
  ip text,
  user_agent text,
  attempts integer NOT NULL DEFAULT 0,
  expires_at timestamptz NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- ── Journal d'audit inaltérable (chaînage SHA-256) ─────────────────────

CREATE TABLE audit_log (
  id bigserial PRIMARY KEY,
  occurred_at timestamptz NOT NULL,
  actor_user_id uuid,
  session_id uuid,
  action text NOT NULL,
  entity text,
  entity_id text,
  payload jsonb NOT NULL DEFAULT '{}'::jsonb,
  ip text,
  prev_hash text NOT NULL,
  hash text NOT NULL UNIQUE
);
CREATE INDEX audit_log_entity_idx ON audit_log (entity, entity_id);
CREATE INDEX audit_log_actor_idx ON audit_log (actor_user_id, occurred_at);

CREATE FUNCTION audit_log_append_only() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  RAISE EXCEPTION 'audit_log est en ajout seul (opération % refusée)', TG_OP;
END;
$$;

CREATE TRIGGER audit_log_no_update_delete
  BEFORE UPDATE OR DELETE ON audit_log
  FOR EACH ROW EXECUTE FUNCTION audit_log_append_only();

CREATE TRIGGER audit_log_no_truncate
  BEFORE TRUNCATE ON audit_log
  FOR EACH STATEMENT EXECUTE FUNCTION audit_log_append_only();

-- ── Synchronisation ─────────────────────────────────────────────────────

-- Numéro global et croissant de chaque changement (curseur de pull).
CREATE SEQUENCE sync_seq;

-- Opérations déjà traitées (idempotence des renvois).
CREATE TABLE sync_ops (
  op_id uuid PRIMARY KEY,
  device_id uuid NOT NULL,
  user_id uuid NOT NULL,
  entity text NOT NULL,
  entity_id uuid NOT NULL,
  status text NOT NULL,
  received_at timestamptz NOT NULL DEFAULT now()
);

-- Historique de toutes les modifications appliquées.
CREATE TABLE change_log (
  seq bigint PRIMARY KEY,
  entity text NOT NULL,
  entity_id uuid NOT NULL,
  version bigint NOT NULL,
  fields jsonb NOT NULL,
  hlc text NOT NULL,
  op_id uuid,
  device_id uuid,
  user_id uuid,
  committed_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX change_log_entity_idx ON change_log (entity, entity_id, seq);

CREATE TABLE sync_conflicts (
  id uuid PRIMARY KEY,
  entity text NOT NULL,
  entity_id uuid NOT NULL,
  field text NOT NULL,
  winning_value jsonb,
  losing_value jsonb,
  winning_hlc text NOT NULL,
  losing_hlc text NOT NULL,
  winner_user_id uuid,
  loser_user_id uuid,
  op_id uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  reviewed_at timestamptz,
  reviewed_by uuid REFERENCES users (id)
);
CREATE INDEX sync_conflicts_created_idx ON sync_conflicts (created_at DESC);

-- ── Entités synchronisées ───────────────────────────────────────────────
-- Colonnes communes : id, version, seq, field_meta, created_*, updated_*,
-- deleted_at (suppression logique).

CREATE TABLE tags (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  color text NOT NULL,
  description text,
  version bigint NOT NULL,
  seq bigint NOT NULL,
  field_meta jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL,
  created_by uuid,
  updated_at timestamptz NOT NULL,
  updated_by uuid,
  deleted_at timestamptz
);
CREATE INDEX tags_seq_idx ON tags (seq);
''');
