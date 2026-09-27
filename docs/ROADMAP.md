# Feuille de route — Voyaj CRM

## Phases

| Phase | Contenu | État |
|---|---|---|
| 1 — Socle | Monorepo, serveur + PostgreSQL, auth (rôles, 2FA, sessions), design system, shell, Ctrl+K, base locale chiffrée, synchro hors ligne (tags), service Windows, Docker, **installeur client** | ✅ Terminée |
| 2 — CRM cœur | Organisations, contacts, élus, pipelines Kanban, activités, tâches, tags appliqués, champs personnalisés, segments, recherche globale, carte, import CSV, doublons, **fichiers joints**, **onglets de travail** | ✅ Terminée |
| 3 — Données publiques | `packages/fr_public_data`, import des collectivités (régions, départements, EPCI, communes), festivals, AOM, mises à jour planifiées | ✅ Terminée (à valider sur les API réelles, voir ci-dessous) |
| 4 — Emails | IMAP/SMTP, OAuth Gmail/Microsoft, boîte de réception, modèles, séquences | ✅ Terminée (OAuth à configurer, voir ci-dessous) |
| 5 — Facturation & compta | Devis/factures/avoirs, Factur-X, Chorus Pro, FEC, TVA — **validation expert-comptable** | ✅ Terminée (à valider par l'expert-comptable, voir ci-dessous) |
| 6 — Connecteurs | Supabase, Firebase, MySQL, MongoDB, REST, webhooks, éditeur de mapping | ✅ Terminée (à valider sur vos sources réelles, voir ci-dessous) |
| 7 — Avancé | Tableaux de bord, BOAMP, agenda, signature, IA, API publique, sauvegardes, RGPD | ✅ Terminée (services externes à configurer, voir ci-dessous) |

## Éléments reportés ou à compléter

### Déploiement et distribution
- **Hébergement** : serveur de test en ligne sur Google Cloud (Paris, `https://voyaj-crm.duckdns.org`, Docker + Caddy, sauvegarde quotidienne locale à la VM). Production prévue chez OVH : ajouter une copie des sauvegardes hors de la machine.
- **Signature de code** de l'installeur (certificat OV/EV) pour supprimer l'avertissement SmartScreen.
- **Mise à jour automatique** du client (vérification de version au démarrage + téléchargement).
- Service Windows : exécuter sous un compte dédié plutôt que LocalSystem. Sur le poste de
  développement, PostgreSQL (portable) démarre à l'ouverture de session : pour un serveur de
  production sous Windows, installer PostgreSQL en service (installeur EDB).
- Runner **macOS** à générer sur un Mac (`flutter create --platforms macos .` dans
  `apps/client` : l'outil Flutter sous Windows échoue sur les icônes macOS) ; build Linux non testé.

### Client
- Réordonner les colonnes par glisser-déposer (la configuration `columnOrder` est prête).
- Traduire les libellés internes du design system (barre d'outils des tableaux, palette, aide
  des raccourcis) via ARB ; ajouter `app_en.arb`.
- Rafraîchir les permissions en temps réel (aujourd'hui : au démarrage et à la reconnexion).
- Si le coffre de l'OS est réinitialisé, la base locale est recréée : les modifications non
  envoyées sont perdues (cas rare) ; prévoir un export de secours.

### CRM (après la Phase 2)
- **Responsable** (`owner_id`) : renseigné automatiquement avec l'utilisateur qui crée la fiche ;
  choix d'un autre responsable et filtre « mes fiches » à ajouter (liste des utilisateurs à
  mettre en cache localement : elle n'est aujourd'hui lisible qu'en ligne).
- **Import Excel** (`.xlsx`) : seul le CSV est pris en charge (Excel sait l'exporter).
- **Carte** : serveur de tuiles configurable (OpenStreetMap par défaut, usage modéré exigé par sa
  politique).
- **Doublons ignorés** : mémorisés par poste (clé locale) ; à partager si besoin.
- **Rappels** : notification dans l'application uniquement (pas de notification système Windows).
- Affaires : pas de liste tabulaire dédiée (Kanban, fiches et recherche globale).
- Tags : unicité des noms non imposée ; l'import réutilise les tags existants par nom normalisé.
- Fichiers joints : pas de purge des fichiers qui ne sont plus référencés ; pas de cache local
  (téléchargement à la demande, connexion requise).

### Données publiques (Phase 3)
- **À valider au premier import réel** : le développement s'est fait sans accès réseau à
  `geo.api.gouv.fr`, `transport.data.gouv.fr` et `data.culture.gouv.fr` (jeux d'essai écrits
  d'après la documentation des API). Les formats de geo.api.gouv.fr sont stables ; ceux des AOM
  (`/api/aoms/geojson`) et du Panorama des festivals (export JSON) sont lus avec des noms de
  champs tolérants : en cas d'échec, l'import s'arrête avec un message (« aucune donnée ») visible
  dans Administration → Données publiques. Adapter alors `packages/fr_public_data/lib/src/parsers.dart`.
- Contacts publics (maires, élus : Répertoire national des élus) : non importés — données
  personnelles, à décider avec le DPO (base légale, information des personnes).
- Contours géographiques (polygones des communes / EPCI) non importés.
- Un seul serveur exécute les imports (file en mémoire) ; plusieurs instances nécessiteraient un
  verrou en base.

### Emails (Phase 4)
- **À configurer / valider** : applications OAuth Google et Microsoft (identifiants dans la
  configuration du serveur, `VOYAJ_PUBLIC_URL` joignable par le navigateur). Google : l'accès
  « https://mail.google.com/ » est une portée restreinte — application « interne » (Google
  Workspace) ou validation Google requise pour des comptes externes. Les échanges IMAP / SMTP
  réels n'ont pas pu être testés dans l'environnement de développement (serveur de messagerie
  simulé dans les tests).
- Pièces jointes des emails : non relevées ni envoyées (texte seulement) ; corps HTML converti en
  texte.
- Dossier « Envoyés » du fournisseur : les emails envoyés depuis Voyaj n'y sont pas copiés
  (Gmail et Microsoft le font automatiquement via SMTP authentifié ; pas les autres).
- Relève limitée à la boîte de réception (pas les autres dossiers), 200 messages par passage,
  30 jours d'historique au premier passage.
- Désinscription (lien « se désabonner ») des séquences : à ajouter avant tout envoi en masse.

### Facturation (Phase 5)
- **À valider par l'expert-comptable** avant la première facture réelle : mentions légales,
  plan de comptes et journaux du FEC (ventes « VE », banque « BQ », TVA 44571x par taux), choix
  TVA sur les débits / sur les encaissements, traitement des avoirs et des acomptes.
- **Factur-X** : profil EN 16931 généré et PDF/A-3 embarquant `factur-x.xml` ; à passer au
  validateur officiel (FNFE-MPE) et à tester sur la qualification Chorus Pro avant la production.
- **Chorus Pro** : dépôt du PDF (API PISTE « déposer flux ») seulement ; le suivi du traitement
  (consulter le compte rendu, statuts « mise à disposition », « rejetée »…) reste à ajouter
  (`chorus_status` vaut `deposited` après dépôt).
- **Plateformes agréées (PA / PDP)** : la réforme de la facturation électronique B2B (réception
  obligatoire dès septembre 2026, émission 2026-2027 selon la taille) impose de passer par une
  plateforme agréée ; le connecteur vers la plateforme choisie reste à écrire (le Factur-X produit
  est le format d'échange).
- Acomptes, factures multidevises, escompte, relances automatiques d'impayés, envoi du PDF par
  email depuis la fiche : non traités.
- Aperçu PDF d'un brouillon (avant émission) : non disponible ; seul le PDF émis est téléchargé.
- Police du PDF : Liberation Sans intégrée (licence OFL).

### Connecteurs (Phase 6)
- **À valider sur des sources réelles** : MySQL (`mysql_client_plus`) et MongoDB (`mongo_dart`)
  n'ont pas pu être testés contre de vrais serveurs dans l'environnement de développement
  (seuls la validation de configuration et le mappage sont testés) ; REST, Supabase et Firestore
  sont testés sur des réponses simulées.
- Firebase : lecture par clé d'API web (règles de sécurité autorisant la lecture) ou jeton
  « Bearer » fourni ; l'authentification par compte de service (JWT signé) reste à ajouter.
- Import complet à chaque exécution (20 000 enregistrements maximum) : pas d'import
  incrémental (« modifiés depuis »), pas de suppression des fiches disparues de la source.
- Entités alimentables : organisations et contacts (champs de provenance) ; affaires et
  activités à ajouter si besoin (migration des colonnes de provenance).
- Écriture vers les sources (synchronisation bidirectionnelle) : non prévue ; les webhooks
  sortants couvrent l'envoi des changements.
- Webhooks sortants : pas de liste des livraisons individuelles (dernier état seulement).

### Avancé (Phase 7)
- **BOAMP** : noms des champs de l'API Opendatasoft de la DILA (`idweb`, `objet`, `nomacheteur`,
  `dateparution`, `datelimitereponse`, `code_departement`…) repris de la documentation, non
  vérifiés en réel (réseau bloqué en développement) ; le parseur tolère des variantes. À
  valider à la première recherche.
- **Signature électronique** : Yousign v3 testé sur réponses simulées ; à valider en
  environnement de test Yousign (clé sandbox), en particulier la détection de l'ancre
  `{{s1|signature|180|48}}` placée dans le PDF des devis. Un seul signataire par devis.
- **Assistant IA** : synthèse d'organisation et brouillon d'email (Claude, API Anthropic en HTTP,
  pas de SDK Dart officiel). Pas encore : réponses en flux, recherche dans toute la base,
  qualification automatique des avis BOAMP.
- **Tableau de bord** : indicateurs fixes ; tableaux de bord personnalisables (widgets,
  filtres par commercial, période) à ajouter.
- **Agenda** : vue mensuelle ; vues semaine / jour et glisser-déposer à ajouter ; pas de
  synchronisation bidirectionnelle avec Outlook / Google (abonnement ICS en lecture).
- **API publique** : pas de limitation de débit par jeton ni de webhooks par jeton ;
  documentation OpenAPI à générer.
- **Sauvegardes** : non chiffrées par Voyaj (chiffrer le stockage hors site) ; pas de
  restauration depuis l'interface.

### Serveur
- Limiteur de tentatives en mémoire : à déplacer en base (ou Redis) si plusieurs instances.
- Purge planifiée des sessions expirées, rétention de `change_log` et `sync_ops`.

## Décisions (Phase 1)

| Décision | Raison |
|---|---|
| **shelf** plutôt que Serverpod | Un seul jeu de modèles (freezed, dans `shared`) et un moteur de synchro générique par champ, que l'ORM de Serverpod n'aurait pas simplifié. |
| **HLC** plutôt que l'horloge murale pour le LWW | Robuste aux horloges de PC décalées. |
| Jetons **opaques** hachés plutôt que JWT | Révocation immédiate, rien à signer, rien à divulguer. |
| **SQLite3 Multiple Ciphers** pour la base locale | Données personnelles sur des portables (RGPD). |
| Premier administrateur via la **CLI** (`create-admin`) | Pas d'écran d'initialisation exposé sur le réseau. |
| Mono-structure (pas de multi-tenant) | Un seul organisme : Voyaj. |
| **WinSW** pour le service Windows, **Inno Setup** pour l'installeur client | Outils libres, éprouvés, sans droits admin pour le client. |
| Runtime Visual C++ embarqué dans l'installeur | Les PC neufs ne l'ont pas toujours. |
| Mise à jour de Flutter 3.44 → 3.47 (Dart 3.13) | Bug du compilateur incrémental de Dart 3.12.2 empêchant `build_runner`, `dart test` et Melos. |

## Décisions (Phase 2)

| Décision | Raison |
|---|---|
| Pont local **générique** piloté par `EntitySchema` (un seul `LocalEntity`, SQL construit à partir des noms du schéma) | 11 entités ajoutées sans code de synchronisation spécifique ; les tables Drift restent typées pour les lectures. |
| `RecordStore` : écriture locale + outbox dans une transaction, **seuls les champs modifiés** partent | Moins de conflits (fusion par champ côté serveur), validation par les règles partagées avant écriture. |
| Formulaires **déclaratifs** (`FormFieldDef`) | Même composant pour toutes les fiches, champs personnalisés ajoutés automatiquement. |
| Recherche, filtres, doublons et carte calculés **sur la base locale** | Fonctionne hors ligne, sans charge serveur ; volumes de la Phase 2 (milliers de fiches) compatibles. |
| Segments = critères d'une vue de tableau (recherche, filtres, tri) enregistrés comme entité synchronisée | Partagés avec l'équipe, réutilisent le moteur de filtres des tableaux. |
| Fusion de doublons : master complété, références (contacts, postes, affaires, activités, fichiers, tags, parent) reportées, doublons supprimés logiquement | Tout passe par la synchronisation et le journal d'audit ; aucune perte de lien. |
| Fichiers joints adressés par **SHA-256** sur disque (`VOYAJ_DATA_DIR`), métadonnées synchronisées (`attachments`) | Déduplication, contenu jamais modifié ; sauvegarde = base + dossier. |
| Pipelines par défaut (Collectivités, Festivals) créés à la demande depuis le client | Pas de données imposées par une migration ; étapes modifiables. |
| Carte **flutter_map** + OpenStreetMap | Libre, sans clé d'API. |
| Base locale v2 : curseur de synchro remis à zéro à la migration | Les postes existants reçoivent les données CRM déjà présentes sur le serveur. |

## Décisions (Phase 3)

| Décision | Raison |
|---|---|
| Imports exécutés **par le serveur** (à la demande ou chaque nuit, `VOYAJ_PUBLIC_DATA_HOUR`) | Une seule lecture des sources pour toute l'équipe, pas de dépendance réseau des postes, historique centralisé. |
| Écritures « système » par le moteur de synchronisation (`upsertFromSource`) | Les fiches importées se synchronisent comme les autres ; un journal d'audit **par import** (pas par fiche). |
| Fiches retrouvées par `source` + `source_ref`, sinon **rapprochées** d'une fiche saisie (code INSEE, SIREN, code département/région, même type) | Pas de doublon avec les communes déjà créées à la main ou par import CSV. |
| Un champ dont la dernière écriture vient d'un utilisateur n'est **jamais écrasé** ; une fiche supprimée n'est pas recréée | Les corrections de l'équipe priment sur la source. |
| Périmètre par **départements** (communes : 35 000 fiches sinon) | Volume adapté aux postes et à la carte. |
| Hiérarchie par `parent_id` : commune → EPCI → département → région | Réutilise le rattachement des organisations (fiche « Rattachement »). |
| Carte : regroupement des marqueurs par grille au-delà de 300 points | Lisible et fluide avec des milliers de communes, sans dépendance supplémentaire. |

## Décisions (Phase 4)

| Décision | Raison |
|---|---|
| Comptes et relève **côté serveur** (secrets chiffrés par la clé maître) | Les postes n'ont aucun mot de passe de messagerie ; relève et séquences fonctionnent même postes éteints. |
| Messages **privés** (propriétaire du compte), en ligne ; seuls les échanges avec un **contact du CRM** deviennent des activités synchronisées | Respect de la vie privée et du RGPD ; l'historique commercial reste partagé. |
| Contact reconnu par l'adresse email (expéditeur ou premier destinataire) | Simple et fiable ; les autres messages ne sont pas journalisés. |
| Modèles, séquences et inscriptions = entités synchronisées ; **envois par le serveur** (toutes les 5 min) depuis le compte de la personne qui inscrit | Préparation hors ligne, envoi fiable, un seul expéditeur visible pour le contact. |
| Séquence arrêtée dès qu'un email du contact est reçu ; contact « ne pas contacter » ou sans email → arrêt avec motif | Évite les relances malvenues. |
| OAuth (flux « code » avec retour sur le serveur) + XOAUTH2 en IMAP/SMTP ; jeton de rafraîchissement chiffré, jeton d'accès mis en cache | Pas de mot de passe stocké pour Gmail / Microsoft 365. |
| `enough_mail` (Dart pur) pour IMAP, SMTP et MIME | Aucune dépendance native, fonctionne sous Windows et Linux. |

## Décisions (Phase 5)

| Décision | Raison |
|---|---|
| Brouillons = entités synchronisées (préparés hors ligne) ; **émission par le serveur** (`POST /billing/documents/{id}/issue`) | La numérotation continue et sans trou exige une seule autorité ; un poste hors ligne ne peut pas attribuer de numéro. |
| Numéro `F2026-00001` (préfixe D / F / A, année, séquence par type et par année) attribué dans une transaction sérialisée (`document_counters` + verrou), avec PDF, totaux et instantanés vendeur / acheteur | Aucun trou ni doublon, même en cas d'émissions simultanées ; un échec annule tout. |
| Document émis **verrouillé** : les champs du contenu sont refusés à la synchronisation (`EntitySchema.lockedFields`), seul l'état reste modifiable ; champs attribués par le serveur interdits aux postes (`serverFields`) | Inaltérabilité exigée (CGI art. 289) ; une erreur se corrige par un avoir. |
| Montants en **centimes**, TVA en points de base (2000 = 20 %) ; arrondi par taux sur le total HT de chaque taux | Pas d'erreur de virgule flottante ; règle de calcul conforme à EN 16931. |
| `packages/invoicing` (Dart pur, partagé client / serveur) : totaux, Factur-X CII EN 16931, PDF/A-3 (`pdf`), FEC, TVA | Même calcul pour l'aperçu du poste et le document émis. |
| `pdf` < 3.13 | La 3.13 exige `xml` 7, incompatible avec `enough_mail` (xml 6). |
| Secrets Chorus Pro (mot de passe du compte technique, secret PISTE) chiffrés par la clé maître, jamais renvoyés | Même règle que les comptes email. |
| FEC et TVA calculés à la demande depuis les documents émis et les paiements | Pas de double saisie ; l'export reflète toujours l'état validé. |

## Décisions (Phase 6)

| Décision | Raison |
|---|---|
| `packages/connectors` (Dart pur) : une interface `RecordSource` par type de source, mappage déclaratif (chemin, transformation, valeur fixe) | Ajouter une source = une classe ; le mappage est identique pour toutes. |
| Les connecteurs tournent **sur le serveur** (secrets chiffrés), imports manuels ou planifiés (15 min à 7 jours), historique des exécutions | Les postes n'ont aucun identifiant de base externe ; imports possibles postes éteints. |
| Écriture par `SyncService.upsertFromSource` (source `connector:<id>`, identifiant source `source_ref`) | Même mécanisme que les données publiques : fiches synchronisées, champ modifié par un utilisateur jamais écrasé, fiche supprimée jamais recréée. |
| Rapprochement facultatif avec une fiche existante (SIREN, SIRET, code INSEE, email) ; rattachement des contacts à une organisation par valeur | Évite les doublons dès le premier import. |
| MySQL : une seule requête SELECT (pas de `;`) ; lecture seule | Le connecteur ne peut pas modifier la base source. |
| Webhook entrant authentifié par jeton (empreinte SHA-256 stockée, affiché une fois), 5 Mo et 5 000 enregistrements maximum par appel | Pas de session utilisateur pour un système externe ; jeton révocable. |
| Webhooks sortants : lots de 100 derniers états (curseur `seq`), signature HMAC-SHA256 (`x-voyaj-signature`), nouvel essai exponentiel jusqu'à 1 h | Livraison au moins une fois et dans l'ordre, vérifiable par le destinataire. |

## Décisions (Phase 7)

| Décision | Raison |
|---|---|
| Tableau de bord calculé sur le poste (données locales) | Disponible hors ligne, sans requête serveur ; même source que les listes. |
| Agenda par abonnement ICS (jeton personnel révocable dans l'URL) | Compatible avec tous les agendas sans OAuth ; lecture seule, aucune donnée ne revient dans Voyaj. |
| API publique = jetons personnels `vpat_` (empreinte stockée, permissions ⊂ droits actuels) et points d'accès `/records` qui passent par la même écriture que la synchronisation | Mêmes contrôles (droits, validation, verrous, audit) que les postes ; un jeton ne peut pas élever ses droits ni gérer d'autres jetons. |
| RGPD : anonymisation plutôt que suppression physique (historique des modifications et emails effacés, fiche anonyme conservée) | Garde la cohérence des affaires et statistiques ; empêche une réimportation (champs marqués comme saisis par un utilisateur). |
| Sauvegardes par `pg_dump -Fc` + copie incrémentale des fichiers (adressés par empreinte) | Format standard restaurable par `pg_restore` ; fichiers copiés une seule fois. |
| Veille BOAMP côté serveur (table non synchronisée), suivi = création d'une affaire | Volume et renouvellement des avis importants ; seule l'affaire, utile hors ligne, est synchronisée. |
| Signature par Yousign (API v3, eIDAS signature simple, code par email) avec ancre dans le PDF du devis | Prestataire français ; l'ancre évite de coder la position de la signature. |
| Assistant IA : Claude (`claude-opus-5`), réflexion adaptative, effort moyen, repli serveur `fallbacks: "default"` ; appels côté serveur uniquement, désactivé sans `ANTHROPIC_API_KEY` | Clé jamais sur les postes ; seules les données de la fiche concernée sont envoyées ; sortie structurée (JSON Schema) pour les brouillons d'email. |

