FileEncoding, UTF-8

Gui, Add, Edit, x2 y9 w400 h40 vFolder, 
Gui, Add, Button, x92 y59 w100 h30 gFolder, Folder
Gui, Add, Button, x202 y59 w100 h30 gFile, File
Gui, +AlwaysOnTop
; Generated using SmartGUI Creator for SciTE
Gui, Show, w411 h101, List file GUI
return

GuiClose:
ExitApp

GuiDropFiles:
Folder = %A_GuiEvent%
GuiControl,, Folder, %Folder%
return

Folder:
Gui,Submit,NoHide
FileDelete, %A_Desktop%\listfile.Txt
Loop, Files, %Folder%\*,D
{
    FileAppend, %A_LoopFileName%`n, %A_Desktop%\listfile.Txt
}
Run, %A_Desktop%\listfile.Txt
return

File:
Gui,Submit,NoHide
FileDelete, %A_Desktop%\listfile.csv
Loop, Files, %Folder%\*.*,R
{
    FileAppend, %A_LoopFileLongPath%*%A_LoopFileName%`n, %A_Desktop%\listfile.csv
}
Run, %A_Desktop%\listfile.csv
return