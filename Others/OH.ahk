﻿SetKeyDelay,0
FileSelectFile,baocaoloc
baocao := ComObjCreate("Excel.Application") 
baocao.Workbooks.Open(baocaoloc)
baocao.Visible := True
Row := 2


Gui 1: Add, Text, x42 y40 w100 h17 , Tên
Gui 1: Add, Edit, x162 y40 w100 h17 vTenFolder
Gui 1: Add, Text, x42 y80 w100 h17 , Cột mã
Gui 1: Add, Text, x42 y120 w100 h17 , Cột tên
Gui 1: Add, Text, x42 y160 w100 h17 , Cột link
Gui 1: Add, Edit, x162 y80 w100 h17 vMa
Gui 1: Add, Edit, x162 y120 w100 h17 vTen
Gui 1: Add, Edit, x162 y160 w100 h17 vLink1
Gui 1: Add, Edit, x162 y180 w100 h17 vLink2
Gui 1: Add, Edit, x162 y200 w100 h17 vLink3
; Generated using SmartGUI Creator for SciTE
Gui 1: Add, Button, , Submit
Gui 1: Show,, Start GUI
Gui 1: +AlwaysOnTop
return
/*Gui 1: Add, Text, x42 y40 w100 h30 , Cột mã
Gui 1: Add, Text, x42 y80 w100 h30 , Cột tên
Gui 1: Add, Text, x42 y120 w100 h30 , Cột link
Gui 1: Add, Edit, x162 y40 w100 h30 vMa, Edit
Gui 1: Add, Edit, x162 y80 w100 h30 vTen, Edit
Gui 1: Add, Edit, x162 y120 w100 h30 vLink, Edit
; Generated using SmartGUI Creator for SciTE
Gui 1: Add, Button, x122 y160 w100 h30 , Submit
Gui 1: Show,, Start GUI
*/
return

GuiClose:
baocao.Workbooks.Close()
ExitApp

ButtonSubmit:
Gui 1:Submit
FileCreateDir, %A_Desktop%\%TenFolder%
/*
Gui 2: Add, Text, x42 y40 w100 h30 , Cột mã
Gui 2: Add, Text, x42 y80 w100 h30 , Cột tên
Gui 2: Add, Text, x42 y120 w100 h30 , Cột link
Gui 2: Add, Edit, x162 y40 w300 h30 vBarcode, %barcode%
Gui 2: Add, Edit, x162 y80 w300 h30 vName, %name%
Gui 2: Add, Edit, x162 y120 w300 h30 vLink, %link%
Gui 2: Add, Button, x122 y160 w100 h30 gNext, Next
Gui 2: Add, Button, x252 y160 w100 h30 gFolder, Create Folder
Gui 2: Add, Button, x122 y200 w100 h30 gBack, Back
Gui 2: Add, Button, x252 y200 w100 h30 gQuit, Quit
Gui 2: Show, x0 y400 NoActivate, SP Gui
return

*/
barcode := baocao.range(Ma . Row ).value
name := baocao.range(Ten . Row ).value
linh1 := baocao.range(Link1 . Row ).value
linh2 := baocao.range(Link2 . Row ).value
linh3 := baocao.range(Link3 . Row ).value

Gui 2: Add, Text, x5 y46 w90 h30 , Cột mã
Gui 2: Add, Text, x5 y86 w90 h30 , Cột tên
Gui 2: Add, Text, x5 y126 w90 h30 , Cột link
Gui 2: Add, Text, x5 y6 w90 h30 , Dòng
Gui 2: Add, Text, x105 y6 w100 h30  vGuirow, %row%
Gui 2: Add, Edit, x106 y47 w340 h30 vBarcode, %barcode%
Gui 2: Add, Edit, x106 y87 w340 h30 vName, %name%
Gui 2: Add, Edit, x106 y127 w340 h20 vLink1, %link1%
Gui 2: Add, Edit, x106 y147 w340 h20 vLink2, %link2%
Gui 2: Add, Edit, x106 y167 w340 h20 vLink3, %link3%
Gui 2: Add, Button, x346 y7 w100 h30  gPause , Pause
Gui 2: Add, Button, x6 y197 w90 h30 gNext, Next
Gui 2: Add, Button, x106 y197 w90 h30 gBack, Back
Gui 2: Add, Button, x216 y7 w100 h30 gGoto, Tới dòng
Gui 2: Add, Button, x346 y197 w100 h30 gQuit, Quit
; Generated using SmartGUI Creator for SciTE
Gui 2: Show, , Untitled GUI
Gui 2: +AlwaysOnTop
return


Next:
`::
Row++
Gosub, search
;click, 507, 226 left, 3
;goto, com
return

Folder:
FileCreateDir,%A_Desktop%\%TenFolder%\%barcode%
return

Quit:
Gui 2:Destroy
baocao.Workbooks.Close()
ExitApp

Pause:
F12::
Pause
return

f9::
;Magic:
baocao.range("Q" . Row ).value := Clipboard
InputBox, size, size
size := StrSplit(size,"x")

baocao.range("L" . Row ).value := size[1]
baocao.range("M" . Row ).value := size[2]
baocao.range("N" . Row ).value := size[3]
baocao.range("O" . Row ).value := size[4]
gosub,Next
;gosub,link1
return

Back:
Row--
goto,search
return

com:
F1::
;click,559, 58 left,1
;sleep,50
;send, ^a
;sleep,50
SendRaw, %Barcode%`n
return

F2::
;click,559, 58 left,1
;sleep,50
;send, ^a
;sleep,50
SendRaw, kích thước %name%`n
return


f7::
click,559, 58 left,1
sleep,50
send, ^a
sleep,50
SendRaw, %linh2%`n
return

f8::
click,559, 58 left,1
sleep,50
send, ^a
sleep,50
SendRaw, %linh3%`n
return


F4::
FileCreateDir,%A_Desktop%\%TenFolder%\%barcode%
sleep,200
click, 447, 512 right, 1
sleep, 400
send, v
sleep,500
send, {home}
sleep,200
send,%A_Desktop%\%TenFolder%\%barcode%\`n
return

goto:
InputBox, Row, Go to, Row
goto,search
return

search:
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 43,
barcode := baocao.range(Ma . Row ).value
name := baocao.range(Ten . Row ).value
linh1 := baocao.range( Link1 . Row ).value
linh2 := baocao.range( Link2 . Row ).value
linh3 := baocao.range( Link3 . Row ).value
StringReplace, barcode, barcode, .000000,
StringReplace, name, name, .000000,
StringReplace, linh1, linh1, .000000,
StringReplace, linh2, linh2, .000000,
StringReplace, linh3, linh3, .000000,
;MsgBox, % barcode " - " name " - " link
GuiControl, 2:, Guirow, %row%
GuiControl, 2:, Barcode , %barcode%
GuiControl, 2:, Name , %name%
GuiControl, 2:, Link1, %linh1%
GuiControl, 2:, Link2, %linh2%
GuiControl, 2:, Link3, %linh3%
return

link1:
f6::
click,559, 58 left,1
sleep,50
send, ^a
sleep,50
SendRaw, %linh1%`n
return

f3::
Save:
MouseGetPos, X, Y
Click, 1889, 614 left, 1
sleep, 100
MouseMove, 1013, 785 
return