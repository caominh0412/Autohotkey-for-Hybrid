Counter := 1
Gui 1: Add, Text, w50 vText , %Counter%
;Gui 1: Add, Button, w100 ys gReset, Reset
;Gui 1: Add, Button, w100 ys gNext, Next
Gui 1: +AlwaysOnTop +Owner +LastFound +ToolWindow
; Generated using SmartGUI Creator for SciTE
Gui 1: Show,, A GUI

return

GuiClose:
ExitApp

Gui2Close:
ExitApp

GuiDropFiles:
;MsgBox, %A_GuiEvent%
count=1
Loop, parse, A_GuiEvent, `n
{
SplitPath,A_LoopField, name,dir
;MsgBox,  %name%`n%dir%
SplitPath,dir,barcode
StringLeft, NewFolder, name, 12
FileCreateDir, %dir%\%Newfolder%
FileMove,%A_LoopField%,%dir%\%NewFolder%\%Newfolder%_%count%.jpg
;MsgBox,%dir%\%NewFolder%\%Newfolder%_%count%
count++
}
GuiControl,1 :, Text, %barcode%
return

