/// Permissions fines au format `ressource.action`.
///
/// La liste fait foi côté serveur (contrôle d'accès) et côté client
/// (affichage conditionnel). Ajouter une permission = ajouter une valeur ici.
enum Permission {
  organisationRead('organisation.read', 'Consulter les organisations'),
  organisationWrite(
    'organisation.write',
    'Créer, modifier et supprimer les organisations',
  ),
  contactRead('contact.read', 'Consulter les contacts et les élus'),
  contactWrite(
    'contact.write',
    'Créer, modifier et supprimer les contacts et les élus',
  ),
  dealRead('deal.read', 'Consulter les affaires et les pipelines'),
  dealWrite('deal.write', 'Créer, modifier et supprimer les affaires'),
  activityRead('activity.read', 'Consulter les activités et les fichiers'),
  activityWrite(
    'activity.write',
    'Créer, modifier et supprimer les activités et les fichiers',
  ),
  tagRead('tag.read', 'Consulter les tags'),
  tagWrite('tag.write', 'Créer, modifier et supprimer les tags'),
  tagApply('tag.apply', 'Appliquer des tags aux fiches'),
  segmentWrite('segment.write', 'Créer et modifier les segments partagés'),
  pipelineManage('pipeline.manage', 'Configurer les pipelines et leurs étapes'),
  customFieldManage(
    'customfield.manage',
    'Configurer les champs personnalisés',
  ),
  dataImport('data.import', 'Importer des données (CSV, Excel)'),
  dataExport('data.export', 'Exporter des données (CSV, Excel)'),
  emailUse(
    'email.use',
    'Connecter ses comptes email, lire et envoyer des emails',
  ),
  emailTemplateWrite(
    'email.template.write',
    'Créer et modifier les modèles et séquences d’emails',
  ),
  invoiceRead('invoice.read', 'Consulter les devis, factures et paiements'),
  invoiceWrite(
    'invoice.write',
    'Préparer les devis et factures, enregistrer les paiements',
  ),
  invoiceIssue(
    'invoice.issue',
    'Émettre (numéroter) devis, factures et avoirs, déposer sur Chorus Pro',
  ),
  billingSettings(
    'billing.settings',
    'Configurer la facturation (identité, comptes, Chorus Pro) et exporter le FEC',
  ),
  publicDataManage(
    'publicdata.manage',
    'Configurer et lancer les imports de données publiques',
  ),
  connectorManage(
    'connector.manage',
    'Configurer les connecteurs, imports externes et webhooks',
  ),
  gdprManage(
    'gdpr.manage',
    'Exercer les droits RGPD : export et anonymisation des personnes',
  ),
  backupManage('backup.manage', 'Lancer et consulter les sauvegardes'),
  syncConflictRead('sync.conflict.read', 'Consulter le journal des conflits'),
  syncConflictManage(
    'sync.conflict.manage',
    'Marquer les conflits comme traités',
  ),
  userRead('user.read', 'Consulter les utilisateurs'),
  userManage('user.manage', 'Créer, modifier et désactiver les utilisateurs'),
  roleManage('role.manage', 'Gérer les rôles et leurs permissions'),
  auditRead('audit.read', "Consulter le journal d'audit");

  const Permission(this.key, this.label);

  final String key;
  final String label;

  static final Map<String, Permission> _byKey = {
    for (final p in values) p.key: p,
  };

  static Permission? fromKey(String key) => _byKey[key];
}

/// Rôles système créés à l'installation (non supprimables).
enum SystemRole {
  admin('admin', 'Administrateur', 'Accès complet.', Permission.values),
  commercial(
    'commercial',
    'Commercial',
    'Prospection et gestion commerciale.',
    [
      Permission.organisationRead,
      Permission.organisationWrite,
      Permission.contactRead,
      Permission.contactWrite,
      Permission.dealRead,
      Permission.dealWrite,
      Permission.activityRead,
      Permission.activityWrite,
      Permission.tagRead,
      Permission.tagWrite,
      Permission.tagApply,
      Permission.segmentWrite,
      Permission.dataImport,
      Permission.dataExport,
      Permission.emailUse,
      Permission.emailTemplateWrite,
      Permission.invoiceRead,
      Permission.invoiceWrite,
      Permission.invoiceIssue,
      Permission.syncConflictRead,
      Permission.userRead,
    ],
  ),
  reader('lecture', 'Lecture seule', 'Consultation uniquement.', [
    Permission.organisationRead,
    Permission.contactRead,
    Permission.dealRead,
    Permission.activityRead,
    Permission.invoiceRead,
    Permission.tagRead,
    Permission.userRead,
  ]);

  const SystemRole(this.key, this.label, this.description, this.permissions);

  final String key;
  final String label;
  final String description;
  final List<Permission> permissions;
}
