import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('fr')];

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @create.
  ///
  /// In fr, this message translates to:
  /// **'Créer'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get edit;

  /// No description provided for @open.
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir'**
  String get open;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @clear.
  ///
  /// In fr, this message translates to:
  /// **'Effacer'**
  String get clear;

  /// No description provided for @copy.
  ///
  /// In fr, this message translates to:
  /// **'Copier'**
  String get copy;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @revoke.
  ///
  /// In fr, this message translates to:
  /// **'Révoquer'**
  String get revoke;

  /// No description provided for @activate.
  ///
  /// In fr, this message translates to:
  /// **'Activer'**
  String get activate;

  /// No description provided for @confirmAction.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirmAction;

  /// No description provided for @loadMore.
  ///
  /// In fr, this message translates to:
  /// **'Charger plus'**
  String get loadMore;

  /// No description provided for @search.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher…'**
  String get search;

  /// No description provided for @signOut.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get signOut;

  /// No description provided for @enabled.
  ///
  /// In fr, this message translates to:
  /// **'Activée'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In fr, this message translates to:
  /// **'Désactivée'**
  String get disabled;

  /// No description provided for @fieldRequired.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ est obligatoire.'**
  String get fieldRequired;

  /// No description provided for @genericError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur inattendue est survenue.'**
  String get genericError;

  /// No description provided for @onlineOnlyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Connexion au serveur requise'**
  String get onlineOnlyTitle;

  /// No description provided for @noResultTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat'**
  String get noResultTitle;

  /// No description provided for @noResultMessage.
  ///
  /// In fr, this message translates to:
  /// **'Aucun élément ne correspond à la recherche ou aux filtres.'**
  String get noResultMessage;

  /// No description provided for @resetFilters.
  ///
  /// In fr, this message translates to:
  /// **'Réinitialiser les filtres'**
  String get resetFilters;

  /// No description provided for @copyName.
  ///
  /// In fr, this message translates to:
  /// **'Copier le nom'**
  String get copyName;

  /// No description provided for @navTags.
  ///
  /// In fr, this message translates to:
  /// **'Tags'**
  String get navTags;

  /// No description provided for @navSync.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation'**
  String get navSync;

  /// No description provided for @navSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get navSettings;

  /// No description provided for @navUsers.
  ///
  /// In fr, this message translates to:
  /// **'Utilisateurs'**
  String get navUsers;

  /// No description provided for @navRoles.
  ///
  /// In fr, this message translates to:
  /// **'Rôles et permissions'**
  String get navRoles;

  /// No description provided for @navAudit.
  ///
  /// In fr, this message translates to:
  /// **'Journal d\'audit'**
  String get navAudit;

  /// No description provided for @navDesignSystem.
  ///
  /// In fr, this message translates to:
  /// **'Design system'**
  String get navDesignSystem;

  /// No description provided for @sectionAdmin.
  ///
  /// In fr, this message translates to:
  /// **'Administration'**
  String get sectionAdmin;

  /// No description provided for @sectionDevelopment.
  ///
  /// In fr, this message translates to:
  /// **'Développement'**
  String get sectionDevelopment;

  /// No description provided for @collapseSidebar.
  ///
  /// In fr, this message translates to:
  /// **'Réduire la barre latérale'**
  String get collapseSidebar;

  /// No description provided for @expandSidebar.
  ///
  /// In fr, this message translates to:
  /// **'Déployer la barre latérale'**
  String get expandSidebar;

  /// No description provided for @menuSecurity.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité du compte'**
  String get menuSecurity;

  /// No description provided for @shortcutsHelp.
  ///
  /// In fr, this message translates to:
  /// **'Raccourcis clavier'**
  String get shortcutsHelp;

  /// No description provided for @setupTitle.
  ///
  /// In fr, this message translates to:
  /// **'Connexion au serveur'**
  String get setupTitle;

  /// No description provided for @setupSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez l\'adresse du serveur Voyaj de votre structure.'**
  String get setupSubtitle;

  /// No description provided for @setupUrlLabel.
  ///
  /// In fr, this message translates to:
  /// **'Adresse du serveur'**
  String get setupUrlLabel;

  /// No description provided for @setupUrlHint.
  ///
  /// In fr, this message translates to:
  /// **'https://crm.exemple.fr ou localhost:8080'**
  String get setupUrlHint;

  /// No description provided for @setupContinue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get setupContinue;

  /// No description provided for @setupInvalidUrl.
  ///
  /// In fr, this message translates to:
  /// **'Adresse invalide.'**
  String get setupInvalidUrl;

  /// No description provided for @changeServer.
  ///
  /// In fr, this message translates to:
  /// **'Changer de serveur'**
  String get changeServer;

  /// No description provided for @loginTitle.
  ///
  /// In fr, this message translates to:
  /// **'Bon retour'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous à votre espace Voyaj CRM.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In fr, this message translates to:
  /// **'Adresse email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get loginButton;

  /// No description provided for @loginMissingFields.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez votre email et votre mot de passe.'**
  String get loginMissingFields;

  /// No description provided for @showPassword.
  ///
  /// In fr, this message translates to:
  /// **'Afficher le mot de passe'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In fr, this message translates to:
  /// **'Masquer le mot de passe'**
  String get hidePassword;

  /// No description provided for @mfaTitle.
  ///
  /// In fr, this message translates to:
  /// **'Double authentification'**
  String get mfaTitle;

  /// No description provided for @mfaSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le code à 6 chiffres de votre application d\'authentification, ou un code de secours.'**
  String get mfaSubtitle;

  /// No description provided for @mfaCodeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Code'**
  String get mfaCodeLabel;

  /// No description provided for @mfaVerify.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier'**
  String get mfaVerify;

  /// No description provided for @mfaBack.
  ///
  /// In fr, this message translates to:
  /// **'Revenir à la connexion'**
  String get mfaBack;

  /// No description provided for @tagsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tags'**
  String get tagsTitle;

  /// No description provided for @tagsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Étiquettes partagées pour classer organisations, contacts et affaires.'**
  String get tagsSubtitle;

  /// No description provided for @tagsNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau tag'**
  String get tagsNew;

  /// No description provided for @tagsEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun tag pour l\'instant'**
  String get tagsEmptyTitle;

  /// No description provided for @tagsEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Créez des tags pour classer vos prospects, par exemple « Prioritaire » ou « Festival 2026 ».'**
  String get tagsEmptyMessage;

  /// No description provided for @tagName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get tagName;

  /// No description provided for @tagDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get tagDescription;

  /// No description provided for @tagDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'À quoi sert ce tag ?'**
  String get tagDescriptionHint;

  /// No description provided for @tagColor.
  ///
  /// In fr, this message translates to:
  /// **'Couleur'**
  String get tagColor;

  /// No description provided for @tagUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Modifié'**
  String get tagUpdated;

  /// No description provided for @tagSync.
  ///
  /// In fr, this message translates to:
  /// **'Synchro'**
  String get tagSync;

  /// No description provided for @tagNewTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau tag'**
  String get tagNewTitle;

  /// No description provided for @tagDetailsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Détails du tag'**
  String get tagDetailsTitle;

  /// No description provided for @tagCreated.
  ///
  /// In fr, this message translates to:
  /// **'Tag créé'**
  String get tagCreated;

  /// No description provided for @tagSaved.
  ///
  /// In fr, this message translates to:
  /// **'Tag enregistré'**
  String get tagSaved;

  /// No description provided for @tagDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Supprimer ce tag ?} other{Supprimer {count} tags ?}}'**
  String tagDeleteTitle(int count);

  /// No description provided for @tagDeleteMessage.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{« {names} » sera supprimé sur tous les postes.} other{{names}… seront supprimés sur tous les postes.}}'**
  String tagDeleteMessage(int count, String names);

  /// No description provided for @tagDeleted.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Tag supprimé} other{{count} tags supprimés}}'**
  String tagDeleted(int count);

  /// No description provided for @metaCreated.
  ///
  /// In fr, this message translates to:
  /// **'Créé le'**
  String get metaCreated;

  /// No description provided for @metaUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Modifié le'**
  String get metaUpdated;

  /// No description provided for @metaVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version serveur'**
  String get metaVersion;

  /// No description provided for @syncTitle.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation'**
  String get syncTitle;

  /// No description provided for @syncSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Les modifications sont enregistrées localement puis envoyées au serveur.'**
  String get syncSubtitle;

  /// No description provided for @syncNow.
  ///
  /// In fr, this message translates to:
  /// **'Synchroniser'**
  String get syncNow;

  /// No description provided for @syncOnline.
  ///
  /// In fr, this message translates to:
  /// **'En ligne'**
  String get syncOnline;

  /// No description provided for @syncOffline.
  ///
  /// In fr, this message translates to:
  /// **'Hors ligne'**
  String get syncOffline;

  /// No description provided for @syncConnecting.
  ///
  /// In fr, this message translates to:
  /// **'Connexion…'**
  String get syncConnecting;

  /// No description provided for @syncSyncing.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation…'**
  String get syncSyncing;

  /// No description provided for @syncPending.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 modification en attente} other{{count} modifications en attente}}'**
  String syncPending(int count);

  /// No description provided for @syncLastAt.
  ///
  /// In fr, this message translates to:
  /// **'dernière synchro {time}'**
  String syncLastAt(String time);

  /// No description provided for @syncConnection.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get syncConnection;

  /// No description provided for @syncPendingLabel.
  ///
  /// In fr, this message translates to:
  /// **'En attente d\'envoi'**
  String get syncPendingLabel;

  /// No description provided for @syncAllSent.
  ///
  /// In fr, this message translates to:
  /// **'Tout est envoyé'**
  String get syncAllSent;

  /// No description provided for @syncLastLabel.
  ///
  /// In fr, this message translates to:
  /// **'Dernière synchronisation'**
  String get syncLastLabel;

  /// No description provided for @syncStatePending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get syncStatePending;

  /// No description provided for @syncStateSynced.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisé'**
  String get syncStateSynced;

  /// No description provided for @syncErrorsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Modifications refusées'**
  String get syncErrorsTitle;

  /// No description provided for @syncErrorsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Modifications que le serveur a refusées (données invalides ou droits insuffisants).'**
  String get syncErrorsDescription;

  /// No description provided for @syncErrorsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune modification refusée.'**
  String get syncErrorsEmpty;

  /// No description provided for @conflictsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Journal des conflits'**
  String get conflictsTitle;

  /// No description provided for @conflictsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Deux personnes ont modifié le même champ en même temps : la modification la plus récente a été conservée.'**
  String get conflictsDescription;

  /// No description provided for @conflictsUnreviewed.
  ///
  /// In fr, this message translates to:
  /// **'À traiter'**
  String get conflictsUnreviewed;

  /// No description provided for @conflictsAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get conflictsAll;

  /// No description provided for @conflictsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun conflit.'**
  String get conflictsEmpty;

  /// No description provided for @conflictSummary.
  ///
  /// In fr, this message translates to:
  /// **'{record} · champ « {field} »'**
  String conflictSummary(String record, String field);

  /// No description provided for @conflictDetail.
  ///
  /// In fr, this message translates to:
  /// **'Conservé : {winning} ({winner}) — écarté : {losing} ({loser})'**
  String conflictDetail(
    String winning,
    String winner,
    String losing,
    String loser,
  );

  /// No description provided for @conflictMarkReviewed.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme traité'**
  String get conflictMarkReviewed;

  /// No description provided for @appearanceTitle.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get appearanceTitle;

  /// No description provided for @appearanceDescription.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisez l\'affichage sur ce poste.'**
  String get appearanceDescription;

  /// No description provided for @themeLabel.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get themeLabel;

  /// No description provided for @themeDescription.
  ///
  /// In fr, this message translates to:
  /// **'« Système » suit le réglage de Windows.'**
  String get themeDescription;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;

  /// No description provided for @compactSidebar.
  ///
  /// In fr, this message translates to:
  /// **'Barre latérale réduite'**
  String get compactSidebar;

  /// No description provided for @compactSidebarDescription.
  ///
  /// In fr, this message translates to:
  /// **'N\'affiche que les icônes (Ctrl+B).'**
  String get compactSidebarDescription;

  /// No description provided for @languageLabel.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get languageLabel;

  /// No description provided for @languageDescription.
  ///
  /// In fr, this message translates to:
  /// **'D\'autres langues pourront être ajoutées.'**
  String get languageDescription;

  /// No description provided for @passwordTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get passwordTitle;

  /// No description provided for @passwordDescription.
  ///
  /// In fr, this message translates to:
  /// **'Changer de mot de passe déconnecte vos autres sessions.'**
  String get passwordDescription;

  /// No description provided for @currentPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe actuel'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau mot de passe'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get confirmPassword;

  /// No description provided for @passwordPolicy.
  ///
  /// In fr, this message translates to:
  /// **'Au moins {min} caractères. Une phrase de passe est idéale.'**
  String passwordPolicy(int min);

  /// No description provided for @passwordMismatch.
  ///
  /// In fr, this message translates to:
  /// **'Les deux mots de passe ne correspondent pas.'**
  String get passwordMismatch;

  /// No description provided for @passwordChanged.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe modifié'**
  String get passwordChanged;

  /// No description provided for @changePassword.
  ///
  /// In fr, this message translates to:
  /// **'Changer le mot de passe'**
  String get changePassword;

  /// No description provided for @twoFactorTitle.
  ///
  /// In fr, this message translates to:
  /// **'Double authentification (2FA)'**
  String get twoFactorTitle;

  /// No description provided for @twoFactorShort.
  ///
  /// In fr, this message translates to:
  /// **'2FA'**
  String get twoFactorShort;

  /// No description provided for @twoFactorDescription.
  ///
  /// In fr, this message translates to:
  /// **'Un code à usage unique est demandé à chaque connexion, en plus du mot de passe.'**
  String get twoFactorDescription;

  /// No description provided for @enableTwoFactor.
  ///
  /// In fr, this message translates to:
  /// **'Activer la double authentification'**
  String get enableTwoFactor;

  /// No description provided for @disableTwoFactor.
  ///
  /// In fr, this message translates to:
  /// **'Désactiver'**
  String get disableTwoFactor;

  /// No description provided for @twoFactorEnabled.
  ///
  /// In fr, this message translates to:
  /// **'Double authentification activée'**
  String get twoFactorEnabled;

  /// No description provided for @twoFactorDisabled.
  ///
  /// In fr, this message translates to:
  /// **'Double authentification désactivée'**
  String get twoFactorDisabled;

  /// No description provided for @regenerateRecoveryCodes.
  ///
  /// In fr, this message translates to:
  /// **'Nouveaux codes de secours'**
  String get regenerateRecoveryCodes;

  /// No description provided for @codePromptDescription.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez un code de votre application d\'authentification ou un code de secours.'**
  String get codePromptDescription;

  /// No description provided for @totpSetupDescription.
  ///
  /// In fr, this message translates to:
  /// **'Utilisez une application comme Google Authenticator, Microsoft Authenticator, Aegis ou 1Password.'**
  String get totpSetupDescription;

  /// No description provided for @totpStepScan.
  ///
  /// In fr, this message translates to:
  /// **'1. Scannez ce QR code avec votre application d\'authentification.'**
  String get totpStepScan;

  /// No description provided for @totpManualKey.
  ///
  /// In fr, this message translates to:
  /// **'Ou saisissez la clé manuellement'**
  String get totpManualKey;

  /// No description provided for @totpStepCode.
  ///
  /// In fr, this message translates to:
  /// **'2. Saisissez le code affiché'**
  String get totpStepCode;

  /// No description provided for @recoveryCodesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Codes de secours'**
  String get recoveryCodesTitle;

  /// No description provided for @recoveryCodesDescription.
  ///
  /// In fr, this message translates to:
  /// **'Conservez ces codes en lieu sûr : chacun permet une connexion si vous perdez votre téléphone. Ils ne seront plus affichés.'**
  String get recoveryCodesDescription;

  /// No description provided for @recoveryCodesSaved.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai conservé mes codes'**
  String get recoveryCodesSaved;

  /// No description provided for @sessionsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Sessions actives'**
  String get sessionsTitle;

  /// No description provided for @sessionsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Postes connectés à votre compte. Révoquez ceux que vous ne reconnaissez pas.'**
  String get sessionsDescription;

  /// No description provided for @thisDevice.
  ///
  /// In fr, this message translates to:
  /// **'Ce poste'**
  String get thisDevice;

  /// No description provided for @lastActivity.
  ///
  /// In fr, this message translates to:
  /// **'actif {time}'**
  String lastActivity(String time);

  /// No description provided for @sessionRevoked.
  ///
  /// In fr, this message translates to:
  /// **'Session révoquée'**
  String get sessionRevoked;

  /// No description provided for @sessionsRevoked.
  ///
  /// In fr, this message translates to:
  /// **'Sessions révoquées'**
  String get sessionsRevoked;

  /// No description provided for @serverTitle.
  ///
  /// In fr, this message translates to:
  /// **'Serveur'**
  String get serverTitle;

  /// No description provided for @serverDescription.
  ///
  /// In fr, this message translates to:
  /// **'Serveur Voyaj auquel ce poste se synchronise.'**
  String get serverDescription;

  /// No description provided for @serverAddress.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get serverAddress;

  /// No description provided for @serverStatus.
  ///
  /// In fr, this message translates to:
  /// **'État'**
  String get serverStatus;

  /// No description provided for @serverVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version {version}'**
  String serverVersion(String version);

  /// No description provided for @changeServerMessage.
  ///
  /// In fr, this message translates to:
  /// **'Vous serez déconnecté. Les données locales d\'un autre utilisateur seront effacées à la prochaine connexion.'**
  String get changeServerMessage;

  /// No description provided for @deviceTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ce poste'**
  String get deviceTitle;

  /// No description provided for @deviceDescription.
  ///
  /// In fr, this message translates to:
  /// **'Les données sont stockées chiffrées sur ce poste pour fonctionner hors ligne.'**
  String get deviceDescription;

  /// No description provided for @deviceId.
  ///
  /// In fr, this message translates to:
  /// **'Identifiant du poste'**
  String get deviceId;

  /// No description provided for @appVersionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Version de l\'application'**
  String get appVersionLabel;

  /// No description provided for @usersSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Comptes ayant accès au CRM.'**
  String get usersSubtitle;

  /// No description provided for @userNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel utilisateur'**
  String get userNew;

  /// No description provided for @userEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'utilisateur'**
  String get userEdit;

  /// No description provided for @userName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get userName;

  /// No description provided for @rolesLabel.
  ///
  /// In fr, this message translates to:
  /// **'Rôles'**
  String get rolesLabel;

  /// No description provided for @statusLabel.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get statusLabel;

  /// No description provided for @statusActive.
  ///
  /// In fr, this message translates to:
  /// **'Actif'**
  String get statusActive;

  /// No description provided for @statusDisabled.
  ///
  /// In fr, this message translates to:
  /// **'Désactivé'**
  String get statusDisabled;

  /// No description provided for @lastLogin.
  ///
  /// In fr, this message translates to:
  /// **'Dernière connexion'**
  String get lastLogin;

  /// No description provided for @initialPassword.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe initial'**
  String get initialPassword;

  /// No description provided for @accountActive.
  ///
  /// In fr, this message translates to:
  /// **'Compte actif'**
  String get accountActive;

  /// No description provided for @revokeAllSessions.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecter partout'**
  String get revokeAllSessions;

  /// No description provided for @rolesSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Les rôles regroupent des permissions ; un utilisateur peut en avoir plusieurs.'**
  String get rolesSubtitle;

  /// No description provided for @roleNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau rôle'**
  String get roleNew;

  /// No description provided for @roleEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rôle'**
  String get roleEdit;

  /// No description provided for @roleName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du rôle'**
  String get roleName;

  /// No description provided for @roleKey.
  ///
  /// In fr, this message translates to:
  /// **'Identifiant'**
  String get roleKey;

  /// No description provided for @systemRole.
  ///
  /// In fr, this message translates to:
  /// **'Rôle système'**
  String get systemRole;

  /// No description provided for @permissionsLabel.
  ///
  /// In fr, this message translates to:
  /// **'Permissions'**
  String get permissionsLabel;

  /// No description provided for @noPermission.
  ///
  /// In fr, this message translates to:
  /// **'Aucune permission.'**
  String get noPermission;

  /// No description provided for @roleDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce rôle ?'**
  String get roleDeleteTitle;

  /// No description provided for @roleDeleteMessage.
  ///
  /// In fr, this message translates to:
  /// **'Le rôle « {name} » sera retiré de tous les utilisateurs.'**
  String roleDeleteMessage(String name);

  /// No description provided for @auditSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les actions, horodatées et chaînées (inaltérables).'**
  String get auditSubtitle;

  /// No description provided for @auditDate.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get auditDate;

  /// No description provided for @auditActor.
  ///
  /// In fr, this message translates to:
  /// **'Auteur'**
  String get auditActor;

  /// No description provided for @auditAction.
  ///
  /// In fr, this message translates to:
  /// **'Action'**
  String get auditAction;

  /// No description provided for @auditEntity.
  ///
  /// In fr, this message translates to:
  /// **'Objet'**
  String get auditEntity;

  /// No description provided for @auditDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails'**
  String get auditDetails;

  /// No description provided for @auditSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get auditSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
