Counter := 1
Gui 1: Add, Text, w50 vText , %Counter%
Gui 1: Add, Button, w100 ys gReset, Reset
Gui 1: Add, Button, w100 ys gNext, Next
Gui 1: Add, Button, w100 ys gFolder, Folder
Gui 1: +AlwaysOnTop +Owner +LastFound +ToolWindow
; Generated using SmartGUI Creator for SciTE
Gui 1: Show,, A GUI


Gui 2: Add, Text, w100 vFileName,File:%vFileName%
Gui 2: Add, Text, w100 ys , New File: 
Gui 2: Add, Edit, w100 ys vNewFileName,%vNewFileName%
Gui 2: Add, Button, w100 ys gNextFile, Next 
return

GuiClose:
ExitApp

Gui2Close:
ExitApp

GuiDropFiles:
;MsgBox, %A_GuiEvent%
Loop, parse, A_GuiEvent, `n
{
SplitPath,A_LoopField, name,dir
;MsgBox,  %name%`n%dir%
SplitPath,dir,barcode
FileMove,%A_LoopField%,%dir%\%barcode%_%counter%.jpg
}
counter++
GuiControl,1 :, Text, %Counter%
return

Reset:
F1::
counter:=1
GuiControl,1: , Text, %Counter%
return

Next:
counter++
GuiControl,1: , Text, %Counter%
return

Folder:
Gui 1:Submit
InputBox, dir , Folder, Chọn Folder
;Gui 2: Show,, Folder
Loop, %dir%,d
{
    Gui 2: Show,, Folder
    MsgBox, %A_LoopFileName%
}
return

NextFile:
GuiControl,2: ,FileName, File: %A_LoopFileName%
return