import '../migrations.dart';

/// Jetons d'API personnels (API publique) : empreinte, permissions
/// accordées, expiration, révocation.
const m0008ApiTokens = Migration(8, 'api_tokens', '''

CREATE TABLE api_tokens (
  id uuid PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  name text NOT NULL,
  token_hash text NOT NULL UNIQUE,
  permissions text[] NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  last_used_at timestamptz,
  expires_at timestamptz,
  revoked_at timestamptz
);
CREATE INDEX api_tokens_user_idx ON api_tokens (user_id);
''');
