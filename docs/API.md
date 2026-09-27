# API publique — Voyaj CRM

API REST JSON du serveur Voyaj, pour relier le CRM à d'autres outils (ERP, scripts, Make,
Zapier, entrepôt de données). Toutes les dates sont en ISO 8601 UTC, les dates calendaires en
`AAAA-MM-JJ`, les montants en **centimes** et les clés JSON en `snake_case`.

## Authentification

Créez un **jeton d'API personnel** dans le client : *Paramètres › API et jetons*. Le jeton
(`vpat_…`) n'est affiché qu'une fois ; il agit au nom de son créateur avec les seules
permissions choisies (toujours limitées aux droits actuels de l'utilisateur). Il se révoque à
tout moment.

```
Authorization: Bearer vpat_xxxxxxxxxxxxxxxx
```

Un jeton d'API n'ouvre que `/api/v1/records/…` et `/api/v1/auth/me` (pas de gestion des
utilisateurs, des sessions ni des jetons).

## Enregistrements

`{entité}` : nom d'une entité synchronisée — `organisations`, `contacts`, `positions`,
`pipelines`, `pipeline_stages`, `deals`, `activities`, `attachments`, `tags`, `taggings`,
`custom_fields`, `segments`, `email_templates`, `email_sequences`, `sequence_enrollments`,
`products`, `invoices`, `payments`. Les champs de chaque entité sont ceux de
`packages/shared/lib/src/sync/entities.dart`.

| Méthode | Chemin | Rôle |
|---|---|---|
| GET | `/api/v1/records/{entité}?cursor=0&limit=100` | enregistrements modifiés après `cursor` (supprimés compris), par ordre de modification ; réponse `{records, cursor, has_more}` : rappeler avec le `cursor` renvoyé tant que `has_more` |
| GET | `/api/v1/records/{entité}/{id}` | un enregistrement |
| POST | `/api/v1/records/{entité}` | création (corps : champs ; `id` UUID facultatif) → 201 |
| PATCH | `/api/v1/records/{entité}/{id}` | modification des champs fournis |
| DELETE | `/api/v1/records/{entité}/{id}` | suppression (logique : `deleted_at`) → 204 |

Un enregistrement renvoyé a la forme :

```json
{
  "entity": "organisations",
  "id": "0192…",
  "version": 3,
  "seq": 1842,
  "data": { "name": "Mairie de Rodez", "kind": "commune", "status": "client", "deleted_at": null, "…": "…" },
  "field_meta": { "name": { "hlc": "…", "version": 3, "user_id": "…" } }
}
```

Les écritures suivent exactement les règles des postes : permissions, validation métier (erreur
422 avec `issues` par champ), verrouillage des documents émis, journal d'audit et
synchronisation immédiate vers les postes connectés.

## Autres intégrations

- **Webhooks sortants** (*Connecteurs › Webhooks sortants*) : POST JSON signé
  (`x-voyaj-signature: sha256=<HMAC du corps>`) à chaque changement des entités choisies.
- **Webhook entrant** (*Connecteurs*, type « Webhook entrant ») : `POST /api/v1/hooks/{id}` avec
  `Authorization: Bearer <jeton du connecteur>`, corps objet ou liste JSON, converti selon le
  mappage du connecteur.
- **Agenda** : flux iCalendar personnel (*Agenda › Abonnement*).
