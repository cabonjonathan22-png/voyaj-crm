/// Permissions fines au format `ressource.action`.
///
/// La liste fait foi côté serveur (contrôle d'accès) et côté client
/// (affichage conditionnel). Ajouter une permission = ajouter une valeur ici.
enum Permission {
  tagRead('tag.read', 'Consulter les tags'),
  tagWrite('tag.write', 'Créer, modifier et supprimer les tags'),
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
      Permission.tagRead,
      Permission.tagWrite,
      Permission.syncConflictRead,
      Permission.userRead,
    ],
  ),
  reader('lecture', 'Lecture seule', 'Consultation uniquement.', [
    Permission.tagRead,
    Permission.userRead,
  ]);

  const SystemRole(this.key, this.label, this.description, this.permissions);

  final String key;
  final String label;
  final String description;
  final List<Permission> permissions;
}
