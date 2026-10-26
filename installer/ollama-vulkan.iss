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
DisableProgramGroupPage=yes
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
ChangesEnvironment=yes
UsePreviousTasks=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "modifypath"; Description: "Add Ollama Vulkan to user PATH"
Name: "autostart"; Description: "Start Ollama Vulkan when I log on to Windows"
Name: "startmenu"; Description: "Create a Start Menu shortcut"; GroupDescription: "Additional options:"
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional options:"; Flags: unchecked

[Files]
Source: "{#SourcePath}..\..\dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"; Tasks: startmenu
Name: "{autodesktop}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"; Tasks: desktopicon
Name: "{userstartup}\Ollama Vulkan"; Filename: "{sys}\wscript.exe"; Parameters: """{app}\start-ollama-hidden.vbs"""; WorkingDir: "{app}"; Tasks: autostart

[Run]
Filename: "{app}\start-ollama.cmd"; Description: "Launch Ollama Vulkan"; WorkingDir: "{app}"; Flags: postinstall nowait skipifsilent

[InstallDelete]
Type: files; Name: "{userstartup}\Ollama Vulkan.lnk"

[Code]
const
  ModPathName = 'modifypath';
  ModPathType = 'user';

var
  GroupNameEdit: TNewEdit;

procedure InitializeWizard;
var
  GroupNameLabel: TNewStaticText;
begin
  WizardForm.TasksList.Height :=
    WizardForm.TasksList.Height - ScaleY(58);

  GroupNameLabel := TNewStaticText.Create(WizardForm);
  GroupNameLabel.Parent := WizardForm.TasksList.Parent;
  GroupNameLabel.Caption := 'Start Menu folder name:';
  GroupNameLabel.Left := WizardForm.TasksList.Left;
  GroupNameLabel.Top :=
    WizardForm.TasksList.Top + WizardForm.TasksList.Height + ScaleY(8);

  GroupNameEdit := TNewEdit.Create(WizardForm);
  GroupNameEdit.Parent := WizardForm.TasksList.Parent;
  GroupNameEdit.Left := WizardForm.TasksList.Left;
  GroupNameEdit.Top := GroupNameLabel.Top + GroupNameLabel.Height + ScaleY(4);
  GroupNameEdit.Width := WizardForm.TasksList.Width;
  GroupNameEdit.Text := 'Ollama Vulkan';
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectTasks then begin
    if IsTaskSelected('startmenu') then begin
      if Trim(GroupNameEdit.Text) = '' then begin
        MsgBox('Enter a Start Menu folder name.', mbError, MB_OK);
        Result := False;
      end else
        WizardForm.GroupEdit.Text := Trim(GroupNameEdit.Text);
    end;
  end;
end;

function ModPathDir(): TArrayOfString;
begin
  SetArrayLength(Result, 1);
  Result[0] := ExpandConstant('{app}');
end;

#include "modpath.iss"
