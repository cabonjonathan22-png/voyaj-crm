// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get create => 'Créer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get open => 'Ouvrir';

  @override
  String get close => 'Fermer';

  @override
  String get clear => 'Effacer';

  @override
  String get copy => 'Copier';

  @override
  String get retry => 'Réessayer';

  @override
  String get revoke => 'Révoquer';

  @override
  String get activate => 'Activer';

  @override
  String get confirmAction => 'Confirmer';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get search => 'Rechercher…';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get enabled => 'Activée';

  @override
  String get disabled => 'Désactivée';

  @override
  String get fieldRequired => 'Ce champ est obligatoire.';

  @override
  String get genericError => 'Une erreur inattendue est survenue.';

  @override
  String get onlineOnlyTitle => 'Connexion au serveur requise';

  @override
  String get noResultTitle => 'Aucun résultat';

  @override
  String get noResultMessage =>
      'Aucun élément ne correspond à la recherche ou aux filtres.';

  @override
  String get resetFilters => 'Réinitialiser les filtres';

  @override
  String get copyName => 'Copier le nom';

  @override
  String get navTags => 'Tags';

  @override
  String get navSync => 'Synchronisation';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navUsers => 'Utilisateurs';

  @override
  String get navRoles => 'Rôles et permissions';

  @override
  String get navAudit => 'Journal d\'audit';

  @override
  String get navDesignSystem => 'Design system';

  @override
  String get sectionAdmin => 'Administration';

  @override
  String get sectionDevelopment => 'Développement';

  @override
  String get collapseSidebar => 'Réduire la barre latérale';

  @override
  String get expandSidebar => 'Déployer la barre latérale';

  @override
  String get menuSecurity => 'Sécurité du compte';

  @override
  String get shortcutsHelp => 'Raccourcis clavier';

  @override
  String get setupTitle => 'Connexion au serveur';

  @override
  String get setupSubtitle =>
      'Indiquez l\'adresse du serveur Voyaj de votre structure.';

  @override
  String get setupUrlLabel => 'Adresse du serveur';

  @override
  String get setupUrlHint => 'https://crm.exemple.fr ou localhost:8080';

  @override
  String get setupContinue => 'Continuer';

  @override
  String get setupInvalidUrl => 'Adresse invalide.';

  @override
  String get changeServer => 'Changer de serveur';

  @override
  String get loginTitle => 'Bon retour';

  @override
  String get loginSubtitle => 'Connectez-vous à votre espace Voyaj CRM.';

  @override
  String get emailLabel => 'Adresse email';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginMissingFields =>
      'Saisissez votre email et votre mot de passe.';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get hidePassword => 'Masquer le mot de passe';

  @override
  String get mfaTitle => 'Double authentification';

  @override
  String get mfaSubtitle =>
      'Saisissez le code à 6 chiffres de votre application d\'authentification, ou un code de secours.';

  @override
  String get mfaCodeLabel => 'Code';

  @override
  String get mfaVerify => 'Vérifier';

  @override
  String get mfaBack => 'Revenir à la connexion';

  @override
  String get tagsTitle => 'Tags';

  @override
  String get tagsSubtitle =>
      'Étiquettes partagées pour classer organisations, contacts et affaires.';

  @override
  String get tagsNew => 'Nouveau tag';

  @override
  String get tagsEmptyTitle => 'Aucun tag pour l\'instant';

  @override
  String get tagsEmptyMessage =>
      'Créez des tags pour classer vos prospects, par exemple « Prioritaire » ou « Festival 2026 ».';

  @override
  String get tagName => 'Nom';

  @override
  String get tagDescription => 'Description';

  @override
  String get tagDescriptionHint => 'À quoi sert ce tag ?';

  @override
  String get tagColor => 'Couleur';

  @override
  String get tagUpdated => 'Modifié';

  @override
  String get tagSync => 'Synchro';

  @override
  String get tagNewTitle => 'Nouveau tag';

  @override
  String get tagDetailsTitle => 'Détails du tag';

  @override
  String get tagCreated => 'Tag créé';

  @override
  String get tagSaved => 'Tag enregistré';

  @override
  String tagDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer $count tags ?',
      one: 'Supprimer ce tag ?',
    );
    return '$_temp0';
  }

  @override
  String tagDeleteMessage(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$names… seront supprimés sur tous les postes.',
      one: '« $names » sera supprimé sur tous les postes.',
    );
    return '$_temp0';
  }

  @override
  String tagDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tags supprimés',
      one: 'Tag supprimé',
    );
    return '$_temp0';
  }

  @override
  String get metaCreated => 'Créé le';

  @override
  String get metaUpdated => 'Modifié le';

  @override
  String get metaVersion => 'Version serveur';

  @override
  String get syncTitle => 'Synchronisation';

  @override
  String get syncSubtitle =>
      'Les modifications sont enregistrées localement puis envoyées au serveur.';

  @override
  String get syncNow => 'Synchroniser';

  @override
  String get syncOnline => 'En ligne';

  @override
  String get syncOffline => 'Hors ligne';

  @override
  String get syncConnecting => 'Connexion…';

  @override
  String get syncSyncing => 'Synchronisation…';

  @override
  String syncPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modifications en attente',
      one: '1 modification en attente',
    );
    return '$_temp0';
  }

  @override
  String syncLastAt(String time) {
    return 'dernière synchro $time';
  }

  @override
  String get syncConnection => 'Connexion';

  @override
  String get syncPendingLabel => 'En attente d\'envoi';

  @override
  String get syncAllSent => 'Tout est envoyé';

  @override
  String get syncLastLabel => 'Dernière synchronisation';

  @override
  String get syncStatePending => 'En attente';

  @override
  String get syncStateSynced => 'Synchronisé';

  @override
  String get syncErrorsTitle => 'Modifications refusées';

  @override
  String get syncErrorsDescription =>
      'Modifications que le serveur a refusées (données invalides ou droits insuffisants).';

  @override
  String get syncErrorsEmpty => 'Aucune modification refusée.';

  @override
  String get conflictsTitle => 'Journal des conflits';

  @override
  String get conflictsDescription =>
      'Deux personnes ont modifié le même champ en même temps : la modification la plus récente a été conservée.';

  @override
  String get conflictsUnreviewed => 'À traiter';

  @override
  String get conflictsAll => 'Tous';

  @override
  String get conflictsEmpty => 'Aucun conflit.';

  @override
  String conflictSummary(String record, String field) {
    return '$record · champ « $field »';
  }

  @override
  String conflictDetail(
    String winning,
    String winner,
    String losing,
    String loser,
  ) {
    return 'Conservé : $winning ($winner) — écarté : $losing ($loser)';
  }

  @override
  String get conflictMarkReviewed => 'Marquer comme traité';

  @override
  String get appearanceTitle => 'Apparence';

  @override
  String get appearanceDescription =>
      'Personnalisez l\'affichage sur ce poste.';

  @override
  String get themeLabel => 'Thème';

  @override
  String get themeDescription => '« Système » suit le réglage de Windows.';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get compactSidebar => 'Barre latérale réduite';

  @override
  String get compactSidebarDescription => 'N\'affiche que les icônes (Ctrl+B).';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageDescription => 'D\'autres langues pourront être ajoutées.';

  @override
  String get passwordTitle => 'Mot de passe';

  @override
  String get passwordDescription =>
      'Changer de mot de passe déconnecte vos autres sessions.';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmPassword => 'Confirmation';

  @override
  String passwordPolicy(int min) {
    return 'Au moins $min caractères. Une phrase de passe est idéale.';
  }

  @override
  String get passwordMismatch => 'Les deux mots de passe ne correspondent pas.';

  @override
  String get passwordChanged => 'Mot de passe modifié';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get twoFactorTitle => 'Double authentification (2FA)';

  @override
  String get twoFactorShort => '2FA';

  @override
  String get twoFactorDescription =>
      'Un code à usage unique est demandé à chaque connexion, en plus du mot de passe.';

  @override
  String get enableTwoFactor => 'Activer la double authentification';

  @override
  String get disableTwoFactor => 'Désactiver';

  @override
  String get twoFactorEnabled => 'Double authentification activée';

  @override
  String get twoFactorDisabled => 'Double authentification désactivée';

  @override
  String get regenerateRecoveryCodes => 'Nouveaux codes de secours';

  @override
  String get codePromptDescription =>
      'Saisissez un code de votre application d\'authentification ou un code de secours.';

  @override
  String get totpSetupDescription =>
      'Utilisez une application comme Google Authenticator, Microsoft Authenticator, Aegis ou 1Password.';

  @override
  String get totpStepScan =>
      '1. Scannez ce QR code avec votre application d\'authentification.';

  @override
  String get totpManualKey => 'Ou saisissez la clé manuellement';

  @override
  String get totpStepCode => '2. Saisissez le code affiché';

  @override
  String get recoveryCodesTitle => 'Codes de secours';

  @override
  String get recoveryCodesDescription =>
      'Conservez ces codes en lieu sûr : chacun permet une connexion si vous perdez votre téléphone. Ils ne seront plus affichés.';

  @override
  String get recoveryCodesSaved => 'J\'ai conservé mes codes';

  @override
  String get sessionsTitle => 'Sessions actives';

  @override
  String get sessionsDescription =>
      'Postes connectés à votre compte. Révoquez ceux que vous ne reconnaissez pas.';

  @override
  String get thisDevice => 'Ce poste';

  @override
  String lastActivity(String time) {
    return 'actif $time';
  }

  @override
  String get sessionRevoked => 'Session révoquée';

  @override
  String get sessionsRevoked => 'Sessions révoquées';

  @override
  String get serverTitle => 'Serveur';

  @override
  String get serverDescription =>
      'Serveur Voyaj auquel ce poste se synchronise.';

  @override
  String get serverAddress => 'Adresse';

  @override
  String get serverStatus => 'État';

  @override
  String serverVersion(String version) {
    return 'Version $version';
  }

  @override
  String get changeServerMessage =>
      'Vous serez déconnecté. Les données locales d\'un autre utilisateur seront effacées à la prochaine connexion.';

  @override
  String get deviceTitle => 'Ce poste';

  @override
  String get deviceDescription =>
      'Les données sont stockées chiffrées sur ce poste pour fonctionner hors ligne.';

  @override
  String get deviceId => 'Identifiant du poste';

  @override
  String get appVersionLabel => 'Version de l\'application';

  @override
  String get usersSubtitle => 'Comptes ayant accès au CRM.';

  @override
  String get userNew => 'Nouvel utilisateur';

  @override
  String get userEdit => 'Modifier l\'utilisateur';

  @override
  String get userName => 'Nom';

  @override
  String get rolesLabel => 'Rôles';

  @override
  String get statusLabel => 'Statut';

  @override
  String get statusActive => 'Actif';

  @override
  String get statusDisabled => 'Désactivé';

  @override
  String get lastLogin => 'Dernière connexion';

  @override
  String get initialPassword => 'Mot de passe initial';

  @override
  String get accountActive => 'Compte actif';

  @override
  String get revokeAllSessions => 'Déconnecter partout';

  @override
  String get rolesSubtitle =>
      'Les rôles regroupent des permissions ; un utilisateur peut en avoir plusieurs.';

  @override
  String get roleNew => 'Nouveau rôle';

  @override
  String get roleEdit => 'Modifier le rôle';

  @override
  String get roleName => 'Nom du rôle';

  @override
  String get roleKey => 'Identifiant';

  @override
  String get systemRole => 'Rôle système';

  @override
  String get permissionsLabel => 'Permissions';

  @override
  String get noPermission => 'Aucune permission.';

  @override
  String get roleDeleteTitle => 'Supprimer ce rôle ?';

  @override
  String roleDeleteMessage(String name) {
    return 'Le rôle « $name » sera retiré de tous les utilisateurs.';
  }

  @override
  String get auditSubtitle =>
      'Toutes les actions, horodatées et chaînées (inaltérables).';

  @override
  String get auditDate => 'Date';

  @override
  String get auditActor => 'Auteur';

  @override
  String get auditAction => 'Action';

  @override
  String get auditEntity => 'Objet';

  @override
  String get auditDetails => 'Détails';

  @override
  String get auditSystem => 'Système';
}
