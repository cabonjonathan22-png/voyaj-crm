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

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get sectionData => 'Données';

  @override
  String get navOrganisations => 'Organisations';

  @override
  String get navContacts => 'Contacts';

  @override
  String get navElected => 'Élus';

  @override
  String get navPipelines => 'Pipelines';

  @override
  String get navTasks => 'Tâches';

  @override
  String get navMap => 'Carte';

  @override
  String get navDuplicates => 'Doublons';

  @override
  String get recordNotFound => 'Cet élément n\'existe pas ou a été supprimé.';

  @override
  String get tabOverview => 'Aperçu';

  @override
  String get tabDeals => 'Affaires';

  @override
  String get tabActivities => 'Activités';

  @override
  String get tabFiles => 'Fichiers';

  @override
  String get tabPositions => 'Postes et mandats';

  @override
  String get copyEmail => 'Copier l\'email';

  @override
  String get moveUp => 'Monter';

  @override
  String get moveDown => 'Descendre';

  @override
  String get formInvalidNumber => 'Nombre invalide.';

  @override
  String get formNone => '— Aucun —';

  @override
  String get formChoose => 'Choisir…';

  @override
  String get customFieldsTitle => 'Champs personnalisés';

  @override
  String get organisationsSubtitle =>
      'Collectivités, EPCI, AOM, festivals et partenaires.';

  @override
  String get organisationNew => 'Nouvelle organisation';

  @override
  String get organisationEdit => 'Modifier l\'organisation';

  @override
  String get organisationCreated => 'Organisation créée.';

  @override
  String organisationDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer $count organisations ?',
      one: 'Supprimer cette organisation ?',
    );
    return '$_temp0';
  }

  @override
  String organisationDeleteMessage(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$names… seront supprimées pour toute l\'équipe. Leurs contacts et affaires sont conservés.',
      one:
          '« $names » sera supprimée pour toute l\'équipe. Ses contacts et affaires sont conservés.',
    );
    return '$_temp0';
  }

  @override
  String organisationDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count organisations supprimées.',
      one: 'Organisation supprimée.',
    );
    return '$_temp0';
  }

  @override
  String get organisationsEmptyTitle => 'Aucune organisation';

  @override
  String get organisationsEmptyMessage =>
      'Créez une organisation ou importez un fichier CSV (communes, EPCI, festivals…).';

  @override
  String get orgName => 'Nom';

  @override
  String get orgKind => 'Type';

  @override
  String get orgStatus => 'Statut';

  @override
  String get orgParent => 'Organisation parente';

  @override
  String get orgSectionContact => 'Coordonnées';

  @override
  String get orgSectionAddress => 'Adresse';

  @override
  String get orgSectionIdentity => 'Identification';

  @override
  String get orgSectionHierarchy => 'Rattachement';

  @override
  String get orgSectionTraceability => 'Traçabilité';

  @override
  String get orgPhone => 'Téléphone';

  @override
  String get orgEmail => 'Email';

  @override
  String get orgWebsite => 'Site web';

  @override
  String get orgAddress => 'Adresse';

  @override
  String get orgPostalCode => 'Code postal';

  @override
  String get orgCity => 'Ville';

  @override
  String get orgDepartement => 'Département';

  @override
  String get orgDepartementShort => 'Dép.';

  @override
  String get orgRegion => 'Région';

  @override
  String get orgLatitude => 'Latitude';

  @override
  String get orgLongitude => 'Longitude';

  @override
  String get orgSiren => 'SIREN';

  @override
  String get orgSiret => 'SIRET';

  @override
  String get orgInsee => 'Code INSEE';

  @override
  String get orgPopulation => 'Population';

  @override
  String get orgDescription => 'Description';

  @override
  String get orgSource => 'Source';

  @override
  String get orgCollectedAt => 'Collectée le';

  @override
  String orgChildren(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count organisations rattachées',
      one: '1 organisation rattachée',
    );
    return '$_temp0';
  }

  @override
  String get contactsSubtitle => 'Personnes, agents et élus des organisations.';

  @override
  String get contactNew => 'Nouveau contact';

  @override
  String get contactEdit => 'Modifier le contact';

  @override
  String get contactCreated => 'Contact créé.';

  @override
  String contactDeleteTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Supprimer $count contacts ?',
      one: 'Supprimer ce contact ?',
    );
    return '$_temp0';
  }

  @override
  String contactDeleteMessage(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$names… seront supprimés pour toute l\'équipe.',
      one: '« $names » sera supprimé pour toute l\'équipe.',
    );
    return '$_temp0';
  }

  @override
  String contactDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contacts supprimés.',
      one: 'Contact supprimé.',
    );
    return '$_temp0';
  }

  @override
  String get contactsEmptyTitle => 'Aucun contact';

  @override
  String get contactsEmptyMessage =>
      'Ajoutez les interlocuteurs de vos organisations ou importez un fichier CSV.';

  @override
  String get contactsAttached => 'Contacts rattachés';

  @override
  String get contactName => 'Nom';

  @override
  String get contactCivility => 'Civilité';

  @override
  String get contactFirstName => 'Prénom';

  @override
  String get contactLastName => 'Nom';

  @override
  String get contactOrganisation => 'Organisation';

  @override
  String get contactJobTitle => 'Fonction';

  @override
  String get contactService => 'Service';

  @override
  String get contactMobile => 'Mobile';

  @override
  String get contactNotes => 'Notes';

  @override
  String get contactDoNotContact => 'Ne pas contacter (opposition, RGPD)';

  @override
  String get contactDoNotContactShort => 'Ne pas contacter';

  @override
  String get positionNew => 'Ajouter un poste';

  @override
  String get positionEdit => 'Modifier le poste';

  @override
  String get positionAddElected => 'Ajouter un mandat';

  @override
  String get positionContact => 'Contact';

  @override
  String get positionIsElected => 'Mandat électif';

  @override
  String get positionMandate => 'Fonction élective';

  @override
  String get positionDelegation => 'Délégation';

  @override
  String get positionStart => 'Début';

  @override
  String get positionEnd => 'Fin';

  @override
  String get positionElected => 'Élu';

  @override
  String positionUntil(String date) {
    return 'jusqu\'au $date';
  }

  @override
  String get positionsCurrent => 'Postes et mandats en cours';

  @override
  String get positionsPast => 'Postes et mandats passés';

  @override
  String get positionsEmpty => 'Aucun poste ni mandat.';

  @override
  String get electedSubtitle =>
      'Mandats électifs en cours (maires, adjoints, conseillers, présidents…).';

  @override
  String get electedEmptyTitle => 'Aucun élu';

  @override
  String get electedEmptyMessage =>
      'Ajoutez un mandat depuis la fiche d\'un contact ou d\'une organisation.';

  @override
  String get pipelinesSubtitle => 'Suivi des affaires par étape.';

  @override
  String get dealNew => 'Nouvelle affaire';

  @override
  String get dealEdit => 'Modifier l\'affaire';

  @override
  String get dealTitle => 'Intitulé';

  @override
  String get dealStage => 'Étape';

  @override
  String get dealContact => 'Contact';

  @override
  String get dealAmount => 'Montant (€)';

  @override
  String get dealProbability => 'Probabilité (%)';

  @override
  String get dealExpectedClose => 'Clôture prévue';

  @override
  String dealCloseOn(String date) {
    return 'clôture le $date';
  }

  @override
  String get dealLate => 'En retard';

  @override
  String get dealSearch => 'Rechercher une affaire…';

  @override
  String get dealsEmpty => 'Aucune affaire.';

  @override
  String dealsOpenTotal(String amount) {
    return 'En cours : $amount';
  }

  @override
  String pipelineTotals(String open, String weighted) {
    return 'En cours : $open · Pondéré : $weighted';
  }

  @override
  String get pipelineConfigure => 'Configurer';

  @override
  String get pipelineNew => 'Nouveau pipeline';

  @override
  String get pipelineName => 'Nom du pipeline';

  @override
  String get pipelineKind => 'Type';

  @override
  String get pipelineArchived => 'Archivé (masqué du Kanban)';

  @override
  String get pipelineCreateDefaults =>
      'Créer les pipelines Collectivités et Festivals';

  @override
  String get pipelineSetupFirst => 'Configurer un pipeline';

  @override
  String get pipelinesEmptyTitle => 'Aucun pipeline';

  @override
  String get pipelinesEmptyMessage =>
      'Créez les pipelines par défaut (étapes modifiables ensuite) ou un pipeline sur mesure.';

  @override
  String get pipelinesEmptyReadOnly =>
      'Un administrateur doit configurer les pipelines.';

  @override
  String get stagesTitle => 'Étapes';

  @override
  String get stagesEmpty => 'Ce pipeline n\'a pas d\'étape.';

  @override
  String get stageNew => 'Ajouter une étape';

  @override
  String get stageEdit => 'Modifier l\'étape';

  @override
  String get stageName => 'Nom de l\'étape';

  @override
  String get stageOutcome => 'Issue';

  @override
  String get stageDefaultNew => 'Nouveau';

  @override
  String get stageInUse => 'Déplacez d\'abord les affaires de cette étape.';

  @override
  String get activityNew => 'Nouvelle activité';

  @override
  String get activityEdit => 'Modifier l\'activité';

  @override
  String get activitySaved => 'Activité enregistrée.';

  @override
  String get activityKind => 'Type';

  @override
  String get activitySubject => 'Objet';

  @override
  String get activityBody => 'Contenu';

  @override
  String get activityStart => 'Début';

  @override
  String get activityEnd => 'Fin';

  @override
  String get activityDue => 'Échéance';

  @override
  String get activityRemind => 'Rappel';

  @override
  String get activityDone => 'Terminée';

  @override
  String get activityDeal => 'Affaire';

  @override
  String get activityOpenTasks => 'Tâches à faire';

  @override
  String get activityHistory => 'Historique';

  @override
  String get activityEmpty => 'Aucune activité.';

  @override
  String activityDueOn(String date) {
    return 'échéance $date';
  }

  @override
  String get tasksSubtitle => 'Tâches à faire et journal des échanges.';

  @override
  String get taskNew => 'Nouvelle tâche';

  @override
  String tasksTodo(int count) {
    return 'À faire ($count)';
  }

  @override
  String tasksOverdue(int count) {
    return 'En retard ($count)';
  }

  @override
  String tasksToday(int count) {
    return 'Aujourd\'hui ($count)';
  }

  @override
  String get tasksDone => 'Terminées';

  @override
  String get tasksActivities => 'Activités';

  @override
  String get tasksMine => 'Mes tâches uniquement';

  @override
  String get tasksEmpty => 'Aucune tâche.';

  @override
  String get attachmentAdd => 'Joindre un fichier';

  @override
  String get attachmentDownload => 'Télécharger';

  @override
  String get attachmentsHint =>
      'Fichiers partagés avec l\'équipe (25 Mo maximum, connexion au serveur requise).';

  @override
  String get attachmentsEmpty => 'Aucun fichier joint.';

  @override
  String get attachmentUploaded => 'Fichier joint.';

  @override
  String get attachmentDownloaded => 'Fichier enregistré.';

  @override
  String get attachmentTooLarge => 'Fichier trop volumineux (25 Mo maximum).';

  @override
  String get tagAdd => 'Tag';

  @override
  String get tagAddTitle => 'Ajouter un tag';

  @override
  String get tagApplyTitle => 'Appliquer un tag';

  @override
  String tagApplied(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tag appliqué à $count éléments.',
      one: 'Tag appliqué à 1 élément.',
      zero: 'Tag déjà appliqué.',
    );
    return '$_temp0';
  }

  @override
  String get segments => 'Segments';

  @override
  String get segmentNone => 'Aucun segment partagé';

  @override
  String get segmentSaveAs => 'Enregistrer comme segment…';

  @override
  String get segmentSaveDescription =>
      'Les filtres et la recherche actuels seront partagés avec toute l\'équipe.';

  @override
  String get segmentName => 'Nom du segment';

  @override
  String get segmentDescription => 'Description';

  @override
  String get segmentSaved => 'Segment enregistré.';

  @override
  String segmentDelete(String name) {
    return 'Supprimer « $name »';
  }

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String exportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lignes exportées.',
      one: '1 ligne exportée.',
    );
    return '$_temp0';
  }

  @override
  String mapSubtitle(int shown, int missing) {
    return '$shown organisations affichées · $missing sans coordonnées';
  }

  @override
  String get mapAllKinds => 'Tous les types';

  @override
  String get mapEmpty =>
      'Aucune organisation n\'a de coordonnées (latitude et longitude).';

  @override
  String get customFieldsDescription =>
      'Champs supplémentaires affichés dans les fiches, les tableaux et l\'import.';

  @override
  String get customFieldsEmpty => 'Aucun champ personnalisé.';

  @override
  String get customFieldNew => 'Ajouter un champ';

  @override
  String get customFieldEdit => 'Modifier le champ';

  @override
  String get customFieldLabel => 'Libellé';

  @override
  String get customFieldType => 'Type';

  @override
  String get customFieldOptions => 'Choix (liste)';

  @override
  String get customFieldOptionsHint => 'Choix séparés par des virgules';

  @override
  String get duplicatesSubtitle =>
      'Organisations et contacts probablement saisis plusieurs fois.';

  @override
  String get duplicatesNone => 'Aucun doublon détecté';

  @override
  String get duplicatesNoneMessage =>
      'Comparaison sur SIRET, SIREN, code INSEE, nom + lieu, email et mobile.';

  @override
  String duplicatesGroup(int count) {
    return '$count fiches semblables';
  }

  @override
  String get duplicatesIgnore => 'Ce ne sont pas des doublons';

  @override
  String get duplicatesMerge => 'Fusionner';

  @override
  String get duplicatesKept => 'Conservée';

  @override
  String duplicatesCreated(String when) {
    return 'créée $when';
  }

  @override
  String get duplicatesMergeTitle => 'Fusionner les fiches ?';

  @override
  String duplicatesMergeMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Les $count fiches en double seront supprimées ; leurs informations manquantes, contacts, affaires, activités, fichiers et tags sont reportés sur la fiche conservée.',
      one:
          'La fiche en double sera supprimée ; ses informations manquantes, contacts, affaires, activités, fichiers et tags sont reportés sur la fiche conservée.',
    );
    return '$_temp0';
  }

  @override
  String get duplicatesMerged => 'Fiches fusionnées.';

  @override
  String get importCsv => 'Importer';

  @override
  String get importTitleOrganisations => 'Importer des organisations';

  @override
  String get importTitleContacts => 'Importer des contacts';

  @override
  String get importPickHelp =>
      'Choisissez un fichier CSV (export Excel « CSV UTF-8 » ou séparateur point-virgule). La première ligne doit contenir les en-têtes. Colonnes reconnues automatiquement :';

  @override
  String get importChooseFile => 'Choisir un fichier CSV';

  @override
  String get importEmptyFile => 'Le fichier est vide ou illisible.';

  @override
  String importFileSummary(String name, int count) {
    return '$name : $count lignes';
  }

  @override
  String get importMappingHelp =>
      'Associez chaque colonne à un champ (les colonnes ignorées ne sont pas importées).';

  @override
  String get importIgnore => 'Ignorer';

  @override
  String get importDefaultKind => 'Type par défaut';

  @override
  String get importDefaultStatus => 'Statut par défaut';

  @override
  String importSkipDuplicates(int count) {
    return 'Ignorer les doublons ($count détectés : SIRET, INSEE, nom + lieu, email…)';
  }

  @override
  String importRequiredMissing(String field) {
    return 'Associez une colonne au champ obligatoire « $field ».';
  }

  @override
  String importProblems(int count) {
    return '$count valeurs non reconnues (valeur par défaut appliquée) :';
  }

  @override
  String importProblemKind(String value) {
    return 'type inconnu « $value »';
  }

  @override
  String importProblemStatus(String value) {
    return 'statut inconnu « $value »';
  }

  @override
  String importProblemNumber(String value) {
    return 'nombre invalide « $value »';
  }

  @override
  String importLine(int line, String message) {
    return 'Ligne $line : $message';
  }

  @override
  String get importRgpdNotice =>
      'La source (nom du fichier) et la date de collecte sont enregistrées sur chaque fiche importée (RGPD).';

  @override
  String importSource(String file) {
    return 'Import CSV $file';
  }

  @override
  String get importBack => 'Retour';

  @override
  String importRun(int count) {
    return 'Importer $count lignes';
  }

  @override
  String importProgress(int done, int total) {
    return '$done / $total lignes traitées';
  }

  @override
  String importDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fiches importées.',
      one: '1 fiche importée.',
      zero: 'Aucune fiche importée.',
    );
    return '$_temp0';
  }

  @override
  String get importDuplicatesSkipped => 'Doublons ignorés';

  @override
  String get importOrganisationsCreated => 'Organisations créées';

  @override
  String get importTagsCreated => 'Tags créés';

  @override
  String get importRejected => 'Lignes refusées';

  @override
  String get refresh => 'Actualiser';

  @override
  String get navPublicData => 'Données publiques';

  @override
  String get publicDataSubtitle =>
      'Collectivités, AOM et festivals importés depuis les sources officielles.';

  @override
  String get publicDataHelp =>
      'Les imports créent ou mettent à jour des organisations (statut « À prospecter » à la création), rattachées à leur parent (commune → EPCI → département → région). Un champ modifié par un utilisateur n\'est jamais écrasé, une fiche supprimée n\'est pas recréée. Les sources activées sont réimportées chaque nuit.';

  @override
  String publicDataProvider(String provider) {
    return 'Source : $provider';
  }

  @override
  String get publicDataDaily => 'Import quotidien';

  @override
  String get publicDataRunNow => 'Importer maintenant';

  @override
  String get publicDataStarted =>
      'Import lancé : il se poursuit sur le serveur.';

  @override
  String get publicDataScope => 'Périmètre';

  @override
  String get publicDataScopeAll => 'Toute la France';

  @override
  String get publicDataScopeHelp =>
      'Codes des départements à importer, séparés par des virgules. Laisser vide pour toute la France.';

  @override
  String get publicDataScopeCodes => 'Départements';

  @override
  String publicDataScopeInvalid(String codes) {
    return 'Codes invalides : $codes';
  }

  @override
  String get publicDataCommunesWarning =>
      'Sans périmètre, les 35 000 communes de France seront importées : choisissez plutôt vos départements.';

  @override
  String get publicDataLastRun => 'Dernier import';

  @override
  String get publicDataNever => 'Jamais importé';

  @override
  String get publicDataRunning => 'Import en cours…';

  @override
  String publicDataCounts(
    int fetched,
    int created,
    int updated,
    int unchanged,
  ) {
    return '$fetched lues · $created créées · $updated mises à jour · $unchanged inchangées';
  }

  @override
  String get publicDataStatusRunning => 'En cours';

  @override
  String get publicDataStatusSucceeded => 'Terminé';

  @override
  String get publicDataStatusFailed => 'Échec';

  @override
  String get publicDataHistory => 'Historique des imports';

  @override
  String get publicDataTriggerSchedule => 'Planifié';

  @override
  String get publicDataTriggerManual => 'Manuel';

  @override
  String get navEmails => 'Emails';

  @override
  String get emailsSubtitle => 'Boîte de réception, modèles et séquences.';

  @override
  String get emailInbox => 'Boîte de réception';

  @override
  String get emailTemplates => 'Modèles';

  @override
  String get emailSequences => 'Séquences';

  @override
  String get emailNew => 'Nouveau message';

  @override
  String get emailReply => 'Répondre';

  @override
  String get emailSend => 'Envoyer';

  @override
  String get emailSent => 'Email envoyé.';

  @override
  String get emailFrom => 'De';

  @override
  String get emailTo => 'À';

  @override
  String get emailCc => 'Cc';

  @override
  String get emailSubject => 'Objet';

  @override
  String get emailBody => 'Message';

  @override
  String get emailDate => 'Date';

  @override
  String emailToPrefix(String names) {
    return 'À : $names';
  }

  @override
  String emailQuoteHeader(String date, String from) {
    return 'Le $date, $from a écrit :';
  }

  @override
  String get emailUseTemplate => 'Utiliser un modèle';

  @override
  String get emailOffline =>
      'Messagerie indisponible : connexion au serveur requise.';

  @override
  String get emailNoAccountTitle => 'Aucun compte email';

  @override
  String get emailNoAccount =>
      'Connectez votre compte email (Gmail, Microsoft 365, OVH…) dans Paramètres → Comptes email.';

  @override
  String get emailConnectAccount => 'Connecter un compte';

  @override
  String get emailAllAccounts => 'Tous mes comptes';

  @override
  String get emailSyncNow => 'Relever';

  @override
  String get emailEmpty => 'Aucun message.';

  @override
  String get emailExchanges => 'Échanges';

  @override
  String get emailContactWithoutAddress =>
      'Ce contact n\'a pas d\'adresse email.';

  @override
  String get emailAccountsTitle => 'Mes comptes email';

  @override
  String get emailAccountsDescription =>
      'Les emails reçus sont relevés toutes les 5 minutes ; ceux échangés avec un contact du CRM sont ajoutés à son historique (visible par l\'équipe). Les autres restent privés.';

  @override
  String get emailConnectDescription =>
      'Gmail et Microsoft 365 : connexion sécurisée via le navigateur (sans mot de passe). Autres messageries : serveur IMAP / SMTP.';

  @override
  String get emailConnectGoogle => 'Connecter Gmail';

  @override
  String get emailConnectMicrosoft => 'Connecter Microsoft 365 / Outlook';

  @override
  String get emailAddImap => 'Ajouter un compte IMAP / SMTP';

  @override
  String get emailOAuthContinue =>
      'Terminez la connexion dans le navigateur, puis actualisez la liste.';

  @override
  String get emailDisconnect => 'Déconnecter';

  @override
  String emailDisconnectMessage(String address) {
    return 'Le compte $address ne sera plus relevé. Les messages déjà journalisés dans le CRM sont conservés.';
  }

  @override
  String get emailImapHelp =>
      'La connexion est testée avant l\'enregistrement. Le mot de passe est chiffré sur le serveur. Pour Gmail, utilisez un mot de passe d\'application.';

  @override
  String get emailDisplayName => 'Nom affiché';

  @override
  String get emailUsername => 'Identifiant';

  @override
  String get emailUsernameHint => 'Par défaut : l\'adresse email';

  @override
  String get emailImapServer => 'Serveur IMAP (réception)';

  @override
  String get emailSmtpServer => 'Serveur SMTP (envoi)';

  @override
  String get emailPort => 'Port';

  @override
  String get emailSecurityNone => 'Aucune';

  @override
  String get emailTestAndSave => 'Tester et enregistrer';

  @override
  String get emailAccountAdded => 'Compte email connecté.';

  @override
  String get templateNew => 'Nouveau modèle';

  @override
  String get templateEdit => 'Modifier le modèle';

  @override
  String get templateName => 'Nom du modèle';

  @override
  String get templateBodyHint =>
      'Bonjour… (variables : voir la liste des modèles)';

  @override
  String templateVariablesHelp(String variables) {
    return 'Variables disponibles dans l\'objet et le message : $variables';
  }

  @override
  String get templatesEmpty => 'Aucun modèle d\'email.';

  @override
  String get sequenceNew => 'Nouvelle séquence';

  @override
  String get sequenceEdit => 'Modifier la séquence';

  @override
  String get sequenceName => 'Nom de la séquence';

  @override
  String get sequenceActive => 'Active (les envois programmés partent)';

  @override
  String get sequenceInactive => 'Inactive';

  @override
  String get sequenceSteps => 'Étapes';

  @override
  String get sequenceStepsHelp =>
      'Délai en jours après l\'étape précédente (après l\'inscription pour la première).';

  @override
  String get sequenceDays => 'jours';

  @override
  String get sequenceChooseTemplate => 'Choisir un modèle…';

  @override
  String get sequenceAddStep => 'Ajouter une étape';

  @override
  String get sequenceNeedsTemplate =>
      'Créez d\'abord au moins un modèle d\'email.';

  @override
  String get sequenceEnroll => 'Inscrire à une séquence';

  @override
  String sequenceEnrolled(String name) {
    return 'Contact inscrit à « $name ».';
  }

  @override
  String get sequenceAlreadyEnrolled => 'Ce contact suit déjà cette séquence.';

  @override
  String get sequenceNoEnrollment => 'Aucune inscription.';

  @override
  String sequenceStepOf(int step) {
    return 'étape $step';
  }

  @override
  String sequenceStepLine(int index, int days, String template) {
    return '$index. J+$days — $template';
  }

  @override
  String get sequenceStop => 'Arrêter';

  @override
  String get sequencesHelp =>
      'Les emails d\'une séquence partent automatiquement du compte de la personne qui inscrit le contact. La séquence s\'arrête dès que le contact répond.';

  @override
  String get sequencesEmpty => 'Aucune séquence.';

  @override
  String get navBilling => 'Facturation';

  @override
  String get billingSubtitle =>
      'Devis, factures et avoirs conformes (Factur-X), catalogue et exports comptables.';

  @override
  String get billingQuotes => 'Devis';

  @override
  String get billingInvoices => 'Factures';

  @override
  String get billingCreditNotes => 'Avoirs';

  @override
  String get billingProducts => 'Produits';

  @override
  String get billingExports => 'Comptabilité';

  @override
  String get billingNewQuote => 'Nouveau devis';

  @override
  String get billingNewInvoice => 'Nouvelle facture';

  @override
  String billingNewDocument(String kind) {
    return 'Nouveau brouillon : $kind';
  }

  @override
  String billingEditDocument(String kind) {
    return 'Modifier le brouillon : $kind';
  }

  @override
  String billingDraftOf(String kind) {
    return '$kind (brouillon)';
  }

  @override
  String billingEmpty(String kind) {
    return 'Aucun document : $kind.';
  }

  @override
  String get billingDocument => 'Document';

  @override
  String get billingDocumentMissing => 'Ce document n\'existe plus.';

  @override
  String get billingDraft => 'Brouillon';

  @override
  String get billingNumber => 'Numéro';

  @override
  String get billingCustomer => 'Client';

  @override
  String get billingContact => 'Contact';

  @override
  String get billingSubject => 'Objet';

  @override
  String get billingStatus => 'État';

  @override
  String get billingIssueDate => 'Date d\'émission';

  @override
  String get billingServiceDate => 'Date de la prestation';

  @override
  String get billingDueDate => 'Échéance';

  @override
  String get billingValidUntil => 'Valable jusqu\'au';

  @override
  String get billingOriginalInvoice => 'Facture d\'origine';

  @override
  String get billingBuyerReference => 'Engagement / bon de commande';

  @override
  String get billingBuyerReferenceHelp =>
      'Numéro d\'engagement de l\'acheteur public (Chorus Pro).';

  @override
  String get billingServiceCode => 'Code service';

  @override
  String get billingServiceCodeHelp =>
      'Service destinataire dans Chorus Pro, si exigé.';

  @override
  String get billingNotes => 'Notes';

  @override
  String get billingLines => 'Lignes';

  @override
  String get billingAddLine => 'Ajouter une ligne';

  @override
  String get billingAddProduct => 'Depuis le catalogue';

  @override
  String get billingLineDescription => 'Désignation';

  @override
  String get billingLinePrice => 'Chaque ligne a un prix unitaire.';

  @override
  String get billingQty => 'Quantité';

  @override
  String get billingUnitPrice => 'Prix unit. HT';

  @override
  String get billingUnitPriceHt => 'Prix unitaire HT';

  @override
  String get billingVat => 'TVA';

  @override
  String get billingDiscount => 'Remise';

  @override
  String get billingTotalHt => 'Total HT';

  @override
  String get billingTotalTtc => 'Total TTC';

  @override
  String billingVatAt(String rate) {
    return 'TVA $rate';
  }

  @override
  String get billingBalance => 'Reste dû';

  @override
  String get billingPaymentTerms => 'Conditions de paiement';

  @override
  String get billingPaymentTermsHint =>
      'Par défaut : celles des paramètres de facturation';

  @override
  String get billingIssue => 'Émettre';

  @override
  String billingIssueTitle(String kind) {
    return 'Émettre ce document ($kind) ?';
  }

  @override
  String get billingIssueMessage =>
      'Un numéro définitif est attribué et le PDF Factur-X est produit. Le document ne pourra plus être modifié : une erreur se corrige par un avoir.';

  @override
  String get billingIssueOffline =>
      'Des modifications de ce brouillon ne sont pas encore envoyées au serveur. Vérifiez la connexion puis réessayez.';

  @override
  String billingIssued(String number) {
    return 'Document émis : $number.';
  }

  @override
  String get billingPdf => 'PDF';

  @override
  String billingFileSaved(String name) {
    return '$name enregistré.';
  }

  @override
  String get billingQuoteRefused => 'Refusé';

  @override
  String get billingToInvoice => 'Facturer';

  @override
  String get billingCreditNote => 'Faire un avoir';

  @override
  String get billingOnlyDraftsDeleted =>
      'Seuls les brouillons sont supprimés : un document émis se corrige par un avoir.';

  @override
  String get billingOrganisationEmpty =>
      'Aucun devis ni facture pour cette organisation.';

  @override
  String get payments => 'Paiements';

  @override
  String get paymentsEmpty => 'Aucun paiement enregistré.';

  @override
  String paymentsBalance(String paid, String remaining) {
    return 'Encaissé : $paid · Reste dû : $remaining';
  }

  @override
  String get paymentAdd => 'Enregistrer un paiement';

  @override
  String paymentNew(String number) {
    return 'Paiement de $number';
  }

  @override
  String get paymentAmount => 'Montant (€)';

  @override
  String get paymentDate => 'Date';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get paymentReference => 'Référence';

  @override
  String get paymentRecorded => 'Paiement enregistré.';

  @override
  String get productNew => 'Nouveau produit';

  @override
  String get productEdit => 'Modifier le produit';

  @override
  String get productName => 'Désignation';

  @override
  String get productDescription => 'Description';

  @override
  String get productUnit => 'Unité';

  @override
  String get productUnitHint => 'jour, trajet, forfait…';

  @override
  String get productAccount => 'Compte de produit';

  @override
  String get productActive => 'Actif';

  @override
  String get productsEmpty => 'Catalogue vide';

  @override
  String get productsEmptyMessage =>
      'Ajoutez vos prestations pour composer plus vite devis et factures.';

  @override
  String get billingAccountantNotice =>
      'Les exports comptables suivent le format réglementaire (FEC, article A47 A-1 du LPF) et le plan de comptes des paramètres. Faites-les valider par votre expert-comptable avant tout dépôt.';

  @override
  String get fecTitle => 'Fichier des écritures comptables (FEC)';

  @override
  String get fecDescription =>
      'Ventes (factures et avoirs émis) et encaissements de l\'exercice civil.';

  @override
  String get fecDownload => 'Télécharger le FEC';

  @override
  String get fecNeedsSiren =>
      'Renseignez le SIREN dans les paramètres de facturation.';

  @override
  String get vatReportTitle => 'TVA collectée';

  @override
  String get vatReportDescription =>
      'Sur les débits (documents émis) et sur les encaissements (paiements reçus), par taux.';

  @override
  String get vatReportCompute => 'Calculer';

  @override
  String get vatOnDebits => 'Sur les débits';

  @override
  String get vatOnReceipts => 'Sur les encaissements';

  @override
  String get billingVatNone => 'Aucune opération sur la période.';

  @override
  String billingVatBase(String amount) {
    return 'base $amount';
  }

  @override
  String get periodFrom => 'Du';

  @override
  String get periodTo => 'Au';

  @override
  String get billingSeller => 'Votre entreprise';

  @override
  String get billingSellerHelp =>
      'Mentions légales imprimées sur chaque document (figées à l\'émission).';

  @override
  String get billingLegalName => 'Raison sociale';

  @override
  String get billingLegalForm => 'Forme juridique';

  @override
  String get billingVatNumber => 'N° de TVA intracommunautaire';

  @override
  String get billingRcs => 'Ville du RCS';

  @override
  String get billingCapital => 'Capital social';

  @override
  String get billingIban => 'IBAN';

  @override
  String get billingBic => 'BIC';

  @override
  String get billingConditions => 'Conditions et mentions';

  @override
  String get billingPaymentDays => 'Délai de paiement (jours)';

  @override
  String get billingQuoteValidityDays => 'Validité des devis (jours)';

  @override
  String get billingLatePenalties => 'Pénalités de retard';

  @override
  String get billingVatExemption => 'Mention d\'exonération de TVA';

  @override
  String get billingVatExemptionHint => 'TVA non applicable, art. 293 B du CGI';

  @override
  String get billingFooter => 'Pied de page';

  @override
  String get billingAccounts => 'Plan de comptes';

  @override
  String get billingAccountsHelp =>
      'Comptes utilisés dans le FEC (TVA collectée : 44571x par taux).';

  @override
  String get billingAccountCustomer => 'Clients';

  @override
  String get billingAccountSales => 'Ventes';

  @override
  String get billingAccountBank => 'Banque';

  @override
  String get billingSettingsSaved => 'Paramètres de facturation enregistrés.';

  @override
  String get billingSettingsForbidden =>
      'Réservé aux personnes autorisées à gérer la facturation.';

  @override
  String get billingSettingsOffline => 'Connexion au serveur requise.';

  @override
  String get secretUnchanged => 'Inchangé (laisser vide)';

  @override
  String get chorusTitle => 'Chorus Pro';

  @override
  String get chorusHelp =>
      'Dépôt des factures aux collectivités via l\'API PISTE : application PISTE (identifiant et secret) et compte technique Chorus Pro.';

  @override
  String get chorusEnabled => 'Activer le dépôt sur Chorus Pro';

  @override
  String get chorusSandbox => 'Environnement de qualification';

  @override
  String get chorusSandboxHelp =>
      'Pour les essais : les factures ne sont pas transmises.';

  @override
  String get chorusLogin => 'Compte technique (login)';

  @override
  String get chorusPassword => 'Mot de passe du compte technique';

  @override
  String get pisteClientId => 'Client ID PISTE';

  @override
  String get pisteClientSecret => 'Client secret PISTE';

  @override
  String get chorusConfigured => 'Identifiants enregistrés';

  @override
  String get chorusNotConfigured => 'Identifiants incomplets';

  @override
  String get chorusDeposit => 'Déposer sur Chorus Pro';

  @override
  String chorusDepositTitle(String number) {
    return 'Déposer $number sur Chorus Pro ?';
  }

  @override
  String get chorusDepositMessage =>
      'Le PDF Factur-X émis est transmis tel quel à la collectivité.';

  @override
  String chorusDeposited(String flux) {
    return 'Déposé sur Chorus Pro (flux $flux).';
  }

  @override
  String chorusFlux(String flux) {
    return 'Chorus Pro : flux $flux';
  }

  @override
  String get navConnectors => 'Connecteurs';

  @override
  String get connectorsSubtitle =>
      'Imports depuis vos outils (API REST, Supabase, Firebase, MySQL, MongoDB, webhooks) et envoi des changements.';

  @override
  String get connectorsTab => 'Sources';

  @override
  String get webhooksTab => 'Webhooks sortants';

  @override
  String get connectorsEmpty => 'Aucun connecteur';

  @override
  String get connectorsEmptyMessage =>
      'Branchez une source externe pour alimenter automatiquement organisations et contacts.';

  @override
  String get connectorNew => 'Nouveau connecteur';

  @override
  String get connectorEdit => 'Modifier le connecteur';

  @override
  String get connectorName => 'Nom';

  @override
  String get connectorKind => 'Type de source';

  @override
  String get connectorSource => 'Source';

  @override
  String get connectorUrl => 'URL';

  @override
  String get connectorRecordsPath => 'Chemin de la liste dans la réponse';

  @override
  String get connectorAuthHeader => 'En-tête portant le secret';

  @override
  String get connectorPageParam => 'Paramètre de page (pagination)';

  @override
  String get connectorNextPath => 'Chemin de l\'URL de la page suivante';

  @override
  String get connectorProjectUrl => 'URL du projet';

  @override
  String get connectorTable => 'Table';

  @override
  String get connectorSelect => 'Colonnes';

  @override
  String get connectorFilter => 'Filtres (syntaxe PostgREST)';

  @override
  String get connectorOrder => 'Tri';

  @override
  String get connectorProject => 'Identifiant du projet';

  @override
  String get connectorCollection => 'Collection';

  @override
  String get connectorDatabase => 'Base de données';

  @override
  String get connectorHost => 'Serveur';

  @override
  String get connectorPort => 'Port';

  @override
  String get connectorUser => 'Utilisateur';

  @override
  String get connectorQuery => 'Requête SELECT';

  @override
  String get connectorMongoFilter => 'Filtre (JSON)';

  @override
  String get connectorSecretRest => 'Valeur de l\'en-tête (ex. Bearer …)';

  @override
  String get connectorSecretSupabase => 'Clé d\'API';

  @override
  String get connectorSecretFirebase => 'Clé d\'API web ou « Bearer <jeton> »';

  @override
  String get connectorSecretMysql => 'Mot de passe';

  @override
  String get connectorSecretMongo => 'Chaîne de connexion (mongodb://…)';

  @override
  String get connectorSecure => 'Connexion chiffrée (TLS)';

  @override
  String get connectorWebhookHelp =>
      'Le système externe envoie ses données en POST JSON à l\'URL du webhook, avec le jeton en en-tête. Générez le jeton après l\'enregistrement.';

  @override
  String get connectorMapping => 'Mappage';

  @override
  String get connectorEntity => 'Alimente';

  @override
  String get connectorRefPath => 'Identifiant dans la source';

  @override
  String get connectorRefPathHelp =>
      'Chemin d\'une valeur stable et unique (id, code…).';

  @override
  String get connectorMatchField => 'Rapprocher des fiches existantes par';

  @override
  String get connectorSchedule => 'Import automatique';

  @override
  String get connectorScheduleManual => 'Manuel';

  @override
  String connectorEveryMinutes(int minutes) {
    return 'Toutes les $minutes min';
  }

  @override
  String connectorEveryHours(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Toutes les $hours h',
      one: 'Toutes les heures',
    );
    return '$_temp0';
  }

  @override
  String get connectorLookupSource => 'Organisation : chemin dans la source';

  @override
  String get connectorLookupHelp =>
      'Rattache le contact à l\'organisation existante de même valeur.';

  @override
  String get connectorLookupField => 'Organisation : champ comparé';

  @override
  String get connectorTarget => 'Champ Voyaj';

  @override
  String get connectorSourcePath => 'Chemin dans la source';

  @override
  String get connectorTransform => 'Transformation';

  @override
  String get connectorConstant => 'Ou valeur fixe';

  @override
  String get connectorChooseField => 'Choisir…';

  @override
  String get connectorAddField => 'Ajouter un champ';

  @override
  String get connectorPreview => 'Aperçu';

  @override
  String connectorPreviewTitle(int count) {
    return 'Aperçu : $count enregistrements lus';
  }

  @override
  String connectorPaths(String paths) {
    return 'Chemins détectés : $paths';
  }

  @override
  String get connectorRun => 'Importer';

  @override
  String get connectorStarted => 'Import lancé.';

  @override
  String get connectorHistory => 'Historique';

  @override
  String connectorHistoryOf(String name) {
    return 'Historique — $name';
  }

  @override
  String get connectorNeverRun => 'Jamais importé.';

  @override
  String get connectorDisabled => 'Désactivé';

  @override
  String get connectorRunSucceeded => 'Réussi';

  @override
  String get connectorRunFailed => 'Échec';

  @override
  String get connectorRunRunning => 'En cours';

  @override
  String connectorRunStats(
    int fetched,
    int created,
    int updated,
    int unchanged,
    int rejected,
  ) {
    return '$fetched lus · $created créés · $updated mis à jour · $unchanged inchangés · $rejected rejetés';
  }

  @override
  String connectorDeleteTitle(String name) {
    return 'Supprimer « $name » ?';
  }

  @override
  String get connectorDeleteMessage =>
      'Les fiches déjà importées sont conservées.';

  @override
  String get connectorToken => 'Jeton du webhook';

  @override
  String get connectorTokenRenew => 'Générer';

  @override
  String get connectorTokenRenewTitle => 'Générer un nouveau jeton ?';

  @override
  String get connectorTokenRenewMessage =>
      'L\'ancien jeton cessera immédiatement de fonctionner.';

  @override
  String get connectorTokenOnce =>
      'Copiez le jeton maintenant : il ne sera plus affiché.';

  @override
  String get connectorTokenUrl => 'URL';

  @override
  String get connectorTokenValue => 'Jeton';

  @override
  String get connectorTokenUsage =>
      'Envoyer en POST un objet ou une liste JSON, avec l\'en-tête « Authorization: Bearer <jeton> ».';

  @override
  String get webhookNew => 'Nouveau webhook';

  @override
  String get webhookEdit => 'Modifier le webhook';

  @override
  String get webhookUrl => 'URL de destination';

  @override
  String get webhookSecret => 'Secret de signature';

  @override
  String get webhookSecretHelp =>
      'Signature HMAC-SHA256 du corps dans l\'en-tête x-voyaj-signature.';

  @override
  String get webhookEntities => 'Entités envoyées';

  @override
  String get webhookEnabled => 'Actif';

  @override
  String get webhooksHelp =>
      'Chaque changement des entités choisies est envoyé (POST JSON, lots de 100) à l\'URL. En cas d\'échec, nouvel essai avec un délai croissant jusqu\'à une heure.';

  @override
  String get webhooksEmpty => 'Aucun webhook sortant.';

  @override
  String get webhookPing => 'Tester';

  @override
  String webhookPingOk(int status) {
    return 'Le destinataire a répondu $status.';
  }

  @override
  String get webhookHealthy => 'Livré';

  @override
  String webhookFailing(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count échecs',
      one: '1 échec',
    );
    return '$_temp0';
  }

  @override
  String webhookLastDelivery(String date) {
    return 'Dernier envoi : $date';
  }

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String dashHello(String name) {
    return 'Bonjour $name';
  }

  @override
  String get dashOpenPipeline => 'Affaires en cours';

  @override
  String dashOpenDeals(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count affaires',
      one: '1 affaire',
      zero: 'Aucune affaire',
    );
    return '$_temp0';
  }

  @override
  String get dashWeighted => 'Pipeline pondéré';

  @override
  String get dashWeightedHelp => 'Montants × probabilité';

  @override
  String get dashWon => 'Affaires gagnées';

  @override
  String get dashRevenue => 'Chiffre d\'affaires HT';

  @override
  String get dashRevenueHelp => 'Factures moins avoirs émis cette année';

  @override
  String get dashOutstanding => 'Reste à encaisser';

  @override
  String get dashNoOverdue => 'Aucune facture en retard';

  @override
  String dashOverdue(int count, String amount) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count factures en retard',
      one: '1 facture en retard',
    );
    return '$_temp0 ($amount)';
  }

  @override
  String get dashTasks => 'Mes tâches';

  @override
  String dashTasksHelp(int late, int today) {
    return '$late en retard · $today aujourd\'hui';
  }

  @override
  String get dashTasksNone =>
      'Rien d\'urgent : aucune tâche en retard ni prévue aujourd\'hui.';

  @override
  String get dashRevenueChart => 'Chiffre d\'affaires mensuel';

  @override
  String get dashRevenueChartHelp =>
      '12 derniers mois, HT (factures moins avoirs)';

  @override
  String get dashPipelineByStage => 'Pipeline par étape';

  @override
  String get dashOrganisations => 'Organisations par statut';

  @override
  String get dashActivity => 'Activité des 30 derniers jours';

  @override
  String get dashNoData => 'Pas encore de données.';

  @override
  String get navAgenda => 'Agenda';

  @override
  String get agendaMine => 'Mes activités';

  @override
  String get agendaEveryone => 'Toute l\'équipe';

  @override
  String get agendaPrevious => 'Mois précédent';

  @override
  String get agendaNext => 'Mois suivant';

  @override
  String get agendaToday => 'Aujourd\'hui';

  @override
  String get agendaNewMeeting => 'Rendez-vous';

  @override
  String get agendaNewTask => 'Tâche';

  @override
  String get agendaNothing => 'Rien de prévu ce jour-là.';

  @override
  String get agendaSubscribe => 'Abonnement (Outlook, Google)';

  @override
  String get agendaSubscribeHelp =>
      'Ajoutez cette adresse dans Outlook (« Ajouter un calendrier » › « À partir d\'Internet ») ou Google Agenda (« À partir de l\'URL ») : vos rendez-vous, appels et tâches Voyaj y apparaissent et se mettent à jour automatiquement.';

  @override
  String get agendaCreateLink => 'Créer le lien';

  @override
  String get agendaRenew => 'Nouveau lien';

  @override
  String get agendaRevoke => 'Désactiver';

  @override
  String get agendaLinkOnce =>
      'Copiez l\'adresse maintenant : elle ne sera plus affichée. Toute personne qui la connaît voit votre agenda.';

  @override
  String get agendaLinkActive =>
      'Un lien d\'abonnement est actif. Générer un nouveau lien désactive l\'ancien.';

  @override
  String get agendaLinkNone => 'Aucun lien d\'abonnement actif.';

  @override
  String get apiTokensTitle => 'Jetons d\'API personnels';

  @override
  String get apiTokensHelp =>
      'Pour relier Voyaj à vos outils (ERP, scripts, Make, Zapier…) : chaque jeton agit en votre nom, avec les seules permissions choisies.';

  @override
  String get apiTokensEmpty => 'Aucun jeton.';

  @override
  String get apiTokenNew => 'Nouveau jeton';

  @override
  String get apiTokenName => 'Nom';

  @override
  String get apiTokenNameHint => 'Ex. : Synchronisation ERP';

  @override
  String get apiTokenValidity => 'Validité';

  @override
  String apiTokenDays(int days) {
    return '$days jours';
  }

  @override
  String get apiTokenNoExpiry => 'Sans expiration';

  @override
  String get apiTokenScopes => 'Permissions accordées';

  @override
  String apiTokenPermissions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count permissions',
      one: '1 permission',
    );
    return '$_temp0';
  }

  @override
  String apiTokenCreated(String date) {
    return 'créé le $date';
  }

  @override
  String apiTokenUsed(String when) {
    return 'utilisé $when';
  }

  @override
  String apiTokenExpires(String date) {
    return 'expire le $date';
  }

  @override
  String get apiTokenRevoke => 'Révoquer';

  @override
  String apiTokenRevokeTitle(String name) {
    return 'Révoquer « $name » ?';
  }

  @override
  String get apiTokenRevokeMessage =>
      'Les outils qui utilisent ce jeton perdront immédiatement l\'accès.';

  @override
  String get apiDocTitle => 'Utilisation';

  @override
  String get apiDocHelp =>
      'En-tête « Authorization: Bearer <jeton> ». Points d\'accès : GET /api/v1/records/<entité>?cursor=&limit= (changements depuis un curseur), GET /api/v1/records/<entité>/<id>, POST /api/v1/records/<entité>, PATCH et DELETE /api/v1/records/<entité>/<id>. Entités : organisations, contacts, deals, activities… (voir docs/API.md).';

  @override
  String get navGdpr => 'RGPD et sauvegardes';

  @override
  String get gdprSubtitle =>
      'Durées de conservation, droits des personnes et sauvegardes du serveur.';

  @override
  String get gdprPersonalData => 'Données personnelles (RGPD)';

  @override
  String get gdprExport => 'Exporter ses données';

  @override
  String get gdprErase => 'Anonymiser';

  @override
  String gdprEraseTitle(String name) {
    return 'Anonymiser « $name » ?';
  }

  @override
  String get gdprEraseMessage =>
      'Nom, coordonnées, notes et champs personnalisés sont effacés, ainsi que le contenu de ses activités, ses emails et l\'historique des modifications. La fiche anonyme reste (statistiques). Action définitive : exportez d\'abord ses données si la personne les a demandées.';

  @override
  String get gdprErased => 'Contact anonymisé.';

  @override
  String get gdprRetention => 'Durées de conservation';

  @override
  String get gdprRetentionHelp =>
      'La CNIL recommande de ne pas conserver plus de 3 ans après le dernier contact les données d\'un prospect. Réexaminez ces fiches : relancez la personne, anonymisez-la ou supprimez-la. Le registre des traitements et les mentions d\'information sont décrits dans docs/RGPD.md.';

  @override
  String get gdprInactiveFor => 'Sans contact depuis';

  @override
  String gdprMonths(int months) {
    return '$months mois';
  }

  @override
  String gdprInactiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fiches',
      one: '1 fiche',
      zero: 'Aucune fiche',
    );
    return '$_temp0';
  }

  @override
  String get gdprNoInactive => 'Aucune fiche à réexaminer.';

  @override
  String gdprLastTouch(String date) {
    return 'dernier contact le $date';
  }

  @override
  String get backupsTab => 'Sauvegardes';

  @override
  String get backupsTitle => 'Sauvegardes du serveur';

  @override
  String backupsSchedule(int hour, int days, String dir) {
    return 'Chaque jour à $hour h, conservées $days jours, dans $dir.';
  }

  @override
  String backupsManualOnly(String dir) {
    return 'Sauvegarde quotidienne désactivée. Dossier : $dir.';
  }

  @override
  String get backupNow => 'Sauvegarder maintenant';

  @override
  String get backupDone => 'Sauvegarde terminée.';

  @override
  String get backupsNone => 'Aucune sauvegarde.';

  @override
  String backupLine(String date, String size, int files) {
    return '$date · base $size Mo · $files fichiers';
  }

  @override
  String get backupsRestoreHelp =>
      'Recopiez régulièrement ce dossier hors du serveur (autre site, stockage chiffré). Restauration : voir docs/SAUVEGARDES.md (pg_restore puis recopie des fichiers joints).';

  @override
  String get navTenders => 'Appels d\'offres';

  @override
  String get tendersSubtitle =>
      'Veille des marchés publics (BOAMP) selon vos mots-clés et départements.';

  @override
  String get tendersConfigure => 'Configurer la veille';

  @override
  String get tendersSearch => 'Rechercher maintenant';

  @override
  String tendersFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nouveaux avis.',
      one: '1 nouvel avis.',
      zero: 'Aucun nouvel avis.',
    );
    return '$_temp0';
  }

  @override
  String get tendersAll => 'Tous';

  @override
  String get tendersEmpty => 'Aucun avis.';

  @override
  String get tendersNotConfigured => 'Veille non configurée.';

  @override
  String tendersKeywords(String keywords) {
    return 'Mots-clés : $keywords';
  }

  @override
  String tendersDepartements(String list) {
    return 'Départements : $list';
  }

  @override
  String tendersLastRun(String when) {
    return 'dernière recherche $when';
  }

  @override
  String get tendersKeywordsLabel => 'Mots-clés';

  @override
  String get tendersKeywordsHelp =>
      'Séparés par des virgules ; un avis correspond s\'il contient l\'un d\'eux.';

  @override
  String get tendersDepartementsLabel =>
      'Départements (vide : toute la France)';

  @override
  String get tendersDepartementsHelp => 'Numéros séparés par des virgules.';

  @override
  String get tendersDaily => 'Recherche automatique chaque jour';

  @override
  String tenderPublished(String date) {
    return 'paru le $date';
  }

  @override
  String tenderDeadline(String date, int days) {
    return 'Réponse avant le $date ($days j)';
  }

  @override
  String get tenderOpen => 'Voir l\'avis';

  @override
  String get tenderFollow => 'Suivre';

  @override
  String get tenderIgnore => 'Ignorer';

  @override
  String get tenderFollowed => 'Affaire créée pour cet appel d\'offres.';

  @override
  String tenderDealDescription(String ref, String buyer) {
    return 'Appel d\'offres BOAMP $ref — $buyer';
  }

  @override
  String get signatureSend => 'Signature électronique';

  @override
  String get signatureChooseSigner => 'Signataire du devis';

  @override
  String get signatureNoContact =>
      'Aucun contact de ce client n\'a d\'adresse email.';

  @override
  String get signatureSent => 'Devis envoyé pour signature.';

  @override
  String get signatureTitle => 'Signature électronique';

  @override
  String get signatureDone => 'Signé';

  @override
  String get signatureOngoing => 'En attente';

  @override
  String get signatureDeclined => 'Refusé';

  @override
  String get signatureEnded => 'Clos';

  @override
  String get aiSummary => 'Synthèse IA';

  @override
  String get aiRegenerate => 'Régénérer';

  @override
  String get aiWorking => 'L\'assistant rédige…';

  @override
  String get aiDisclaimer =>
      'Texte généré par une IA (Claude, Anthropic) à partir des données de la fiche : à vérifier avant usage.';

  @override
  String get aiEmail => 'Email avec l\'IA';

  @override
  String get aiEmailGoal => 'Objectif de l\'email';

  @override
  String get aiEmailGoalHint =>
      'Ex. : relancer sur le devis envoyé et proposer un appel la semaine prochaine';

  @override
  String get aiWrite => 'Rédiger';
}
