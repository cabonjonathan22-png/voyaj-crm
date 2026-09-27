import '../migrations.dart';

/// Connecteurs (sources externes, webhooks entrants), historique des
/// exécutions et webhooks sortants.
const m0006Connectors = Migration(6, 'connectors', '''

CREATE TABLE connectors (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  kind text NOT NULL,
  config jsonb NOT NULL DEFAULT '{}'::jsonb,
  mapping jsonb NOT NULL DEFAULT '{}'::jsonb,
  secret_enc text,
  webhook_token_hash text,
  enabled boolean NOT NULL DEFAULT true,
  schedule_minutes integer,
  last_run_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  created_by uuid,
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE connector_runs (
  id uuid PRIMARY KEY,
  connector_id uuid NOT NULL REFERENCES connectors (id) ON DELETE CASCADE,
  trigger text NOT NULL,
  status text NOT NULL,
  started_at timestamptz NOT NULL,
  finished_at timestamptz,
  fetched integer NOT NULL DEFAULT 0,
  created integer NOT NULL DEFAULT 0,
  updated integer NOT NULL DEFAULT 0,
  unchanged integer NOT NULL DEFAULT 0,
  rejected integer NOT NULL DEFAULT 0,
  problems jsonb NOT NULL DEFAULT '[]'::jsonb,
  error text
);
CREATE INDEX connector_runs_connector_idx
  ON connector_runs (connector_id, started_at DESC);

CREATE TABLE webhooks (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  url text NOT NULL,
  entities text[] NOT NULL,
  secret_enc text,
  enabled boolean NOT NULL DEFAULT true,
  last_seq bigint NOT NULL,
  last_delivery_at timestamptz,
  last_status integer,
  last_error text,
  failures integer NOT NULL DEFAULT 0,
  next_attempt_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  created_by uuid
);
''');
