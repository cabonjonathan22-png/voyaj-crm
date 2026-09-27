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

  /// No description provided for @yes.
  ///
  /// In fr, this message translates to:
  /// **'Oui'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get no;

  /// No description provided for @sectionData.
  ///
  /// In fr, this message translates to:
  /// **'Données'**
  String get sectionData;

  /// No description provided for @navOrganisations.
  ///
  /// In fr, this message translates to:
  /// **'Organisations'**
  String get navOrganisations;

  /// No description provided for @navContacts.
  ///
  /// In fr, this message translates to:
  /// **'Contacts'**
  String get navContacts;

  /// No description provided for @navElected.
  ///
  /// In fr, this message translates to:
  /// **'Élus'**
  String get navElected;

  /// No description provided for @navPipelines.
  ///
  /// In fr, this message translates to:
  /// **'Pipelines'**
  String get navPipelines;

  /// No description provided for @navTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches'**
  String get navTasks;

  /// No description provided for @navMap.
  ///
  /// In fr, this message translates to:
  /// **'Carte'**
  String get navMap;

  /// No description provided for @navDuplicates.
  ///
  /// In fr, this message translates to:
  /// **'Doublons'**
  String get navDuplicates;

  /// No description provided for @recordNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Cet élément n\'existe pas ou a été supprimé.'**
  String get recordNotFound;

  /// No description provided for @tabOverview.
  ///
  /// In fr, this message translates to:
  /// **'Aperçu'**
  String get tabOverview;

  /// No description provided for @tabDeals.
  ///
  /// In fr, this message translates to:
  /// **'Affaires'**
  String get tabDeals;

  /// No description provided for @tabActivities.
  ///
  /// In fr, this message translates to:
  /// **'Activités'**
  String get tabActivities;

  /// No description provided for @tabFiles.
  ///
  /// In fr, this message translates to:
  /// **'Fichiers'**
  String get tabFiles;

  /// No description provided for @tabPositions.
  ///
  /// In fr, this message translates to:
  /// **'Postes et mandats'**
  String get tabPositions;

  /// No description provided for @copyEmail.
  ///
  /// In fr, this message translates to:
  /// **'Copier l\'email'**
  String get copyEmail;

  /// No description provided for @moveUp.
  ///
  /// In fr, this message translates to:
  /// **'Monter'**
  String get moveUp;

  /// No description provided for @moveDown.
  ///
  /// In fr, this message translates to:
  /// **'Descendre'**
  String get moveDown;

  /// No description provided for @formInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Nombre invalide.'**
  String get formInvalidNumber;

  /// No description provided for @formNone.
  ///
  /// In fr, this message translates to:
  /// **'— Aucun —'**
  String get formNone;

  /// No description provided for @formChoose.
  ///
  /// In fr, this message translates to:
  /// **'Choisir…'**
  String get formChoose;

  /// No description provided for @customFieldsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Champs personnalisés'**
  String get customFieldsTitle;

  /// No description provided for @organisationsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Collectivités, EPCI, AOM, festivals et partenaires.'**
  String get organisationsSubtitle;

  /// No description provided for @organisationNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle organisation'**
  String get organisationNew;

  /// No description provided for @organisationEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'organisation'**
  String get organisationEdit;

  /// No description provided for @organisationCreated.
  ///
  /// In fr, this message translates to:
  /// **'Organisation créée.'**
  String get organisationCreated;

  /// No description provided for @organisationDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Supprimer cette organisation ?} other{Supprimer {count} organisations ?}}'**
  String organisationDeleteTitle(int count);

  /// No description provided for @organisationDeleteMessage.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{« {names} » sera supprimée pour toute l\'équipe. Ses contacts et affaires sont conservés.} other{{names}… seront supprimées pour toute l\'équipe. Leurs contacts et affaires sont conservés.}}'**
  String organisationDeleteMessage(int count, String names);

  /// No description provided for @organisationDeleted.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Organisation supprimée.} other{{count} organisations supprimées.}}'**
  String organisationDeleted(int count);

  /// No description provided for @organisationsEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucune organisation'**
  String get organisationsEmptyTitle;

  /// No description provided for @organisationsEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Créez une organisation ou importez un fichier CSV (communes, EPCI, festivals…).'**
  String get organisationsEmptyMessage;

  /// No description provided for @orgName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get orgName;

  /// No description provided for @orgKind.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get orgKind;

  /// No description provided for @orgStatus.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get orgStatus;

  /// No description provided for @orgParent.
  ///
  /// In fr, this message translates to:
  /// **'Organisation parente'**
  String get orgParent;

  /// No description provided for @orgSectionContact.
  ///
  /// In fr, this message translates to:
  /// **'Coordonnées'**
  String get orgSectionContact;

  /// No description provided for @orgSectionAddress.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get orgSectionAddress;

  /// No description provided for @orgSectionIdentity.
  ///
  /// In fr, this message translates to:
  /// **'Identification'**
  String get orgSectionIdentity;

  /// No description provided for @orgSectionHierarchy.
  ///
  /// In fr, this message translates to:
  /// **'Rattachement'**
  String get orgSectionHierarchy;

  /// No description provided for @orgSectionTraceability.
  ///
  /// In fr, this message translates to:
  /// **'Traçabilité'**
  String get orgSectionTraceability;

  /// No description provided for @orgPhone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get orgPhone;

  /// No description provided for @orgEmail.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get orgEmail;

  /// No description provided for @orgWebsite.
  ///
  /// In fr, this message translates to:
  /// **'Site web'**
  String get orgWebsite;

  /// No description provided for @orgAddress.
  ///
  /// In fr, this message translates to:
  /// **'Adresse'**
  String get orgAddress;

  /// No description provided for @orgPostalCode.
  ///
  /// In fr, this message translates to:
  /// **'Code postal'**
  String get orgPostalCode;

  /// No description provided for @orgCity.
  ///
  /// In fr, this message translates to:
  /// **'Ville'**
  String get orgCity;

  /// No description provided for @orgDepartement.
  ///
  /// In fr, this message translates to:
  /// **'Département'**
  String get orgDepartement;

  /// No description provided for @orgDepartementShort.
  ///
  /// In fr, this message translates to:
  /// **'Dép.'**
  String get orgDepartementShort;

  /// No description provided for @orgRegion.
  ///
  /// In fr, this message translates to:
  /// **'Région'**
  String get orgRegion;

  /// No description provided for @orgLatitude.
  ///
  /// In fr, this message translates to:
  /// **'Latitude'**
  String get orgLatitude;

  /// No description provided for @orgLongitude.
  ///
  /// In fr, this message translates to:
  /// **'Longitude'**
  String get orgLongitude;

  /// No description provided for @orgSiren.
  ///
  /// In fr, this message translates to:
  /// **'SIREN'**
  String get orgSiren;

  /// No description provided for @orgSiret.
  ///
  /// In fr, this message translates to:
  /// **'SIRET'**
  String get orgSiret;

  /// No description provided for @orgInsee.
  ///
  /// In fr, this message translates to:
  /// **'Code INSEE'**
  String get orgInsee;

  /// No description provided for @orgPopulation.
  ///
  /// In fr, this message translates to:
  /// **'Population'**
  String get orgPopulation;

  /// No description provided for @orgDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get orgDescription;

  /// No description provided for @orgSource.
  ///
  /// In fr, this message translates to:
  /// **'Source'**
  String get orgSource;

  /// No description provided for @orgCollectedAt.
  ///
  /// In fr, this message translates to:
  /// **'Collectée le'**
  String get orgCollectedAt;

  /// No description provided for @orgChildren.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 organisation rattachée} other{{count} organisations rattachées}}'**
  String orgChildren(int count);

  /// No description provided for @contactsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Personnes, agents et élus des organisations.'**
  String get contactsSubtitle;

  /// No description provided for @contactNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau contact'**
  String get contactNew;

  /// No description provided for @contactEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le contact'**
  String get contactEdit;

  /// No description provided for @contactCreated.
  ///
  /// In fr, this message translates to:
  /// **'Contact créé.'**
  String get contactCreated;

  /// No description provided for @contactDeleteTitle.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Supprimer ce contact ?} other{Supprimer {count} contacts ?}}'**
  String contactDeleteTitle(int count);

  /// No description provided for @contactDeleteMessage.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{« {names} » sera supprimé pour toute l\'équipe.} other{{names}… seront supprimés pour toute l\'équipe.}}'**
  String contactDeleteMessage(int count, String names);

  /// No description provided for @contactDeleted.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{Contact supprimé.} other{{count} contacts supprimés.}}'**
  String contactDeleted(int count);

  /// No description provided for @contactsEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun contact'**
  String get contactsEmptyTitle;

  /// No description provided for @contactsEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez les interlocuteurs de vos organisations ou importez un fichier CSV.'**
  String get contactsEmptyMessage;

  /// No description provided for @contactsAttached.
  ///
  /// In fr, this message translates to:
  /// **'Contacts rattachés'**
  String get contactsAttached;

  /// No description provided for @contactName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get contactName;

  /// No description provided for @contactCivility.
  ///
  /// In fr, this message translates to:
  /// **'Civilité'**
  String get contactCivility;

  /// No description provided for @contactFirstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get contactFirstName;

  /// No description provided for @contactLastName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get contactLastName;

  /// No description provided for @contactOrganisation.
  ///
  /// In fr, this message translates to:
  /// **'Organisation'**
  String get contactOrganisation;

  /// No description provided for @contactJobTitle.
  ///
  /// In fr, this message translates to:
  /// **'Fonction'**
  String get contactJobTitle;

  /// No description provided for @contactService.
  ///
  /// In fr, this message translates to:
  /// **'Service'**
  String get contactService;

  /// No description provided for @contactMobile.
  ///
  /// In fr, this message translates to:
  /// **'Mobile'**
  String get contactMobile;

  /// No description provided for @contactNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get contactNotes;

  /// No description provided for @contactDoNotContact.
  ///
  /// In fr, this message translates to:
  /// **'Ne pas contacter (opposition, RGPD)'**
  String get contactDoNotContact;

  /// No description provided for @contactDoNotContactShort.
  ///
  /// In fr, this message translates to:
  /// **'Ne pas contacter'**
  String get contactDoNotContactShort;

  /// No description provided for @positionNew.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un poste'**
  String get positionNew;

  /// No description provided for @positionEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le poste'**
  String get positionEdit;

  /// No description provided for @positionAddElected.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un mandat'**
  String get positionAddElected;

  /// No description provided for @positionContact.
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get positionContact;

  /// No description provided for @positionIsElected.
  ///
  /// In fr, this message translates to:
  /// **'Mandat électif'**
  String get positionIsElected;

  /// No description provided for @positionMandate.
  ///
  /// In fr, this message translates to:
  /// **'Fonction élective'**
  String get positionMandate;

  /// No description provided for @positionDelegation.
  ///
  /// In fr, this message translates to:
  /// **'Délégation'**
  String get positionDelegation;

  /// No description provided for @positionStart.
  ///
  /// In fr, this message translates to:
  /// **'Début'**
  String get positionStart;

  /// No description provided for @positionEnd.
  ///
  /// In fr, this message translates to:
  /// **'Fin'**
  String get positionEnd;

  /// No description provided for @positionElected.
  ///
  /// In fr, this message translates to:
  /// **'Élu'**
  String get positionElected;

  /// No description provided for @positionUntil.
  ///
  /// In fr, this message translates to:
  /// **'jusqu\'au {date}'**
  String positionUntil(String date);

  /// No description provided for @positionsCurrent.
  ///
  /// In fr, this message translates to:
  /// **'Postes et mandats en cours'**
  String get positionsCurrent;

  /// No description provided for @positionsPast.
  ///
  /// In fr, this message translates to:
  /// **'Postes et mandats passés'**
  String get positionsPast;

  /// No description provided for @positionsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun poste ni mandat.'**
  String get positionsEmpty;

  /// No description provided for @electedSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Mandats électifs en cours (maires, adjoints, conseillers, présidents…).'**
  String get electedSubtitle;

  /// No description provided for @electedEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun élu'**
  String get electedEmptyTitle;

  /// No description provided for @electedEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez un mandat depuis la fiche d\'un contact ou d\'une organisation.'**
  String get electedEmptyMessage;

  /// No description provided for @pipelinesSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Suivi des affaires par étape.'**
  String get pipelinesSubtitle;

  /// No description provided for @dealNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle affaire'**
  String get dealNew;

  /// No description provided for @dealEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'affaire'**
  String get dealEdit;

  /// No description provided for @dealTitle.
  ///
  /// In fr, this message translates to:
  /// **'Intitulé'**
  String get dealTitle;

  /// No description provided for @dealStage.
  ///
  /// In fr, this message translates to:
  /// **'Étape'**
  String get dealStage;

  /// No description provided for @dealContact.
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get dealContact;

  /// No description provided for @dealAmount.
  ///
  /// In fr, this message translates to:
  /// **'Montant (€)'**
  String get dealAmount;

  /// No description provided for @dealProbability.
  ///
  /// In fr, this message translates to:
  /// **'Probabilité (%)'**
  String get dealProbability;

  /// No description provided for @dealExpectedClose.
  ///
  /// In fr, this message translates to:
  /// **'Clôture prévue'**
  String get dealExpectedClose;

  /// No description provided for @dealCloseOn.
  ///
  /// In fr, this message translates to:
  /// **'clôture le {date}'**
  String dealCloseOn(String date);

  /// No description provided for @dealLate.
  ///
  /// In fr, this message translates to:
  /// **'En retard'**
  String get dealLate;

  /// No description provided for @dealSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher une affaire…'**
  String get dealSearch;

  /// No description provided for @dealsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune affaire.'**
  String get dealsEmpty;

  /// No description provided for @dealsOpenTotal.
  ///
  /// In fr, this message translates to:
  /// **'En cours : {amount}'**
  String dealsOpenTotal(String amount);

  /// No description provided for @pipelineTotals.
  ///
  /// In fr, this message translates to:
  /// **'En cours : {open} · Pondéré : {weighted}'**
  String pipelineTotals(String open, String weighted);

  /// No description provided for @pipelineConfigure.
  ///
  /// In fr, this message translates to:
  /// **'Configurer'**
  String get pipelineConfigure;

  /// No description provided for @pipelineNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau pipeline'**
  String get pipelineNew;

  /// No description provided for @pipelineName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du pipeline'**
  String get pipelineName;

  /// No description provided for @pipelineKind.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get pipelineKind;

  /// No description provided for @pipelineArchived.
  ///
  /// In fr, this message translates to:
  /// **'Archivé (masqué du Kanban)'**
  String get pipelineArchived;

  /// No description provided for @pipelineCreateDefaults.
  ///
  /// In fr, this message translates to:
  /// **'Créer les pipelines Collectivités et Festivals'**
  String get pipelineCreateDefaults;

  /// No description provided for @pipelineSetupFirst.
  ///
  /// In fr, this message translates to:
  /// **'Configurer un pipeline'**
  String get pipelineSetupFirst;

  /// No description provided for @pipelinesEmptyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun pipeline'**
  String get pipelinesEmptyTitle;

  /// No description provided for @pipelinesEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Créez les pipelines par défaut (étapes modifiables ensuite) ou un pipeline sur mesure.'**
  String get pipelinesEmptyMessage;

  /// No description provided for @pipelinesEmptyReadOnly.
  ///
  /// In fr, this message translates to:
  /// **'Un administrateur doit configurer les pipelines.'**
  String get pipelinesEmptyReadOnly;

  /// No description provided for @stagesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Étapes'**
  String get stagesTitle;

  /// No description provided for @stagesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Ce pipeline n\'a pas d\'étape.'**
  String get stagesEmpty;

  /// No description provided for @stageNew.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une étape'**
  String get stageNew;

  /// No description provided for @stageEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'étape'**
  String get stageEdit;

  /// No description provided for @stageName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'étape'**
  String get stageName;

  /// No description provided for @stageOutcome.
  ///
  /// In fr, this message translates to:
  /// **'Issue'**
  String get stageOutcome;

  /// No description provided for @stageDefaultNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau'**
  String get stageDefaultNew;

  /// No description provided for @stageInUse.
  ///
  /// In fr, this message translates to:
  /// **'Déplacez d\'abord les affaires de cette étape.'**
  String get stageInUse;

  /// No description provided for @activityNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle activité'**
  String get activityNew;

  /// No description provided for @activityEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'activité'**
  String get activityEdit;

  /// No description provided for @activitySaved.
  ///
  /// In fr, this message translates to:
  /// **'Activité enregistrée.'**
  String get activitySaved;

  /// No description provided for @activityKind.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get activityKind;

  /// No description provided for @activitySubject.
  ///
  /// In fr, this message translates to:
  /// **'Objet'**
  String get activitySubject;

  /// No description provided for @activityBody.
  ///
  /// In fr, this message translates to:
  /// **'Contenu'**
  String get activityBody;

  /// No description provided for @activityStart.
  ///
  /// In fr, this message translates to:
  /// **'Début'**
  String get activityStart;

  /// No description provided for @activityEnd.
  ///
  /// In fr, this message translates to:
  /// **'Fin'**
  String get activityEnd;

  /// No description provided for @activityDue.
  ///
  /// In fr, this message translates to:
  /// **'Échéance'**
  String get activityDue;

  /// No description provided for @activityRemind.
  ///
  /// In fr, this message translates to:
  /// **'Rappel'**
  String get activityRemind;

  /// No description provided for @activityDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminée'**
  String get activityDone;

  /// No description provided for @activityDeal.
  ///
  /// In fr, this message translates to:
  /// **'Affaire'**
  String get activityDeal;

  /// No description provided for @activityOpenTasks.
  ///
  /// In fr, this message translates to:
  /// **'Tâches à faire'**
  String get activityOpenTasks;

  /// No description provided for @activityHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get activityHistory;

  /// No description provided for @activityEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune activité.'**
  String get activityEmpty;

  /// No description provided for @activityDueOn.
  ///
  /// In fr, this message translates to:
  /// **'échéance {date}'**
  String activityDueOn(String date);

  /// No description provided for @tasksSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Tâches à faire et journal des échanges.'**
  String get tasksSubtitle;

  /// No description provided for @taskNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle tâche'**
  String get taskNew;

  /// No description provided for @tasksTodo.
  ///
  /// In fr, this message translates to:
  /// **'À faire ({count})'**
  String tasksTodo(int count);

  /// No description provided for @tasksOverdue.
  ///
  /// In fr, this message translates to:
  /// **'En retard ({count})'**
  String tasksOverdue(int count);

  /// No description provided for @tasksToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui ({count})'**
  String tasksToday(int count);

  /// No description provided for @tasksDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminées'**
  String get tasksDone;

  /// No description provided for @tasksActivities.
  ///
  /// In fr, this message translates to:
  /// **'Activités'**
  String get tasksActivities;

  /// No description provided for @tasksMine.
  ///
  /// In fr, this message translates to:
  /// **'Mes tâches uniquement'**
  String get tasksMine;

  /// No description provided for @tasksEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune tâche.'**
  String get tasksEmpty;

  /// No description provided for @attachmentAdd.
  ///
  /// In fr, this message translates to:
  /// **'Joindre un fichier'**
  String get attachmentAdd;

  /// No description provided for @attachmentDownload.
  ///
  /// In fr, this message translates to:
  /// **'Télécharger'**
  String get attachmentDownload;

  /// No description provided for @attachmentsHint.
  ///
  /// In fr, this message translates to:
  /// **'Fichiers partagés avec l\'équipe (25 Mo maximum, connexion au serveur requise).'**
  String get attachmentsHint;

  /// No description provided for @attachmentsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun fichier joint.'**
  String get attachmentsEmpty;

  /// No description provided for @attachmentUploaded.
  ///
  /// In fr, this message translates to:
  /// **'Fichier joint.'**
  String get attachmentUploaded;

  /// No description provided for @attachmentDownloaded.
  ///
  /// In fr, this message translates to:
  /// **'Fichier enregistré.'**
  String get attachmentDownloaded;

  /// No description provided for @attachmentTooLarge.
  ///
  /// In fr, this message translates to:
  /// **'Fichier trop volumineux (25 Mo maximum).'**
  String get attachmentTooLarge;

  /// No description provided for @tagAdd.
  ///
  /// In fr, this message translates to:
  /// **'Tag'**
  String get tagAdd;

  /// No description provided for @tagAddTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un tag'**
  String get tagAddTitle;

  /// No description provided for @tagApplyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Appliquer un tag'**
  String get tagApplyTitle;

  /// No description provided for @tagApplied.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Tag déjà appliqué.} =1{Tag appliqué à 1 élément.} other{Tag appliqué à {count} éléments.}}'**
  String tagApplied(int count);

  /// No description provided for @segments.
  ///
  /// In fr, this message translates to:
  /// **'Segments'**
  String get segments;

  /// No description provided for @segmentNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucun segment partagé'**
  String get segmentNone;

  /// No description provided for @segmentSaveAs.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer comme segment…'**
  String get segmentSaveAs;

  /// No description provided for @segmentSaveDescription.
  ///
  /// In fr, this message translates to:
  /// **'Les filtres et la recherche actuels seront partagés avec toute l\'équipe.'**
  String get segmentSaveDescription;

  /// No description provided for @segmentName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du segment'**
  String get segmentName;

  /// No description provided for @segmentDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get segmentDescription;

  /// No description provided for @segmentSaved.
  ///
  /// In fr, this message translates to:
  /// **'Segment enregistré.'**
  String get segmentSaved;

  /// No description provided for @segmentDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer « {name} »'**
  String segmentDelete(String name);

  /// No description provided for @exportCsv.
  ///
  /// In fr, this message translates to:
  /// **'Exporter en CSV'**
  String get exportCsv;

  /// No description provided for @exportDone.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 ligne exportée.} other{{count} lignes exportées.}}'**
  String exportDone(int count);

  /// No description provided for @mapSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'{shown} organisations affichées · {missing} sans coordonnées'**
  String mapSubtitle(int shown, int missing);

  /// No description provided for @mapAllKinds.
  ///
  /// In fr, this message translates to:
  /// **'Tous les types'**
  String get mapAllKinds;

  /// No description provided for @mapEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune organisation n\'a de coordonnées (latitude et longitude).'**
  String get mapEmpty;

  /// No description provided for @customFieldsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Champs supplémentaires affichés dans les fiches, les tableaux et l\'import.'**
  String get customFieldsDescription;

  /// No description provided for @customFieldsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun champ personnalisé.'**
  String get customFieldsEmpty;

  /// No description provided for @customFieldNew.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un champ'**
  String get customFieldNew;

  /// No description provided for @customFieldEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le champ'**
  String get customFieldEdit;

  /// No description provided for @customFieldLabel.
  ///
  /// In fr, this message translates to:
  /// **'Libellé'**
  String get customFieldLabel;

  /// No description provided for @customFieldType.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get customFieldType;

  /// No description provided for @customFieldOptions.
  ///
  /// In fr, this message translates to:
  /// **'Choix (liste)'**
  String get customFieldOptions;

  /// No description provided for @customFieldOptionsHint.
  ///
  /// In fr, this message translates to:
  /// **'Choix séparés par des virgules'**
  String get customFieldOptionsHint;

  /// No description provided for @duplicatesSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Organisations et contacts probablement saisis plusieurs fois.'**
  String get duplicatesSubtitle;

  /// No description provided for @duplicatesNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucun doublon détecté'**
  String get duplicatesNone;

  /// No description provided for @duplicatesNoneMessage.
  ///
  /// In fr, this message translates to:
  /// **'Comparaison sur SIRET, SIREN, code INSEE, nom + lieu, email et mobile.'**
  String get duplicatesNoneMessage;

  /// No description provided for @duplicatesGroup.
  ///
  /// In fr, this message translates to:
  /// **'{count} fiches semblables'**
  String duplicatesGroup(int count);

  /// No description provided for @duplicatesIgnore.
  ///
  /// In fr, this message translates to:
  /// **'Ce ne sont pas des doublons'**
  String get duplicatesIgnore;

  /// No description provided for @duplicatesMerge.
  ///
  /// In fr, this message translates to:
  /// **'Fusionner'**
  String get duplicatesMerge;

  /// No description provided for @duplicatesKept.
  ///
  /// In fr, this message translates to:
  /// **'Conservée'**
  String get duplicatesKept;

  /// No description provided for @duplicatesCreated.
  ///
  /// In fr, this message translates to:
  /// **'créée {when}'**
  String duplicatesCreated(String when);

  /// No description provided for @duplicatesMergeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Fusionner les fiches ?'**
  String get duplicatesMergeTitle;

  /// No description provided for @duplicatesMergeMessage.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{La fiche en double sera supprimée ; ses informations manquantes, contacts, affaires, activités, fichiers et tags sont reportés sur la fiche conservée.} other{Les {count} fiches en double seront supprimées ; leurs informations manquantes, contacts, affaires, activités, fichiers et tags sont reportés sur la fiche conservée.}}'**
  String duplicatesMergeMessage(int count);

  /// No description provided for @duplicatesMerged.
  ///
  /// In fr, this message translates to:
  /// **'Fiches fusionnées.'**
  String get duplicatesMerged;

  /// No description provided for @importCsv.
  ///
  /// In fr, this message translates to:
  /// **'Importer'**
  String get importCsv;

  /// No description provided for @importTitleOrganisations.
  ///
  /// In fr, this message translates to:
  /// **'Importer des organisations'**
  String get importTitleOrganisations;

  /// No description provided for @importTitleContacts.
  ///
  /// In fr, this message translates to:
  /// **'Importer des contacts'**
  String get importTitleContacts;

  /// No description provided for @importPickHelp.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez un fichier CSV (export Excel « CSV UTF-8 » ou séparateur point-virgule). La première ligne doit contenir les en-têtes. Colonnes reconnues automatiquement :'**
  String get importPickHelp;

  /// No description provided for @importChooseFile.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un fichier CSV'**
  String get importChooseFile;

  /// No description provided for @importEmptyFile.
  ///
  /// In fr, this message translates to:
  /// **'Le fichier est vide ou illisible.'**
  String get importEmptyFile;

  /// No description provided for @importFileSummary.
  ///
  /// In fr, this message translates to:
  /// **'{name} : {count} lignes'**
  String importFileSummary(String name, int count);

  /// No description provided for @importMappingHelp.
  ///
  /// In fr, this message translates to:
  /// **'Associez chaque colonne à un champ (les colonnes ignorées ne sont pas importées).'**
  String get importMappingHelp;

  /// No description provided for @importIgnore.
  ///
  /// In fr, this message translates to:
  /// **'Ignorer'**
  String get importIgnore;

  /// No description provided for @importDefaultKind.
  ///
  /// In fr, this message translates to:
  /// **'Type par défaut'**
  String get importDefaultKind;

  /// No description provided for @importDefaultStatus.
  ///
  /// In fr, this message translates to:
  /// **'Statut par défaut'**
  String get importDefaultStatus;

  /// No description provided for @importSkipDuplicates.
  ///
  /// In fr, this message translates to:
  /// **'Ignorer les doublons ({count} détectés : SIRET, INSEE, nom + lieu, email…)'**
  String importSkipDuplicates(int count);

  /// No description provided for @importRequiredMissing.
  ///
  /// In fr, this message translates to:
  /// **'Associez une colonne au champ obligatoire « {field} ».'**
  String importRequiredMissing(String field);

  /// No description provided for @importProblems.
  ///
  /// In fr, this message translates to:
  /// **'{count} valeurs non reconnues (valeur par défaut appliquée) :'**
  String importProblems(int count);

  /// No description provided for @importProblemKind.
  ///
  /// In fr, this message translates to:
  /// **'type inconnu « {value} »'**
  String importProblemKind(String value);

  /// No description provided for @importProblemStatus.
  ///
  /// In fr, this message translates to:
  /// **'statut inconnu « {value} »'**
  String importProblemStatus(String value);

  /// No description provided for @importProblemNumber.
  ///
  /// In fr, this message translates to:
  /// **'nombre invalide « {value} »'**
  String importProblemNumber(String value);

  /// No description provided for @importLine.
  ///
  /// In fr, this message translates to:
  /// **'Ligne {line} : {message}'**
  String importLine(int line, String message);

  /// No description provided for @importRgpdNotice.
  ///
  /// In fr, this message translates to:
  /// **'La source (nom du fichier) et la date de collecte sont enregistrées sur chaque fiche importée (RGPD).'**
  String get importRgpdNotice;

  /// No description provided for @importSource.
  ///
  /// In fr, this message translates to:
  /// **'Import CSV {file}'**
  String importSource(String file);

  /// No description provided for @importBack.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get importBack;

  /// No description provided for @importRun.
  ///
  /// In fr, this message translates to:
  /// **'Importer {count} lignes'**
  String importRun(int count);

  /// No description provided for @importProgress.
  ///
  /// In fr, this message translates to:
  /// **'{done} / {total} lignes traitées'**
  String importProgress(int done, int total);

  /// No description provided for @importDone.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{Aucune fiche importée.} =1{1 fiche importée.} other{{count} fiches importées.}}'**
  String importDone(int count);

  /// No description provided for @importDuplicatesSkipped.
  ///
  /// In fr, this message translates to:
  /// **'Doublons ignorés'**
  String get importDuplicatesSkipped;

  /// No description provided for @importOrganisationsCreated.
  ///
  /// In fr, this message translates to:
  /// **'Organisations créées'**
  String get importOrganisationsCreated;

  /// No description provided for @importTagsCreated.
  ///
  /// In fr, this message translates to:
  /// **'Tags créés'**
  String get importTagsCreated;

  /// No description provided for @importRejected.
  ///
  /// In fr, this message translates to:
  /// **'Lignes refusées'**
  String get importRejected;

  /// No description provided for @refresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser'**
  String get refresh;

  /// No description provided for @navPublicData.
  ///
  /// In fr, this message translates to:
  /// **'Données publiques'**
  String get navPublicData;

  /// No description provided for @publicDataSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Collectivités, AOM et festivals importés depuis les sources officielles.'**
  String get publicDataSubtitle;

  /// No description provided for @publicDataHelp.
  ///
  /// In fr, this message translates to:
  /// **'Les imports créent ou mettent à jour des organisations (statut « À prospecter » à la création), rattachées à leur parent (commune → EPCI → département → région). Un champ modifié par un utilisateur n\'est jamais écrasé, une fiche supprimée n\'est pas recréée. Les sources activées sont réimportées chaque nuit.'**
  String get publicDataHelp;

  /// No description provided for @publicDataProvider.
  ///
  /// In fr, this message translates to:
  /// **'Source : {provider}'**
  String publicDataProvider(String provider);

  /// No description provided for @publicDataDaily.
  ///
  /// In fr, this message translates to:
  /// **'Import quotidien'**
  String get publicDataDaily;

  /// No description provided for @publicDataRunNow.
  ///
  /// In fr, this message translates to:
  /// **'Importer maintenant'**
  String get publicDataRunNow;

  /// No description provided for @publicDataStarted.
  ///
  /// In fr, this message translates to:
  /// **'Import lancé : il se poursuit sur le serveur.'**
  String get publicDataStarted;

  /// No description provided for @publicDataScope.
  ///
  /// In fr, this message translates to:
  /// **'Périmètre'**
  String get publicDataScope;

  /// No description provided for @publicDataScopeAll.
  ///
  /// In fr, this message translates to:
  /// **'Toute la France'**
  String get publicDataScopeAll;

  /// No description provided for @publicDataScopeHelp.
  ///
  /// In fr, this message translates to:
  /// **'Codes des départements à importer, séparés par des virgules. Laisser vide pour toute la France.'**
  String get publicDataScopeHelp;

  /// No description provided for @publicDataScopeCodes.
  ///
  /// In fr, this message translates to:
  /// **'Départements'**
  String get publicDataScopeCodes;

  /// No description provided for @publicDataScopeInvalid.
  ///
  /// In fr, this message translates to:
  /// **'Codes invalides : {codes}'**
  String publicDataScopeInvalid(String codes);

  /// No description provided for @publicDataCommunesWarning.
  ///
  /// In fr, this message translates to:
  /// **'Sans périmètre, les 35 000 communes de France seront importées : choisissez plutôt vos départements.'**
  String get publicDataCommunesWarning;

  /// No description provided for @publicDataLastRun.
  ///
  /// In fr, this message translates to:
  /// **'Dernier import'**
  String get publicDataLastRun;

  /// No description provided for @publicDataNever.
  ///
  /// In fr, this message translates to:
  /// **'Jamais importé'**
  String get publicDataNever;

  /// No description provided for @publicDataRunning.
  ///
  /// In fr, this message translates to:
  /// **'Import en cours…'**
  String get publicDataRunning;

  /// No description provided for @publicDataCounts.
  ///
  /// In fr, this message translates to:
  /// **'{fetched} lues · {created} créées · {updated} mises à jour · {unchanged} inchangées'**
  String publicDataCounts(int fetched, int created, int updated, int unchanged);

  /// No description provided for @publicDataStatusRunning.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get publicDataStatusRunning;

  /// No description provided for @publicDataStatusSucceeded.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get publicDataStatusSucceeded;

  /// No description provided for @publicDataStatusFailed.
  ///
  /// In fr, this message translates to:
  /// **'Échec'**
  String get publicDataStatusFailed;

  /// No description provided for @publicDataHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique des imports'**
  String get publicDataHistory;

  /// No description provided for @publicDataTriggerSchedule.
  ///
  /// In fr, this message translates to:
  /// **'Planifié'**
  String get publicDataTriggerSchedule;

  /// No description provided for @publicDataTriggerManual.
  ///
  /// In fr, this message translates to:
  /// **'Manuel'**
  String get publicDataTriggerManual;

  /// No description provided for @navEmails.
  ///
  /// In fr, this message translates to:
  /// **'Emails'**
  String get navEmails;

  /// No description provided for @emailsSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Boîte de réception, modèles et séquences.'**
  String get emailsSubtitle;

  /// No description provided for @emailInbox.
  ///
  /// In fr, this message translates to:
  /// **'Boîte de réception'**
  String get emailInbox;

  /// No description provided for @emailTemplates.
  ///
  /// In fr, this message translates to:
  /// **'Modèles'**
  String get emailTemplates;

  /// No description provided for @emailSequences.
  ///
  /// In fr, this message translates to:
  /// **'Séquences'**
  String get emailSequences;

  /// No description provided for @emailNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau message'**
  String get emailNew;

  /// No description provided for @emailReply.
  ///
  /// In fr, this message translates to:
  /// **'Répondre'**
  String get emailReply;

  /// No description provided for @emailSend.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get emailSend;

  /// No description provided for @emailSent.
  ///
  /// In fr, this message translates to:
  /// **'Email envoyé.'**
  String get emailSent;

  /// No description provided for @emailFrom.
  ///
  /// In fr, this message translates to:
  /// **'De'**
  String get emailFrom;

  /// No description provided for @emailTo.
  ///
  /// In fr, this message translates to:
  /// **'À'**
  String get emailTo;

  /// No description provided for @emailCc.
  ///
  /// In fr, this message translates to:
  /// **'Cc'**
  String get emailCc;

  /// No description provided for @emailSubject.
  ///
  /// In fr, this message translates to:
  /// **'Objet'**
  String get emailSubject;

  /// No description provided for @emailBody.
  ///
  /// In fr, this message translates to:
  /// **'Message'**
  String get emailBody;

  /// No description provided for @emailDate.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get emailDate;

  /// No description provided for @emailToPrefix.
  ///
  /// In fr, this message translates to:
  /// **'À : {names}'**
  String emailToPrefix(String names);

  /// No description provided for @emailQuoteHeader.
  ///
  /// In fr, this message translates to:
  /// **'Le {date}, {from} a écrit :'**
  String emailQuoteHeader(String date, String from);

  /// No description provided for @emailUseTemplate.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser un modèle'**
  String get emailUseTemplate;

  /// No description provided for @emailOffline.
  ///
  /// In fr, this message translates to:
  /// **'Messagerie indisponible : connexion au serveur requise.'**
  String get emailOffline;

  /// No description provided for @emailNoAccountTitle.
  ///
  /// In fr, this message translates to:
  /// **'Aucun compte email'**
  String get emailNoAccountTitle;

  /// No description provided for @emailNoAccount.
  ///
  /// In fr, this message translates to:
  /// **'Connectez votre compte email (Gmail, Microsoft 365, OVH…) dans Paramètres → Comptes email.'**
  String get emailNoAccount;

  /// No description provided for @emailConnectAccount.
  ///
  /// In fr, this message translates to:
  /// **'Connecter un compte'**
  String get emailConnectAccount;

  /// No description provided for @emailAllAccounts.
  ///
  /// In fr, this message translates to:
  /// **'Tous mes comptes'**
  String get emailAllAccounts;

  /// No description provided for @emailSyncNow.
  ///
  /// In fr, this message translates to:
  /// **'Relever'**
  String get emailSyncNow;

  /// No description provided for @emailEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun message.'**
  String get emailEmpty;

  /// No description provided for @emailExchanges.
  ///
  /// In fr, this message translates to:
  /// **'Échanges'**
  String get emailExchanges;

  /// No description provided for @emailContactWithoutAddress.
  ///
  /// In fr, this message translates to:
  /// **'Ce contact n\'a pas d\'adresse email.'**
  String get emailContactWithoutAddress;

  /// No description provided for @emailAccountsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mes comptes email'**
  String get emailAccountsTitle;

  /// No description provided for @emailAccountsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Les emails reçus sont relevés toutes les 5 minutes ; ceux échangés avec un contact du CRM sont ajoutés à son historique (visible par l\'équipe). Les autres restent privés.'**
  String get emailAccountsDescription;

  /// No description provided for @emailConnectDescription.
  ///
  /// In fr, this message translates to:
  /// **'Gmail et Microsoft 365 : connexion sécurisée via le navigateur (sans mot de passe). Autres messageries : serveur IMAP / SMTP.'**
  String get emailConnectDescription;

  /// No description provided for @emailConnectGoogle.
  ///
  /// In fr, this message translates to:
  /// **'Connecter Gmail'**
  String get emailConnectGoogle;

  /// No description provided for @emailConnectMicrosoft.
  ///
  /// In fr, this message translates to:
  /// **'Connecter Microsoft 365 / Outlook'**
  String get emailConnectMicrosoft;

  /// No description provided for @emailAddImap.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un compte IMAP / SMTP'**
  String get emailAddImap;

  /// No description provided for @emailOAuthContinue.
  ///
  /// In fr, this message translates to:
  /// **'Terminez la connexion dans le navigateur, puis actualisez la liste.'**
  String get emailOAuthContinue;

  /// No description provided for @emailDisconnect.
  ///
  /// In fr, this message translates to:
  /// **'Déconnecter'**
  String get emailDisconnect;

  /// No description provided for @emailDisconnectMessage.
  ///
  /// In fr, this message translates to:
  /// **'Le compte {address} ne sera plus relevé. Les messages déjà journalisés dans le CRM sont conservés.'**
  String emailDisconnectMessage(String address);

  /// No description provided for @emailImapHelp.
  ///
  /// In fr, this message translates to:
  /// **'La connexion est testée avant l\'enregistrement. Le mot de passe est chiffré sur le serveur. Pour Gmail, utilisez un mot de passe d\'application.'**
  String get emailImapHelp;

  /// No description provided for @emailDisplayName.
  ///
  /// In fr, this message translates to:
  /// **'Nom affiché'**
  String get emailDisplayName;

  /// No description provided for @emailUsername.
  ///
  /// In fr, this message translates to:
  /// **'Identifiant'**
  String get emailUsername;

  /// No description provided for @emailUsernameHint.
  ///
  /// In fr, this message translates to:
  /// **'Par défaut : l\'adresse email'**
  String get emailUsernameHint;

  /// No description provided for @emailImapServer.
  ///
  /// In fr, this message translates to:
  /// **'Serveur IMAP (réception)'**
  String get emailImapServer;

  /// No description provided for @emailSmtpServer.
  ///
  /// In fr, this message translates to:
  /// **'Serveur SMTP (envoi)'**
  String get emailSmtpServer;

  /// No description provided for @emailPort.
  ///
  /// In fr, this message translates to:
  /// **'Port'**
  String get emailPort;

  /// No description provided for @emailSecurityNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucune'**
  String get emailSecurityNone;

  /// No description provided for @emailTestAndSave.
  ///
  /// In fr, this message translates to:
  /// **'Tester et enregistrer'**
  String get emailTestAndSave;

  /// No description provided for @emailAccountAdded.
  ///
  /// In fr, this message translates to:
  /// **'Compte email connecté.'**
  String get emailAccountAdded;

  /// No description provided for @templateNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau modèle'**
  String get templateNew;

  /// No description provided for @templateEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le modèle'**
  String get templateEdit;

  /// No description provided for @templateName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du modèle'**
  String get templateName;

  /// No description provided for @templateBodyHint.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour… (variables : voir la liste des modèles)'**
  String get templateBodyHint;

  /// No description provided for @templateVariablesHelp.
  ///
  /// In fr, this message translates to:
  /// **'Variables disponibles dans l\'objet et le message : {variables}'**
  String templateVariablesHelp(String variables);

  /// No description provided for @templatesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun modèle d\'email.'**
  String get templatesEmpty;

  /// No description provided for @sequenceNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle séquence'**
  String get sequenceNew;

  /// No description provided for @sequenceEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la séquence'**
  String get sequenceEdit;

  /// No description provided for @sequenceName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la séquence'**
  String get sequenceName;

  /// No description provided for @sequenceActive.
  ///
  /// In fr, this message translates to:
  /// **'Active (les envois programmés partent)'**
  String get sequenceActive;

  /// No description provided for @sequenceInactive.
  ///
  /// In fr, this message translates to:
  /// **'Inactive'**
  String get sequenceInactive;

  /// No description provided for @sequenceSteps.
  ///
  /// In fr, this message translates to:
  /// **'Étapes'**
  String get sequenceSteps;

  /// No description provided for @sequenceStepsHelp.
  ///
  /// In fr, this message translates to:
  /// **'Délai en jours après l\'étape précédente (après l\'inscription pour la première).'**
  String get sequenceStepsHelp;

  /// No description provided for @sequenceDays.
  ///
  /// In fr, this message translates to:
  /// **'jours'**
  String get sequenceDays;

  /// No description provided for @sequenceChooseTemplate.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un modèle…'**
  String get sequenceChooseTemplate;

  /// No description provided for @sequenceAddStep.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une étape'**
  String get sequenceAddStep;

  /// No description provided for @sequenceNeedsTemplate.
  ///
  /// In fr, this message translates to:
  /// **'Créez d\'abord au moins un modèle d\'email.'**
  String get sequenceNeedsTemplate;

  /// No description provided for @sequenceEnroll.
  ///
  /// In fr, this message translates to:
  /// **'Inscrire à une séquence'**
  String get sequenceEnroll;

  /// No description provided for @sequenceEnrolled.
  ///
  /// In fr, this message translates to:
  /// **'Contact inscrit à « {name} ».'**
  String sequenceEnrolled(String name);

  /// No description provided for @sequenceAlreadyEnrolled.
  ///
  /// In fr, this message translates to:
  /// **'Ce contact suit déjà cette séquence.'**
  String get sequenceAlreadyEnrolled;

  /// No description provided for @sequenceNoEnrollment.
  ///
  /// In fr, this message translates to:
  /// **'Aucune inscription.'**
  String get sequenceNoEnrollment;

  /// No description provided for @sequenceStepOf.
  ///
  /// In fr, this message translates to:
  /// **'étape {step}'**
  String sequenceStepOf(int step);

  /// No description provided for @sequenceStepLine.
  ///
  /// In fr, this message translates to:
  /// **'{index}. J+{days} — {template}'**
  String sequenceStepLine(int index, int days, String template);

  /// No description provided for @sequenceStop.
  ///
  /// In fr, this message translates to:
  /// **'Arrêter'**
  String get sequenceStop;

  /// No description provided for @sequencesHelp.
  ///
  /// In fr, this message translates to:
  /// **'Les emails d\'une séquence partent automatiquement du compte de la personne qui inscrit le contact. La séquence s\'arrête dès que le contact répond.'**
  String get sequencesHelp;

  /// No description provided for @sequencesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune séquence.'**
  String get sequencesEmpty;
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
