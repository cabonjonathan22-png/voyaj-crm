; Installeur Windows du client Voyaj CRM (Inno Setup 6).
; Ne pas compiler directement : utiliser build-client-installer.ps1, qui
; prépare les fichiers et fournit les paramètres ci-dessous.
;
; Installation par utilisateur (aucun droit administrateur requis), dans
; %LOCALAPPDATA%\Programs\Voyaj CRM, avec raccourcis Bureau et menu Démarrer.

#ifndef AppVersion
  #error AppVersion non défini (utilisez build-client-installer.ps1)
#endif
#ifndef SourceDir
  #error SourceDir non défini (utilisez build-client-installer.ps1)
#endif
#ifndef OutputDir
  #error OutputDir non défini (utilisez build-client-installer.ps1)
#endif

[Setup]
AppId={{5CD4F69F-3B13-4E40-A6F1-BEF32D7BB313}
AppName=Voyaj CRM
AppVersion={#AppVersion}
AppVerName=Voyaj CRM {#AppVersion}
AppPublisher=Voyaj
DefaultDirName={localappdata}\Programs\Voyaj CRM
DefaultGroupName=Voyaj CRM
DisableDirPage=yes
DisableProgramGroupPage=yes
DisableReadyPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
OutputDir={#OutputDir}
OutputBaseFilename=VoyajCRM-Setup-{#AppVersion}
SetupIconFile={#SourceDir}\..\app_icon.ico
UninstallDisplayIcon={app}\VoyajCRM.exe
UninstallDisplayName=Voyaj CRM
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
CloseApplications=force
RestartApplications=no

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "Créer un raccourci sur le Bureau"; GroupDescription: "Raccourcis :"

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Voyaj CRM"; Filename: "{app}\VoyajCRM.exe"
Name: "{autodesktop}\Voyaj CRM"; Filename: "{app}\VoyajCRM.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\VoyajCRM.exe"; Description: "Lancer Voyaj CRM"; Flags: nowait postinstall skipifsilent
