#ifndef MyAppVersion
  #define MyAppVersion "0.0.0"
#endif

[Setup]
AppId={{D7B04D1A-9F32-4A1D-8C65-2F4A7E9B1C30}
AppName=Ollama Vulkan
AppVersion={#MyAppVersion}
AppPublisher=jarsXk

DefaultDirName={localappdata}\Programs\Ollama Vulkan
DefaultGroupName=Ollama Vulkan
PrivilegesRequired=lowest

ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

UninstallDisplayName=Ollama Vulkan
UninstallDisplayIcon={app}\ollama.exe

OutputDir={#SourcePath}..\..\packages
OutputBaseFilename=ollama-vulkan-{#MyAppVersion}-windows-amd64

Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional options:"; Flags: unchecked

[Files]
Source: "{#SourcePath}..\..\dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"
Name: "{autodesktop}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\start-ollama.cmd"; Description: "Launch Ollama Vulkan"; WorkingDir: "{app}"; Flags: postinstall nowait skipifsilent

