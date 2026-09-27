import '../migrations.dart';

/// Abonnement d'agenda (flux ICS) : un jeton par utilisateur (empreinte).
const m0007Calendar = Migration(7, 'calendar', '''

CREATE TABLE calendar_tokens (
  user_id uuid PRIMARY KEY REFERENCES users (id) ON DELETE CASCADE,
  token_hash text NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);
''');
