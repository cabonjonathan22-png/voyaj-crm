import '../migrations.dart';

/// Colonnes techniques communes aux entités synchronisées.
const _sync = '''
  version bigint NOT NULL,
  seq bigint NOT NULL,
  field_meta jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL,
  created_by uuid,
  updated_at timestamptz NOT NULL,
  updated_by uuid,
  deleted_at timestamptz''';

/// CRM cœur : organisations, contacts, postes et mandats, pipelines, affaires,
/// activités, fichiers, tags appliqués, champs personnalisés, segments.
///
/// Les références entre entités synchronisées ne portent pas de clé
/// étrangère : l'ordre d'arrivée des opérations hors ligne n'est pas
/// garanti entre postes, et les suppressions sont logiques. Le client gère
/// les références orphelines.
const m0002Crm = Migration(2, 'crm', '''

CREATE TABLE organisations (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  kind text NOT NULL,
  status text NOT NULL,
  siren text,
  siret text,
  insee_code text,
  population integer,
  parent_id uuid,
  departement_code text,
  region_code text,
  address text,
  postal_code text,
  city text,
  latitude double precision,
  longitude double precision,
  phone text,
  email text,
  website text,
  description text,
  owner_id uuid,
  custom_fields jsonb,
  source text,
  source_ref text,
  collected_at timestamptz,
$_sync
);
CREATE INDEX organisations_seq_idx ON organisations (seq);
CREATE INDEX organisations_siren_idx ON organisations (siren) WHERE siren IS NOT NULL;
CREATE INDEX organisations_insee_idx ON organisations (insee_code) WHERE insee_code IS NOT NULL;
CREATE INDEX organisations_source_idx ON organisations (source, source_ref) WHERE source_ref IS NOT NULL;
CREATE INDEX organisations_parent_idx ON organisations (parent_id);

CREATE TABLE contacts (
  id uuid PRIMARY KEY,
  civility text,
  first_name text,
  last_name text NOT NULL,
  email text,
  phone text,
  mobile text,
  organisation_id uuid,
  job_title text,
  service text,
  notes text,
  do_not_contact boolean,
  owner_id uuid,
  custom_fields jsonb,
  source text,
  source_ref text,
  collected_at timestamptz,
$_sync
);
CREATE INDEX contacts_seq_idx ON contacts (seq);
CREATE INDEX contacts_organisation_idx ON contacts (organisation_id);
CREATE INDEX contacts_email_idx ON contacts (lower(email)) WHERE email IS NOT NULL;

CREATE TABLE positions (
  id uuid PRIMARY KEY,
  contact_id uuid NOT NULL,
  organisation_id uuid NOT NULL,
  job_title text,
  service text,
  is_elected boolean NOT NULL,
  mandate_role text,
  delegation text,
  start_date date,
  end_date date,
  source text,
  source_ref text,
  collected_at timestamptz,
$_sync
);
CREATE INDEX positions_seq_idx ON positions (seq);
CREATE INDEX positions_contact_idx ON positions (contact_id);
CREATE INDEX positions_organisation_idx ON positions (organisation_id);

CREATE TABLE pipelines (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  kind text NOT NULL,
  sort_order double precision,
  archived boolean,
$_sync
);
CREATE INDEX pipelines_seq_idx ON pipelines (seq);

CREATE TABLE pipeline_stages (
  id uuid PRIMARY KEY,
  pipeline_id uuid NOT NULL,
  name text NOT NULL,
  sort_order double precision,
  probability integer,
  color text,
  outcome text NOT NULL,
$_sync
);
CREATE INDEX pipeline_stages_seq_idx ON pipeline_stages (seq);

CREATE TABLE deals (
  id uuid PRIMARY KEY,
  title text NOT NULL,
  pipeline_id uuid NOT NULL,
  stage_id uuid NOT NULL,
  organisation_id uuid,
  contact_id uuid,
  amount_cents bigint,
  probability integer,
  expected_close_date date,
  status text NOT NULL,
  closed_at timestamptz,
  sort_order double precision,
  owner_id uuid,
  description text,
  custom_fields jsonb,
$_sync
);
CREATE INDEX deals_seq_idx ON deals (seq);
CREATE INDEX deals_organisation_idx ON deals (organisation_id);

CREATE TABLE activities (
  id uuid PRIMARY KEY,
  kind text NOT NULL,
  subject text NOT NULL,
  body text,
  organisation_id uuid,
  contact_id uuid,
  deal_id uuid,
  starts_at timestamptz,
  ends_at timestamptz,
  due_at timestamptz,
  remind_at timestamptz,
  done_at timestamptz,
  assignee_id uuid,
  owner_id uuid,
$_sync
);
CREATE INDEX activities_seq_idx ON activities (seq);
CREATE INDEX activities_organisation_idx ON activities (organisation_id);
CREATE INDEX activities_contact_idx ON activities (contact_id);

CREATE TABLE attachments (
  id uuid PRIMARY KEY,
  file_id text NOT NULL,
  file_name text NOT NULL,
  size bigint NOT NULL,
  mime_type text,
  organisation_id uuid,
  contact_id uuid,
  deal_id uuid,
  activity_id uuid,
$_sync
);
CREATE INDEX attachments_seq_idx ON attachments (seq);

CREATE TABLE taggings (
  id uuid PRIMARY KEY,
  tag_id uuid NOT NULL,
  entity text NOT NULL,
  record_id uuid NOT NULL,
$_sync
);
CREATE INDEX taggings_seq_idx ON taggings (seq);
CREATE INDEX taggings_record_idx ON taggings (record_id);

CREATE TABLE custom_fields (
  id uuid PRIMARY KEY,
  entity text NOT NULL,
  key text NOT NULL,
  label text NOT NULL,
  type text NOT NULL,
  options jsonb,
  sort_order double precision,
$_sync
);
CREATE INDEX custom_fields_seq_idx ON custom_fields (seq);

CREATE TABLE segments (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  entity text NOT NULL,
  description text,
  config jsonb NOT NULL,
$_sync
);
CREATE INDEX segments_seq_idx ON segments (seq);

-- Fichiers téléversés (contenu sur disque, adressé par SHA-256).
CREATE TABLE files (
  id text PRIMARY KEY,
  size bigint NOT NULL,
  mime_type text,
  uploaded_by uuid,
  created_at timestamptz NOT NULL DEFAULT now()
);
''');
