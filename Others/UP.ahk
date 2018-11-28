x_plus := "260"
y_plus := "443"



UpanhGui:
Gui,1: Add, Text, x33 y33 w150 h30 +Center vFiles_count, Drop Image Here
Gui,1: Add, Button, x33 y73 w150 h30 +Center gUpanh, UP anh
; Generated using SmartGUI Creator for SciTE
Gui,1: +AlwaysOnTop
Gui,1: Show,x400 w221 h181, Untitled GUI
return

GuiClose:
ExitApp

GuiDropFiles:
Files_list := [] 
FileDelete, Files_list.txt
Loop, Parse, A_GuiEvent, `n
{
	SplitPath,A_LoopField, filename,dir,extension
	;MsgBox, %extension%
	If !extension
	{
		Loop, %A_LoopField%\*.jpg,,1
		{
			Files_list.push(A_LoopFileFullPath)
			FileAppend,%A_LoopFileFullPath%`n,Files_list.txt,UTF-8
		}
	}
	If (extension = "jpg")
	{
		Files_list.push(A_LoopField)
		FileAppend,%A_LoopField%`n,Files_list.txt,UTF-8
	}
}
Count := Files_list.Length()
GuiControl,, Files_count , Số ảnh: %Count%
MsgBox, Done
return

Upanh:
;MsgBox, % Files_list.Length()
Loop % Files_list.Length()
{
	SplitPath, Files_list[A_Index],,,,ID
	WinActivate, ahk_exe chrome.exe
	sleep, 200
	checkmau(1897,187,0xFFFFFF)
	click %x_plus%, %y_plus% left, 1 
	sleep, 200
	checkmau2(1804,1042,0xFFFFFF)
	sleep, 300
	ImageSearch,,yIden,704, 251,1230, 564,Iden.png
	yIden := yIden +30
	Click, 944, %yIden% left,1 ; Identifier
	Sleep, 400
	Send, %ID%
	sleep, 500
	;Click, 1200,545 left, 1

}

;----------------------------------------------------------------------------------
CheckMau(X,Y,Color,time:=0)
{
	timeout:=0
	Loop
	{
		PixelGetColor, pxcheck, %X%, %Y%	
		if (y > 0 and timeout < time)
		{
			timeout++
		}			
	}
	until (pxcheck = Color or timeout > time)  ;check đã tìm thấy
}

CheckMau2(X,Y,Color,time:=0)
{
	timeout:=0
	Loop
	{
		PixelGetColor, pxcheck, %X%, %Y%	
		if (y > 0 and timeout < time)
		{
			timeout++
		}			
	}
	until (pxcheck <> Color or timeout > time)  ;check đã tìm thấy
}