import '../migrations.dart';

/// Veille des appels d'offres (BOAMP) : configuration et avis repérés.
const m0009Tenders = Migration(9, 'tenders', '''

CREATE TABLE tender_watch (
  id integer PRIMARY KEY CHECK (id = 1),
  enabled boolean NOT NULL DEFAULT false,
  keywords text[] NOT NULL DEFAULT '{}',
  departements text[] NOT NULL DEFAULT '{}',
  last_run_at timestamptz,
  last_error text
);

CREATE TABLE tenders (
  id uuid PRIMARY KEY,
  ref text NOT NULL UNIQUE,
  title text NOT NULL,
  buyer text,
  published_on date NOT NULL,
  deadline timestamptz,
  departements text[] NOT NULL DEFAULT '{}',
  nature text,
  procedure text,
  url text,
  descriptors text[] NOT NULL DEFAULT '{}',
  status text NOT NULL DEFAULT 'new',
  deal_id uuid,
  status_by uuid,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX tenders_published_idx ON tenders (published_on DESC);
''');
