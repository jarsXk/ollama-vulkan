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
OutputBaseFilename=ollama-vulkan-{#MyAppVersion}-win-amd64-setup

Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ChangesEnvironment=yes
UsePreviousTasks=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "modifypath"; Description: "Add Ollama Vulkan to user PATH"
Name: "startmenu"; Description: "Create a Start Menu shortcut"; GroupDescription: "Additional options:"
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional options:"; Flags: unchecked

[Files]
Source: "{#SourcePath}..\..\dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"; Tasks: startmenu
Name: "{autodesktop}\Ollama Vulkan"; Filename: "{app}\start-ollama.cmd"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\start-ollama.cmd"; Description: "Launch Ollama Vulkan"; WorkingDir: "{app}"; Flags: postinstall nowait skipifsilent

[InstallDelete]
Type: files; Name: "{userstartup}\Ollama Vulkan.lnk"
Type: files; Name: "{app}\start-ollama-hidden.vbs"

[Code]
const
  ModPathName = 'modifypath';
  ModPathType = 'user';

var
  GroupNameEdit: TNewEdit;
  StartMenuCheck: TNewCheckBox;
  ModifyPathCheck: TNewCheckBox;
  DesktopIconCheck: TNewCheckBox;
  GroupNameLabel: TNewStaticText;
  ShortcutsLabel: TNewStaticText;

procedure StartMenuCheckClick(Sender: TObject);
begin
  GroupNameEdit.Enabled := StartMenuCheck.Checked;
  GroupNameLabel.Enabled := StartMenuCheck.Checked;
end;

procedure InitializeWizard;
begin
  WizardForm.TasksList.Visible := False;

  ModifyPathCheck := TNewCheckBox.Create(WizardForm);
  ModifyPathCheck.Parent := WizardForm.TasksList.Parent;
  ModifyPathCheck.Left := WizardForm.TasksList.Left;
  ModifyPathCheck.Top := WizardForm.TasksList.Top;
  ModifyPathCheck.Width := WizardForm.TasksList.Width;
  ModifyPathCheck.Caption := 'Add Ollama Vulkan to user PATH';
  ModifyPathCheck.Checked := IsTaskSelected('modifypath');

  ShortcutsLabel := TNewStaticText.Create(WizardForm);
  ShortcutsLabel.Parent := WizardForm.TasksList.Parent;
  ShortcutsLabel.Left := ModifyPathCheck.Left;
  ShortcutsLabel.Top := ModifyPathCheck.Top + ScaleY(32);
  ShortcutsLabel.Caption := 'Shortcuts';
  ShortcutsLabel.Font.Style := [fsBold];

  StartMenuCheck := TNewCheckBox.Create(WizardForm);
  StartMenuCheck.Parent := WizardForm.TasksList.Parent;
  StartMenuCheck.Left := ModifyPathCheck.Left;
  StartMenuCheck.Top := ShortcutsLabel.Top + ShortcutsLabel.Height + ScaleY(4);
  StartMenuCheck.Width := ModifyPathCheck.Width;
  StartMenuCheck.Caption := 'Create a Start Menu shortcut';
  StartMenuCheck.Checked := IsTaskSelected('startmenu');

  GroupNameLabel := TNewStaticText.Create(WizardForm);
  GroupNameLabel.Parent := WizardForm.TasksList.Parent;
  GroupNameLabel.Caption := 'Start Menu folder name:';
  GroupNameLabel.Left := StartMenuCheck.Left;
  GroupNameLabel.Top := StartMenuCheck.Top + StartMenuCheck.Height + ScaleY(4);

  GroupNameEdit := TNewEdit.Create(WizardForm);
  GroupNameEdit.Parent := WizardForm.TasksList.Parent;
  GroupNameEdit.Left := StartMenuCheck.Left;
  GroupNameEdit.Top := GroupNameLabel.Top + GroupNameLabel.Height + ScaleY(4);
  GroupNameEdit.Width := StartMenuCheck.Width;
  GroupNameEdit.Text := 'Ollama Vulkan';
  GroupNameEdit.Enabled := StartMenuCheck.Checked;
  GroupNameLabel.Enabled := StartMenuCheck.Checked;
  StartMenuCheck.OnClick := @StartMenuCheckClick;

  DesktopIconCheck := TNewCheckBox.Create(WizardForm);
  DesktopIconCheck.Parent := WizardForm.TasksList.Parent;
  DesktopIconCheck.Left := StartMenuCheck.Left;
  DesktopIconCheck.Top := GroupNameEdit.Top + GroupNameEdit.Height + ScaleY(8);
  DesktopIconCheck.Width := StartMenuCheck.Width;
  DesktopIconCheck.Caption := 'Create a desktop shortcut';
  DesktopIconCheck.Checked := IsTaskSelected('desktopicon');
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectTasks then begin
    if StartMenuCheck.Checked then begin
      if Trim(GroupNameEdit.Text) = '' then begin
        MsgBox('Enter a Start Menu folder name.', mbError, MB_OK);
        Result := False;
      end else begin
        WizardForm.GroupEdit.Text := Trim(GroupNameEdit.Text);
        WizardSelectTasks('startmenu');
      end;
    end else begin
      WizardSelectTasks('!startmenu');
    end;
    if ModifyPathCheck.Checked then
      WizardSelectTasks('modifypath')
    else
      WizardSelectTasks('!modifypath');
    if DesktopIconCheck.Checked then
      WizardSelectTasks('desktopicon')
    else
      WizardSelectTasks('!desktopicon');
  end;
end;

function ModPathDir(): TArrayOfString;
begin
  SetArrayLength(Result, 1);
  Result[0] := ExpandConstant('{app}');
end;

#include "modpath.iss"
