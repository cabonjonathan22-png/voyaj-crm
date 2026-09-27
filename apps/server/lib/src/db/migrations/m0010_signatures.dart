import '../migrations.dart';

/// Demandes de signature électronique des devis (Yousign).
const m0010Signatures = Migration(10, 'signatures', '''

CREATE TABLE signature_requests (
  id uuid PRIMARY KEY,
  provider text NOT NULL,
  provider_id text NOT NULL UNIQUE,
  invoice_id uuid NOT NULL,
  contact_id uuid,
  signer_name text NOT NULL,
  signer_email text NOT NULL,
  status text NOT NULL,
  signed_file_id text,
  error text,
  created_by uuid,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX signature_requests_invoice_idx ON signature_requests (invoice_id);
''');
