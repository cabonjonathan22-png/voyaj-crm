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

/// Facturation : produits, devis / factures / avoirs, paiements
/// (synchronisés) ; paramètres de facturation et compteurs de
/// numérotation (continue, sans trou, par type et par année).
const m0005Billing = Migration(5, 'billing', '''

CREATE TABLE products (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  description text,
  unit_price_cents bigint,
  vat_rate integer,
  unit text,
  account_code text,
  active boolean,
$_sync
);
CREATE INDEX products_seq_idx ON products (seq);

CREATE TABLE invoices (
  id uuid PRIMARY KEY,
  kind text NOT NULL,
  status text NOT NULL,
  number text,
  subject text,
  organisation_id uuid,
  contact_id uuid,
  deal_id uuid,
  quote_id uuid,
  original_invoice_id uuid,
  issue_date date,
  service_date date,
  due_date date,
  valid_until date,
  lines jsonb NOT NULL,
  total_ht_cents bigint,
  total_vat_cents bigint,
  total_ttc_cents bigint,
  vat_breakdown jsonb,
  buyer jsonb,
  seller jsonb,
  notes text,
  payment_terms text,
  buyer_reference text,
  service_code text,
  pdf_file_id text,
  chorus_flux text,
  chorus_status text,
  sent_at timestamptz,
  owner_id uuid,
$_sync
);
CREATE INDEX invoices_seq_idx ON invoices (seq);
CREATE UNIQUE INDEX invoices_number_idx ON invoices (number) WHERE number IS NOT NULL;
CREATE INDEX invoices_organisation_idx ON invoices (organisation_id);

CREATE TABLE payments (
  id uuid PRIMARY KEY,
  invoice_id uuid NOT NULL,
  amount_cents bigint NOT NULL,
  paid_on date,
  method text,
  reference text,
  notes text,
$_sync
);
CREATE INDEX payments_seq_idx ON payments (seq);
CREATE INDEX payments_invoice_idx ON payments (invoice_id);

CREATE TABLE document_counters (
  kind text NOT NULL,
  year integer NOT NULL,
  last integer NOT NULL,
  PRIMARY KEY (kind, year)
);

-- Paramètres (une seule ligne) ; secrets Chorus Pro chiffrés.
CREATE TABLE billing_settings (
  id integer PRIMARY KEY CHECK (id = 1),
  settings jsonb NOT NULL,
  chorus_password_enc text,
  piste_client_secret_enc text,
  updated_at timestamptz NOT NULL DEFAULT now(),
  updated_by uuid
);
''');
