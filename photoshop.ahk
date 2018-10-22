Gui, Add, Button,  x52 y49 w100 h30 gOK, OK
Gui, +AlwaysOnTop
; Generated using SmartGUI Creator for SciTE

return

f2::
820-820:
WinActivate, ahk_exe Photoshop.exe
send, {f9}
sleep, 200
send, c
sleep, 200
send, {enter}

Gui, Show,x1516 y153 w216 h132, Untitled GUI
WinActivate, ahk_exe Photoshop.exe
Sleep, 100
;MouseMove, 1615, 250
return

OK:
f1::
Gui, submit
WinActivate, ahk_exe Photoshop.exe
sleep, 100
send, {enter}
sleep, 300
send, +{F12} ;820
;send, ^{f12} ;1100
return

PAUSE::
	Suspend
	

