/// Énumérations métier du CRM. La clé (`key`) est la valeur stockée et
/// synchronisée ; elle ne doit jamais changer. Le libellé est affiché.
library;

/// Valeur énumérée avec clé stable et libellé français.
abstract interface class KeyedEnum {
  String get key;
  String get label;
}

/// Retrouve une valeur d'énumération par sa clé.
T? enumByKey<T extends KeyedEnum>(List<T> values, String? key) =>
    key == null ? null : values.where((v) => v.key == key).firstOrNull;

Set<String> keysOf(List<KeyedEnum> values) => {for (final v in values) v.key};

/// Type d'organisation.
enum OrganisationKind implements KeyedEnum {
  commune('commune', 'Commune / mairie'),
  epci('epci', 'EPCI (communauté de communes, d\'agglo…)'),
  metropole('metropole', 'Métropole'),
  departement('departement', 'Département'),
  region('region', 'Région'),
  aom('aom', 'AOM (autorité organisatrice de la mobilité)'),
  syndicat('syndicat', 'Syndicat mixte'),
  festival('festival', 'Festival / événement'),
  entreprise('entreprise', 'Entreprise'),
  association('association', 'Association'),
  officeTourisme('office_tourisme', 'Office de tourisme'),
  autre('autre', 'Autre');

  const OrganisationKind(this.key, this.label);

  @override
  final String key;
  @override
  final String label;

  /// Collectivité territoriale ou groupement public.
  bool get isPublic => const {
    commune,
    epci,
    metropole,
    departement,
    region,
    aom,
    syndicat,
  }.contains(this);
}

/// Statut commercial d'une organisation (couleur sur la carte).
enum OrganisationStatus implements KeyedEnum {
  aProspecter('a_prospecter', 'À prospecter'),
  contacte('contacte', 'Contacté'),
  enDiscussion('en_discussion', 'En discussion'),
  partenaire('partenaire', 'Partenaire'),
  client('client', 'Client'),
  perdu('perdu', 'Perdu'),
  inactif('inactif', 'Inactif');

  const OrganisationStatus(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Service d'un contact au sein de son organisation.
enum ContactService implements KeyedEnum {
  elus('elus', 'Élus'),
  direction('direction', 'Direction générale (DGS)'),
  mobilite('mobilite', 'Mobilité / transports'),
  tourisme('tourisme', 'Tourisme'),
  culture('culture', 'Culture / événementiel'),
  communication('communication', 'Communication'),
  technique('technique', 'Services techniques'),
  developpement('developpement', 'Développement économique'),
  environnement('environnement', 'Environnement / transition'),
  autre('autre', 'Autre');

  const ContactService(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Fonction élective (mandat).
enum MandateRole implements KeyedEnum {
  maire('maire', 'Maire'),
  adjoint('adjoint', 'Adjoint(e) au maire'),
  conseillerMunicipal('conseiller_municipal', 'Conseiller(ère) municipal(e)'),
  president('president', 'Président(e)'),
  vicePresident('vice_president', 'Vice-président(e)'),
  conseillerCommunautaire(
    'conseiller_communautaire',
    'Conseiller(ère) communautaire',
  ),
  conseillerDepartemental(
    'conseiller_departemental',
    'Conseiller(ère) départemental(e)',
  ),
  conseillerRegional('conseiller_regional', 'Conseiller(ère) régional(e)'),
  autre('autre', 'Autre mandat');

  const MandateRole(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Type de pipeline commercial.
enum PipelineKind implements KeyedEnum {
  collectivites('collectivites', 'Collectivités'),
  festivals('festivals', 'Festivals'),
  partenaires('partenaires', 'Partenaires'),
  autre('autre', 'Autre');

  const PipelineKind(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Issue d'une étape de pipeline.
enum StageOutcome implements KeyedEnum {
  open('open', 'En cours'),
  won('won', 'Gagnée'),
  lost('lost', 'Perdue');

  const StageOutcome(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Type d'activité.
enum ActivityKind implements KeyedEnum {
  note('note', 'Note'),
  call('call', 'Appel'),
  meeting('meeting', 'Rendez-vous'),
  task('task', 'Tâche'),
  email('email', 'Email');

  const ActivityKind(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Type d'un champ personnalisé.
enum CustomFieldType implements KeyedEnum {
  text('text', 'Texte'),
  number('number', 'Nombre'),
  date('date', 'Date'),
  boolean('boolean', 'Oui / non'),
  select('select', 'Liste de choix'),
  url('url', 'Lien');

  const CustomFieldType(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Entités auxquelles on peut appliquer tags, champs personnalisés et
/// segments.
enum CrmEntity implements KeyedEnum {
  organisations('organisations', 'Organisations'),
  contacts('contacts', 'Contacts'),
  deals('deals', 'Affaires');

  const CrmEntity(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Régions françaises (code INSEE → nom), pour les filtres et la
/// hiérarchie territoriale.
const frenchRegions = {
  '01': 'Guadeloupe',
  '02': 'Martinique',
  '03': 'Guyane',
  '04': 'La Réunion',
  '06': 'Mayotte',
  '11': 'Île-de-France',
  '24': 'Centre-Val de Loire',
  '27': 'Bourgogne-Franche-Comté',
  '28': 'Normandie',
  '32': 'Hauts-de-France',
  '44': 'Grand Est',
  '52': 'Pays de la Loire',
  '53': 'Bretagne',
  '75': 'Nouvelle-Aquitaine',
  '76': 'Occitanie',
  '84': 'Auvergne-Rhône-Alpes',
  '93': "Provence-Alpes-Côte d'Azur",
  '94': 'Corse',
};
