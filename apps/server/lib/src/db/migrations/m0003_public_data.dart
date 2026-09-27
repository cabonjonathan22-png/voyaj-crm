import '../migrations.dart';

/// Données publiques : configuration des sources et historique des imports.
const m0003PublicData = Migration(3, 'public_data', '''

CREATE TABLE public_data_sources (
  source text PRIMARY KEY,
  enabled boolean NOT NULL DEFAULT false,
  departements jsonb NOT NULL DEFAULT '[]'::jsonb,
  updated_at timestamptz NOT NULL DEFAULT now(),
  updated_by uuid
);

CREATE TABLE public_data_runs (
  id uuid PRIMARY KEY,
  source text NOT NULL,
  trigger text NOT NULL,
  status text NOT NULL,
  started_at timestamptz NOT NULL,
  finished_at timestamptz,
  fetched integer NOT NULL DEFAULT 0,
  created integer NOT NULL DEFAULT 0,
  updated integer NOT NULL DEFAULT 0,
  unchanged integer NOT NULL DEFAULT 0,
  rejected integer NOT NULL DEFAULT 0,
  error text,
  triggered_by uuid
);
CREATE INDEX public_data_runs_source_idx ON public_data_runs (source, started_at DESC);

-- Rapprochement des fiches importées (départements, régions).
CREATE INDEX organisations_kind_dept_idx ON organisations (kind, departement_code);
''');
