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

OutputDir=..\..\packages
OutputBaseFilename=ollama-vulkan-{#MyAppVersion}-windows-amd64-setup

Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; \
    Description: "Создать ярлык на рабочем столе"; \
    GroupDescription: "Дополнительные параметры:"; \
    Flags: unchecked

Name: "launch"; \
    Description: "Запустить Ollama Vulkan после установки"; \
    GroupDescription: "Дополнительные параметры:"; \
    Flags: unchecked

[Files]
Source: "..\..\dist\*"; \
    DestDir: "{app}"; \
    Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Ollama Vulkan"; \
    Filename: "{app}\start-ollama.cmd"; \
    WorkingDir: "{app}"

Name: "{autodesktop}\Ollama Vulkan"; \
    Filename: "{app}\start-ollama.cmd"; \
    WorkingDir: "{app}"; \
    Tasks: desktopicon

[Run]
Filename: "{app}\start-ollama.cmd"; \
    Description: "Запустить Ollama Vulkan"; \
    WorkingDir: "{app}"; \
    Flags: postinstall nowait skipifsilent; \
    Tasks: launch