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
}
