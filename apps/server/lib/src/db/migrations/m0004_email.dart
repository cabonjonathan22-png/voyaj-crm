import '../migrations.dart';

const _sync = '''
  version bigint NOT NULL,
  seq bigint NOT NULL,
  field_meta jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL,
  created_by uuid,
  updated_at timestamptz NOT NULL,
  updated_by uuid,
  deleted_at timestamptz''';

/// Emails : comptes (secrets chiffrés), messages, états OAuth ; modèles,
/// séquences et inscriptions (entités synchronisées).
const m0004Email = Migration(4, 'email', '''

CREATE TABLE email_accounts (
  id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  provider text NOT NULL,
  address text NOT NULL,
  display_name text,
  imap_host text NOT NULL,
  imap_port integer NOT NULL,
  imap_tls boolean NOT NULL,
  smtp_host text NOT NULL,
  smtp_port integer NOT NULL,
  smtp_security text NOT NULL,
  username text NOT NULL,
  -- Mot de passe ou jeton de rafraîchissement OAuth, chiffré (clé maître).
  secret_enc text NOT NULL,
  access_token_enc text,
  access_expires_at timestamptz,
  uid_validity bigint,
  last_uid bigint NOT NULL DEFAULT 0,
  last_sync_at timestamptz,
  last_error text,
  enabled boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, address)
);

CREATE TABLE email_messages (
  id uuid PRIMARY KEY,
  account_id uuid NOT NULL REFERENCES email_accounts (id) ON DELETE CASCADE,
  direction text NOT NULL,
  uid bigint,
  message_id text,
  in_reply_to text,
  from_address text NOT NULL,
  from_name text,
  to_addresses jsonb NOT NULL,
  cc_addresses jsonb NOT NULL DEFAULT '[]'::jsonb,
  subject text NOT NULL,
  body_text text NOT NULL,
  sent_at timestamptz NOT NULL,
  read boolean NOT NULL DEFAULT false,
  contact_id uuid,
  organisation_id uuid,
  activity_id uuid,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX email_messages_uid_idx ON email_messages (account_id, uid)
  WHERE uid IS NOT NULL;
CREATE INDEX email_messages_account_idx ON email_messages (account_id, sent_at DESC);
CREATE INDEX email_messages_contact_idx ON email_messages (contact_id);

CREATE TABLE oauth_states (
  state text PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  provider text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE email_templates (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  subject text NOT NULL,
  body text NOT NULL,
  description text,
$_sync
);
CREATE INDEX email_templates_seq_idx ON email_templates (seq);

CREATE TABLE email_sequences (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  description text,
  steps jsonb NOT NULL,
  active boolean,
$_sync
);
CREATE INDEX email_sequences_seq_idx ON email_sequences (seq);

CREATE TABLE sequence_enrollments (
  id uuid PRIMARY KEY,
  sequence_id uuid NOT NULL,
  contact_id uuid NOT NULL,
  owner_id uuid NOT NULL,
  step integer NOT NULL,
  next_send_at timestamptz,
  status text NOT NULL,
  last_error text,
$_sync
);
CREATE INDEX sequence_enrollments_seq_idx ON sequence_enrollments (seq);
CREATE INDEX sequence_enrollments_due_idx ON sequence_enrollments (next_send_at)
  WHERE status = 'active' AND deleted_at IS NULL;
''');
