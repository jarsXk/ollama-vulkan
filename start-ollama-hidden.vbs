Set WshShell = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

AppDir = FSO.GetParentFolderName(WScript.ScriptFullName)
WshShell.CurrentDirectory = AppDir

WshShell.Run "cmd.exe /c """ & AppDir & "\start-ollama.cmd"" /hidden", 0, False