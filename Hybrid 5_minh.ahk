﻿;------------------Global Variant---------

global maubangtao =   0x8F8781 ; màu bảng tạo 1900, 180
global maudodatao = 0x4E4EF4 ; màu đỏ đã tạo 1196, 236
global maudatimthay = 0xF1EDEA  ; màu đã tìm thấy sp 1874, 608
global maunutsave =  0x42DEFB ; màu nút save  1902,658 0x2BDFFC
global mauloading =0x664C3C ; màu xám loading quay quay 960,518
global mausavedone = 0xE4DAD2 ; màu nút savedone
global maunutconvert = 0x76583F ;màu nút convert
#Include, Lib\function.ahk
;#Include, Lib\gdip.ahk

;---------------------------------------------
/*

Bookmark checkmap
javascript:var text = document.getElementsByClassName('ye-default-reference-editor-selected-item-label z-label')[2].innerText; var copyFrom = $('<textarea/>'); copyFrom.css({ position: "absolute", left: "-1000px", top: "-1000px", }); copyFrom.text(text); $('body').append(copyFrom); copyFrom.select(); document.execCommand('copy');

*/


FileRead,LastDir,Lastdir.txt
FileRead,LastExcel,LastExcel.txt
SetKeyDelay,0
Gui, Start:Add, Text, x2 y19 w100 h50 Center, Folder
Gui, Start:Add, Text, x2 y79 w100 h50 Center, Excel
Gui, Start:Add, Edit, x112 y9 w350 h50 vfolderloc, %LastDir%
Gui, Start:Add, Edit, x112 y69 w240 h50 vbaocaoloc, %LastExcel%
Gui, Start:Add, Button, x362 y79 w100 h30 Center gChonExcel, Chon Excel
Gui, Start:Add, Button, x182 y129 w100 h30 Center gDirSubmit, Submit
; Generated using SmartGUI Creator for SciTE
Gui, Start:Show,, Start GUI
return


;-------------------Gui-------------------------

;InputBox, folderloc
;folderloc = C:\Users\minhcq\Desktop\New folder (16)\New folder (2)\RT BINH
start:
;FileSelectFile,baocaoloc,,,,*.xlsx
;baocaoloc = %A_Desktop%\My_Hybris_The One.xlsx

baocao := ComObjCreate("Excel.Application")
baocao.Workbooks.Open(baocaoloc)
baocao.Visible := True
gosub, Count

WinActivate, ahk_exe chrome.exe
Row := 2
gosub, excel
Process,close, GoTiengViet.exe
#Persistent
;SetTimer, AppStatus, 100

Gui 1: Add, Button, x92 y9 w90 h30 gID vID, %varID%
Gui 1: Add, Button, x2 y99 w90 h30 gOtherThings, Các chức năng khác
Gui 1: Add, Button, x2 y9 w90 h30 gFolder vFolder, Folder
Gui 1: Add, Button, x92 y39 w90 h30 gBienthe vBienthe, Bienthe
Gui 1: Add, Button, x2 y39 w90 h30 vBarcode gBarcode, %Barcode%
Gui 1: Add, Text, x2 y69 w90 h30 +Center vGSoAnh, Số ảnh: %fdcount%

Gui 1: Add, GroupBox, x2 y129 w180 h120 , Auto
Gui 1: Add, Button, x12 y209 w160 h30 gUp, Up ảnh +map - Product Media
Gui 1: Add, Button, x12 y149 w160 h30 gNewUpChon, Up ảnh mới
Gui 1: Add, Button, x12 y179 w160 h30 gMapContainSP, Map Container vào Sản phẩm

Gui 1: Add, GroupBox, x2 y279 w180 h90 , Excel
Gui 1: Add, Button, x12 y299 w80 h30 gBack, Back
Gui 1: Add, Button, x92 y299 w80 h30 gNext, Next
Gui 1: Add, Button, x12 y329 w80 h30 gTop, Top
Gui 1: Add, Button, x92 y329 w80 h30 gSelectRow, Chọn dòng

Gui 1: Add, Text, x12 y439 w80 h20 vGuiRow, Dòng số: %Row%
Gui 1: Add, Text, x92 y439 w90 h20 vCurrent, %varCurrent%
Gui 1: Add, Progress, x12 y459 w170 h10 vProgressBar, 0

Gui 1: Add, Text, x12 y469 w170 h20 vEstimated, Còn lại:
Gui 1: Add, Text, x12 y489 w170 h20 , Thời gian 1 dòng:
Gui 1: Add, Button, x12 y549 w80 h30 gReset, Reset
Gui 1: Add, Button, x12 y519 w80 h30 gDoiten, Đổi tên

Gui 1: Add, Button,x92 y99 w90 h30 gResetCount, ResetCount
Gui 1: Add, Button, x92 y519 w80 h30 , Open Chrome
Gui 1: Add, Button, x92 y549 w80 h30 , Quit

Gui 1: Add, Button, x92 y69 w90 h30 gOld, Check Folder
Gui 1: Add, Picture, x12 y579 w170 h170 vAnh +0xE
; Generated using SmartGUI Creator for SciTE
Gui 1: +AlwaysOnTop
Gui 1: Show, x0 y90, Hybrid 6.0

Gui 2: Add, Text, x12 y10 w100 h30 , IdenPos
Gui 2: Add, Edit, x122 y10 w100 h30 vyIden, %yIden%
Gui 2: Add, Text, x12 y50 w100 h30 , CatProductmediaPos
Gui 2: Add, Edit, x122 y50 w100 h30 vyCatProductMedia, %yCatProductMedia%
Gui 2: Add, Text, x12 y90 w100 h30 , FolderPos
Gui 2: Add, Edit, x122 y90 w100 h30 vyFolder, %yFolder%
Gui 2: Add, Edit, x122 y130 w100 h30 vyQualifier, %yQualifier%
Gui 2: Add, Text, x12 y130 w100 h30 , QualifierPos
Gui 2: Add, Text, x12 y170 w100 h30 , CatContainerPos
Gui 2: Add, Edit, x122 y170 w100 h30 vyCatContainer, %yCatContainer%
Gui 2: Add, Button, x62 y210 w100 h30 gSubmit, Submit
; Generated using SmartGUI Creator for SciTE
Gui 2: +AlwaysOnTop +LastFound +ToolWindow

Gui 3: Add, Button, x12 y20 w100 h30 gConvertSP, Sản phẩm
Gui 3: Add, Button, x132 y20 w100 h30 gConvertThoitrang, Thời trang
Gui 3: +AlwaysOnTop +LastFound +ToolWindow

Gui 4: Add, Button, x2 y10 w100 h30 gMapSanPham, Map Sản Phẩm
Gui 4: Add, Button, x112 y10 w100 h30 gMapBienthe, Map Biến thể

Gui 5: Add, Button, x10 y10 w100 h30  gDownanh, Down ảnh
Gui 5: Add, Button, x110 y10 w100 h30  gDuyet, Duyệt SP
Gui 5: Add, Button, x210 y10 w100 h30  gThayten, Thay tên
Gui 5: Add, Button, x310 y10 w100 h30  gCheckthuoctinh, Check thuộc tính
Gui 5: Add, Button, x410 y10 w100 h30  gNewUp, Up ảnh mới
Gui 5: Add, Button, x510 y10 w100 h30  gDoibrand, Doi Brand
Gui 5: Add, Button, x610 y10 w100 h30  gSaithuoctinh, Sai thuoc tinh

Gui 7: Add, text, w300 vEstimated2, Còn lại:
;Gui 7: Add, Button, w70 h30 ys gGui7Close, Close

Gui 7: +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui 7: Color, FF0000
WinSet, Transcolor, FF0000
Gui 7: Font, s32  ; Set a large font size (32-point).WinSet, TransColor, %CustomColor% 150

Gui 8: Add, Button, x112 y10 w100 h30 gUpThoitrang, Thoitrang
Gui 8: Add, Button, x2 y10 w100 h30 gUpsanpham, San pham
Gui 8: +AlwaysOnTop +LastFound +ToolWindow

Gui 9: Add, Button,  w170 h30 gAutoCreateContainer, Create Container 
Gui 9: Add, Button,  w170 h30 gAutoCreatePicture, Create Product Media
Gui 9: Add, Button, w170 h30 gUp, Up ảnh +map - Product Media
Gui 9: Add, Button,  w170 h30 gMap, Map ảnh - Product Media
Gui 9: Add, Button,  w170 h30 gMapContainSP, Map Container vào Sản phẩm 
Gui 9: Add, Button,  w170 h30 gConvert, Convert - Container
Gui 9: Add, Button,  w170 h30 gManualSetting, Manual Setting
return

NewUpChon:
Gui 8: Show
return

ManualSetting:
SetTimer, Mousepos, 100
GuiControl,2:, yIden,%yIden%
GuiControl,2:, vyCatProductMedia, %yCatProductMedia%
GuiControl,2:,  yFolder, %yFolder%
GuiControl,2:, yQualifier, %yQualifier%
GuiControl,2:, yCatContainer, %yCatContainer%
Gui 2: Show, w241 h252 , Setting GUI
return

Old:
Gui 9: Show
return

MousePos:
MouseGetPos,, yPos,
ToolTip, %yPos%
return

Submit:
Gui 2: submit
yCatProductMedia2 := yCatProductMedia+129
yCatContainer2 := yCatContainer +  129
SetTimer, Mousepos, Off
ToolTip
GuiControl,1:,DebugPos, IdenPos: %yIden%`n CatProductmediaPos: %yCatProductMedia%`n FolderPos: %yFolder%`n QualifierPos: %yQualifier%`n CatContainerPos: %yCatContainer%
return


SettingProductMedia:
WinActivate, ahk_exe chrome.exe
sleep, 300
ImageSearch,,yIden,704, 251,1230, 564,PNG\Iden.png
yIden := yIden +30
yFolder := yFolder +30
yCatProductMedia :=yCatProductMedia +30
yCatProductMedia2 := yCatProductMedia+129
GuiControl,1:,DebugPos, IdenPos: %yIden%`n CatProductmediaPos: %yCatProductMedia%`n FolderPos: %yFolder%`n QualifierPos: %yQualifier%`n CatContainerPos: %yCatContainer%
return

SettingContainer:
WinActivate, ahk_exe chrome.exe
sleep, 300
ImageSearch,,yQualifier,704, 251,1230, 564,PNG\Qualifier.png
yQualifier := yQualifier + 30
yCatContainer := yCatContainer +30
yCatContainer2 := yCatContainer +  129
GuiControl,1:,DebugPos, IdenPos: %yIden%`n CatProductmediaPos: %yCatProductMedia%`n FolderPos: %yFolder%`n QualifierPos: %yQualifier%`n CatContainerPos: %yCatContainer%
return

GuiClose:
^Q::
Run, C:\GoTiengViet\GoTiengViet.exe
FileDelete, Lastdir.txt
FileAppend,%folderloc%,LastDir.txt,UTF-8
baocao.Workbooks.Close()
ExitApp

Otherthings:
Gui 5:Show
return

MapContainSP:
Gui 4: Show
return

LastDir:
folderloc = %LastDir%
Gui 6: Destroy
goto, start
return

ChonExcel:
FileSelectFile,baocaoloc,,,,*.xlsx
GuiControl, Start:, baocaoloc, %baocaoloc%
return

DirSubmit:
Gui, Start: Submit
FileDelete, Lastdir.txt
FileAppend,%folderloc%,LastDir.txt,UTF-8
FileDelete, LastExcel.txt
FileAppend,%baocaoloc%,LastExcel.txt,UTF-8
goto, start
;goto, start
return

Gui7Close:
Gui 7: Destroy
return

Pause:
f12::
Pause
return


Barcode:
Clipboard := varBarcode
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, Barcode , *%varBarcode%
return

Folder:
Clipboard := varFolder
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
return

ID:
Clipboard := varID
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID , *%varID%
return

ID1:
Clipboard := varID_1
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID1 , *_1
return

ID2:
Clipboard := varID_2
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID2 , *_2
return

ID3:
Clipboard := varID_3
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID3 , *_3
return

ID4:
Clipboard := varID_4
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID4 , *_4
return

ID5:
Clipboard := varID_5
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID5 , *_5
return

ID6:
Clipboard := varID_6
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID6 , *_6
return

Bienthe:
Clipboard := varBienthe
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, Bienthe , *%varBienthe%
return

ResetCount:
gosub, count
return

Doiten:
Run, Others\doi ten.ahk

Next:
f1::
GuiControl,1:, ProgressBar, 0
varIDtruoc := varID
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 0
Row++
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 43
varCurrent := varID
gosub, excel
IF (varBarcode ="")
{
	MsgBox, DONE
}
return

Back:
GuiControl,1:, ProgressBar, 0
varSpgoctruoc := varSpgoc
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 0
Row--
if (Row <= 1)
{
	Row := 1
	MsgBox, Hết
	return
}
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 33
gosub, excel
return

Top:
GuiControl,1:, ProgressBar, 0
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 0
Row:= 2
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 33
gosub, excel
return

SelectRow:
GuiControl,1:, ProgressBar, 0
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 0
InputBox,Row, Chọn dòng
baocao.Range("A" . Row, "J" . Row ).Interior.ColorIndex := 33
gosub, excel
If (varID = "")
{
	Row:= 2
	MsgBox, Hết rồi quay lại đi
}
return

Reset:
FileDelete, Lastdir.txt
FileAppend,%folderloc%,LastDir.txt,UTF-8
baocao.Workbooks.Close()
Reload

Convert:
Gui 3: Show
return

Progress1:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Percent := Row/count*100
GuiControl,1:, ProgressBar, %Percent%
return

FindID:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
click, 637, 228 left,3
sleep, 200
SendRaw, %varCurrent%`n
return



Upsanpham:
upconfig:=1
gui 8: Submit
goto, NewUp
return

UpThoitrang:
upconfig:=2
gui 8: Submit
goto, NewUp
return

;-------------------------------------------------------------------------ALL Thing

AutoCreatePicture:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
If (yIden = "")
{
	MsgBox, Chưa Setting
	return
}
Loop
{
	gosub, starttime
	fdcount2:=1
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	If (fdcount >=1 )
	{
		Loop
		{
			gosub, Progress1
			WinActivate, ahk_exe chrome.exe
			sleep, 200
			gosub,CheckDone
			click 260, 432 left, 1 ;Nut them
			sleep, 400
			;Cho hien ra bang tao
			gosub, CheckBangTao
			GuiControl,1:,AppStatus, Label %A_ThisLabel%
			sleep, 300
			Click, 944, %yIden% left,1 ; Identifier
			Sleep, 400
			varCurrent = %varID%_%fdcount2%
			GuiControl, 1:, Current, %varCurrent%
			Send, %varCurrent%
			sleep,500
			fdcount2++
			Click, 1200, 535 left,1 ;click done
			sleep,500
			timeout:=0
			gosub, CheckDaTao
			GuiControl,1:,AppStatus, Label %A_ThisLabel%
			timeout:=0
			If vCheckDaTao <> 1
			{
				gosub, CheckDone
			}
		}
	until (fdcount2 > fdcount)
	}
	gosub, endtime
	Row++
}
until (varBarcode ="")
return

AutoCreateContainer:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -20
Winset, Trans, 199, Hybrid 3.0
If (yQualifier = "")
{
	MsgBox, Chưa setting
	return
}
Loop
{
	gosub, starttime
	fdcount2:=1
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	If (fdcount >=1)
	{
	Loop
	{
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		click 258, 393 left, 1 ;Nut them
		sleep, 400
		;Cho hien ra bang tao
		gosub, CheckBangTao
		sleep, 300
		Click, 944, %yQualifier% left,1 ; Identifier
		Sleep, 400
			varCurrent = %varID%_%fdcount2%
			GuiControl, 1:, Current, %varCurrent%
			Send, %varCurrent%
			sleep,400
			fdcount2++
			Click, 1209, 494  left,1 ;click done
			sleep,500
			timeout:=0
			gosub, CheckDaTao
			gosub, CheckDone
	}
	until (fdcount2 > fdcount)
}
	gosub, endtime
	Row++
}
until (varBarcode ="")
return

Up:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -20
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	fdcount2:=1
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount >=1)
	{
	Loop
	{

		varCurrent = %varID%_%fdcount2%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		Loop
		{
			PixelGetColor, pxcheck, 1874, 608
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = maudatimthay ;check đã tìm thấy
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 800
		click , 299, 961 left, 1
		Loop
		{
			WinGetActiveTitle,Titlecheck
			IfInString,Titlecheck, Open
			{
				break
			}
		}
		sendraw, %varFolder%\%varBarcode%_%fdcount2%.jpg`n
		sleep,400
		gosub checkMap
		gosub, CheckSave
		sleep, 300
		click, 1882, 658 left, 1 ; click save
		sleep,200
		gosub, checkSaveDone
		gosub, CheckDone
		fdcount2++
	}
	until (fdcount2 > fdcount)
}
	gosub,endtime
	Row++
}
until (varBarcode="")
return

Map:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	fdcount2:=1
	If (varPause = 1)
	{
		return
	}
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount>=1)
	{
	Loop
	{
		varCurrent = %varID%_%fdcount2%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		Loop
		{
			PixelGetColor, pxcheck, 1874, 608
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = maudatimthay ;check đã tìm thấy
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 500
		gosub checkMap
		IfNotInString, checkmap, %varID% ;check da map chưa
		{
			click, 1880, 748 left, 1
			sleep, 400
			click, 1880, 776 left, 1
			sleep, 300
			;map
			sleep, 700
			click, 1013, 947 left, 1
			sleep, 1000
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
			sleep, 700
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
			}
			until pxcheck = 0xFFFFFF
			sleep, 600
			click, 664, 374 left, 1
			sleep, 600
			click, 666, 498  left, 1
			sleep, 300
			click, 518, 295 left, 1
			sleep, 400
			click, 496, 321 left, 1
			sleep, 500
			click,660, 294 left, 1
			sleep, 200
			send, %varCurrent%`n
			sleep, 700,
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF
			sleep, 700
			click, 585, 519 left, 1
			sleep, 500
			click, 1603, 862 left, 1
			sleep, 300
			gosub, checkDone
			sleep,400
			gosub, checkMap
			IfNotInString, checkmap, %varID%
			MsgBox, Check lại map trước khi OK?
			WinActivate, ahk_exe chrome.exe
			sleep,300
			click, 1882, 658 left, 1
			sleep, 500
			click, 1882, 658 left, 1 ; click save
		}
	sleep,200
	gosub, checkSaveDone
	gosub, CheckDone
	fdcount2++
	}
	until (fdcount2 > fdcount)
}
	Row++
}
until (varID ="")
return



;-------------------Check mau-------------------

CheckBangTao:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	sleep,200
	PixelGetColor, pxcheck, 1900, 180
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
	;MsgBox, %pxcheck%`n%maubangtao%
}
Until pxcheck = maubangtao ;Màu tối góc, bảng tạo hiện ra
return

CheckDaTao:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 1196, 236
	PixelGetColor, pxcheck2, 1897, 189
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
	timeout++
}
until (timeout = 100 or pxcheck =maudodatao or pxcheck2 = 0xFFFFFF ) ; màu đỏ đã trùng
if (pxcheck = maudodatao)
{
	click, 1144, 622 left,1
	sleep, 200
	click, 1149, 524 left, 1
	sleep, 200
}
return

checkDatimthay:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 1874, 608
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
}
until (pxcheck = maudatimthay)  ;check đã tìm thấy
return

CheckDone:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 1897, 189
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
}
until ( pxcheck = 0xFFFFFF) ;Màu trắng ở góc
return

CheckSave:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 1902, 658
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
}
until pxcheck = maunutsave
return

Checkloading:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 960, 518
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
}
until pxcheck <> mauloading
return

Checksavedone:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Loop
{
	PixelGetColor, pxcheck, 1902, 658
	GuiControl, 1:, GuiPxcheck,  %pxcheck%
}
until pxcheck = mausavedone
return

checkMap:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
click, 113, 81 left, 1
sleep,100
checkMap = %Clipboard%
return

checkConvert:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
click, 113, 81 left, 1
sleep,200
checkConvert = %Clipboard%
return

checkmapanh:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
ImageSearch,,y,1042, 897,1872, 1031,chuamapanh.png
If (y <>"")
{
	click, 1843, 946 left ,1
	Loop
	{
		PixelGetColor, pxcheck, 1610, 390
		GuiControl, 1:, GuiPxcheck,  %pxcheck%
	}
	until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
	sleep, 300
	Loop
	{
		PixelGetColor, pxcheck, 1610, 390
	}
	until pxcheck = 0xFFFFFF
	sleep, 600
	;click, 518, 295 left, 1
	;sleep, 400
	click, 496, 321 left, 1
	;sleep, 500
	click,660, 294 left, 1
	sleep, 200
	send, %varID%_%fdcount2%`n
	sleep, 500
	gosub, checkLoading
	Loop
	{
		PixelGetColor, pxcheck, 1610, 390
		GuiControl, 1:, GuiPxcheck,  %pxcheck%
	}
	until pxcheck = 0xFFFFFF
	sleep, 700
	click, 585, 519 left, 1
	sleep, 500
	click, 1603, 862 left, 1
	sleep, 300
	gosub, checkDone
	click, 1885, 661 left, 1
}
return

;------------


ConvertSp:
Gui 3: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	fdcount2:=1
	If (varPause = 1)
	{
		return
	}
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount >=1)
	{
	Loop
	{
		varCurrent = %varID%_%fdcount2%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		sleep,300
		click, 462, 462 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 400
		gosub, checkConvert
		IfNotInstring, checkConvert, Fresh Product Image Conversion Group
		{
			click, 283, 845 left, 1
			sleep, 300
			SendRaw, Fresh Product Image Conversion Group
			sleep, 600
			click,420, 875 left, 1
			gosub, CheckSave
			sleep, 300
			click, 1882, 658 left, 1 ; click save
			sleep,200
			gosub, checkSaveDone
			gosub, CheckDone
			sleep, 300
		}
		PixelGetColor, pxcheck, 1063, 1007
		gosub, checkmapanh
		if (pxcheck = maunutconvert)  ;màu nút convert
		{
			click, 1063, 1007 left, 1
			sleep,50
			MouseMove,0,0
			sleep, 300
			Loop
			{
				PixelGetColor, pxcheck, 1063, 1007
			}
			until pxcheck <>  maunutconvert
		}
		fdcount2++
	}
	until (fdcount2 > fdcount)
}
	gosub, endtime
	Row++
}
until (varID ="")
return


ConvertThoiTrang:
Gui 3: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	fdcount2:=1
	If (varPause = 1)
	{
		return
	}
	gosub, excel
	If (varID = "")
	{
		MsgBox, 4096, Thông báo, Không còn gì de tao dâu
		return
	}
	Loop
	{
		varCurrent = %varID%_%fdcount2%
		Clipboard = ""
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		sleep,300
		
		MouseMove, 282, 467 
		Loop
		{
		PixelGetColor,pxcheck,282, 467 
		}
		until pxcheck=0xF6F1EA
		click,282, 467  left,1
		Loop
		{
		PixelGetColor,pxcheck,983, 768
		}
		until pxcheck=0xFFFFFF
		
		gosub, checkConvert
		IfNotInstring, checkConvert, Fashion Product Image Conversion Group
		{
			click, 538, 846 left, 1
			sleep, 300
			SendRaw, Fashion Product Image Conversion Group
			sleep, 800
			click,420, 875 left, 1
			sleep,300
			{
				gosub, checkConvert
				IfNotInstring, checkConvert, Fashion Product Image Conversion Group
				{
					MsgBox, Loi
				}
				click, 1844, 941 left, 1
				Loop
				{
					PixelGetColor, pxcheck, 1691, 549
				}
				until pxcheck = 0x887E76
				;map
				click,660, 294 left, 1
				sleep, 200
				send, %varCurrent%`n
				sleep, 700,
				mousemove, 407, 522
				Loop
				{
					PixelGetColor,pxcheck,407, 522
				}
				until pxcheck=0xF6F1EA
				click, 407, 522 left, 1
				sleep, 500
				click, 1603, 862 left, 1
				sleep, 300
				gosub, checkDone
				sleep,400
			}
			gosub, CheckSave
			sleep, 300
			click, 1882, 658 left, 1 ; click save
			sleep,200
			gosub, checkSaveDone
			gosub, CheckDone
			sleep, 300
		}		
		fdcount2++
	}
	until (fdcount2 > fdcount)
	Row++
}
until (varID ="")
return

MapSanPham:
Gui 4: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount>=1)
	{
		varCurrent = %varID%
		Clipboard = ""
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 500
		click, 752, 712 left, 1
		sleep, 400
		click , 1015, 824  left,1
		sleep, 1000
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
		sleep, 400
		click,  691, 293 left, 1
		sleep, 300
		sendraw, %varID%_1`n
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
		click, 648, 521 left, 1
		sleep, 300
		click, 1611, 868 left, 1
		sleep, 400
		gosub, checkDone
		sleep, 300
		click, 1009, 878 left, 1
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
		sleep, 700
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
		}
		until pxcheck = 0xFFFFFF
		If (fdcount = 1)
		{
			click,660, 294 left, 1
			sleep, 200
			send, %varID%_1`n
			sleep, 700,
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF
			sleep, 700
			click, 585, 519 left, 1
			sleep, 500
			click, 1603, 862 left, 1
		}
		else
		{
			click, 509, 293 left, 1
			sleep, 600
			click, 509, 346  left, 1
			sleep, 300
			click,  691, 293 left, 1
			sleep, 300
			sendraw, %varID%`n
			sleep, 1400
			gosub, Checkloading
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF
			sleep,100
			a:=ContainerCount()
			sleep,100
			b:=AutoMapMediaContainerSP()
			If (a<>b and a<>fdcount)
			{
				MsgBox, Check lai
			}
			else
			{
				click, 1611, 868 left, 1
			}
		}
		sleep, 400
		gosub, checkDone
		sleep, 200
		gosub, CheckSave
		sleep, 300
		click, 1882, 658 left, 1 ; click save
		sleep,200
		gosub, checkSaveDone
		gosub, CheckDone
	}
	gosub,endtime
	Row++
}
until (varBarcode="")
return

MapBienThe:
Gui 4: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount >=1)
	{
		varCurrent = %varBienthe%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 500
		click, 752, 712 left, 1
		sleep, 400
		click , 1015, 824  left,1
		sleep, 1000
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xffffff ;check da hien bảng chọn ?
		sleep, 400
		click,  691, 293 left, 1
		sleep, 300
		sendraw, %varID%_1`n
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
		click, 648, 521 left, 1
		sleep, 300
		click, 1611, 868 left, 1
		sleep, 400
		gosub, checkDone
		sleep, 300
		click, 1009, 878 left, 1
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
		}
		until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
		sleep, 700
		Loop
		{
			PixelGetColor, pxcheck, 1614, 424
		}
		until pxcheck = 0xFFFFFF
		If (fdcount = 1)
		{
			;click, 664, 374 left, 1
			;sleep, 600
			;click, 666, 498  left, 1
			;sleep, 300
			;click, 518, 295 left, 1
			;sleep, 400
			;click, 496, 321 left, 1
			;sleep, 500
			click,660, 294 left, 1
			sleep, 200
			send, %varID%_1`n
			sleep, 500,
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF
			sleep, 700
			click, 585, 519 left, 1
			sleep, 500
			click, 1603, 862 left, 1
		}
		else
		{
			click, 509, 293 left, 1
			sleep, 600
			click, 509, 346  left, 1
			sleep, 300
			click,  691, 293 left, 1
			sleep, 300
			sendraw, %varID%`n
			sleep, 1400
			gosub, Checkloading
			Loop
			{
				PixelGetColor, pxcheck, 1607, 490
				GuiControl, 1:, GuiPxcheck,  %pxcheck%
			}
			until pxcheck = 0xFFFFFF
			sleep,100
			a:=ContainerCount()
			sleep,100
			b:=AutoMapMediaContainerSP()
			If (a<>b)
			{
				MsgBox, Check lai
			}
			else
			{
				click, 1611, 868 left, 1
			}
	}
		sleep, 400
		gosub, checkDone
		sleep, 200
		gosub, CheckSave
		sleep, 300
		click, 1882, 658 left, 1 ; click save
		sleep,200
		gosub, checkSaveDone
		gosub, CheckDone
		qcstate := CheckQC()
		if (qcstate <> "qcdone")
		{
			click, 356, 661 left, 1 ; click submit to  qc
			sleep,300
			click, 436, 663 left, 1
		}
	}
	gosub, endtime
	Row++
}
until (varBarcode="")
return



;----------------------Other Function----------------------------------------

Downanh:
Gui 5: submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	fdcount2:=1
	If (varPause = 1)
	{
		return
	}
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	Loop
	{
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			GuiControl, 1:, GuiPxcheck,  %pxcheck%
			timeout++
			If (timeout = 200)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep, 500
		send, !3
		sleep,300
		url = %Clipboard%
		baocao.range("A" . Row ).value := URL
		URLDownloadToFile, %URL%, C:\Users\minhcq\Desktop\DOWNLOAD\%varID%.jpg
	sleep,200
	gosub, checkSaveDone
	gosub, CheckDone
	fdcount2++
	}
	until (fdcount2 > fdcount)
	Row++
}
until (varID ="")
return

Duyet:
Gui 5: submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		If (fdcount<>"")
		{
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		sleep,300
		gosub, checkDatimthay
		ImageSearch,,yPFound, 1869, 412,1923, 449, PNG\0items.png
		If (yPFound = "")
		{
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			timeout++
			If (timeout = 40)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep,400
		qcstate := CheckQC()
		/*
		If (qcstate = "submit")
		{
		click, 356, 661 left, 1 ; click submit to  qc
		sleep,300
		click, 436, 663 left, 1
		mousemove, 100, 100
		}
		If (qcstage = "approve")
		{
		click, 436, 663 left, 1 ; click approve
		}
		sleep, 200
		Loop{
			mousemove, 100, 100
			qcstage := CheckQC()
		}
		until (qcstage = "qcdone")
		*/
		if (qcstate <> "qcdone")
		{
			click, 356, 661 left, 1 ; click submit to  qc
			sleep,300
			click, 436, 663 left, 1
		}
		;gosub, checkSaveDone
		;gosub, CheckDone
	}
	}

	Row++
}
until (varBarcode="")
return

Thayten:
Gui 5: submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
best1rowtime=100
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		gosub, checkDatimthay
		ImageSearch,,yPFound, 1869, 412,1923, 449, 0items.png
		If (yPFound = "")
		{
			ImageSearch,,yPFound,571, 451, 730, 523 , waitforqc.png
			If (yPFound <> ""){
				baocao.range("K" . Row ).value := "Wait for QC"
			}
			else
			{
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		timeout = 0
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			timeout++
			If (timeout = 40)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep,400
		click, 1852, 775 left, 1
		sleep, 300
		click, 1393, 821 left, 3
		sleep, 300
		send, ^c
		sleep, 200
		ten = %Clipboard%
		If (ten ="")
		{
			MsgBox, Copy bằng tay
			ten = %Clipboard%
			sleep, 300
		}
		IfNotInString,ten,Hàng chính hãng
		{
		newname =%ten% - Hàng chính hãng
		sendraw, %newname%
		sleep, 200
		click, 1374, 793 left, 3
		sleep, 200
		sendraw, %newname%
		sleep, 200
		gosub, CheckSave
		sleep, 100
		click, 1882, 658 left, 1 ; click save

	}
		sleep,200
	}
		;gosub, checkSaveDone
		;gosub, CheckDone
	}
	else
	{
		baocao.range("K" . Row ).value := "Bienthe"
	}
	Clipboard:=""
	Row++
	gosub, endtime
}
until (varBarcode="")
return

Checkthuoctinh:
Gui 5: submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%

WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,300
		gosub, Checkloading
		sleep,300
		gosub, CheckDone
		gosub, checkDatimthay
		ImageSearch,,yPFound, 1869, 412,1923, 449, 0items.png
		If (yPFound = "")
		{
		sleep,300
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		Loop
		{
			PixelGetColor, pxcheck, 1900, 883
			timeout++
			If (timeout = 60)
			{
				return
			}
		}
		until pxcheck = 0xFFFFFF ;check đã click sp
		sleep,400
		click, 353, 714 left, 1
		sleep, 300
		send, {END}
		sleep, 400
		send, {END}
		Loop,
		{
		ImageSearch,,yPFound, 221, 732,1031, 962, Subcat.png
		}
		until (yPFound <> "")
		sleep,400
		If  (yPFound >= 842)
		{
			baocao.range("F" . Row ).value := "<3"
		}
		baocao.range("G" . Row ).value := yPFound
		ImageSearch,,yPFound, 217, 942,1040, 1014, IncludedProducts.png
		If  (yPFound <> "")
		{
			baocao.range("F" . Row ).value := "Rỗng"
		}
		gosub, endtime
	}
	else
	{
		MsgBox, Không tìm thấy sp
	}
	Row++
}
until (varBarcode="")
Gui 7:Destroy
return

NewUp:
;ID:	1040455 - 832000
;Bien the: 1037656 - 824023
/*
[Fresh] Đức Min: 	748344
[Fresh] Nam: 		801158
[Fresh] Quý: 		832000 - 824023
[ICT] Ngọc Anh: 846592 - mã Fresh: 846589
Fashion] Ngọc Anh: 1066341 - 1071644
[Fashion] Bình Toon: 981365
[Fresh] Thùy Dương: 1040455 - 1037656
*/
Loop
{
	starttime:=starttime()
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
	if (fdcount>=1)
	{
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		; Switch to MC
		send, ^2
		sleep, 200
		; Click bookmark MC
		if (upconfig = 1)
		{
			click, 413, 86 left, 1
		}
		if (upconfig = 2)
		{
			click,904, 83 left, 1
		}
		Loop
			{
				WinGetActiveTitle,Titlecheck
				IfInString,Titlecheck, Tạo sản phẩm gốc
				{
					break
				}
			}
		sleep,400
		; Click bookmark 2 MC
		click,501, 88 left, 1
		sleep, 700
		; Click end -> Cuối trang
		send, {END}
		sleep, 200
		Loop
		{
			PixelGetColor, pxcheck, 1084, 1037
		}
		until pxcheck = 0xF1EFEC
		sleep, 500
		; Xoas anh da co
		Loop
		{
			PixelSearch, Px, Py, 500, 644, 1866, 838, 0x2c1beb ,3, fast
			Px := Px + 5
			Py := Py + 5
			click, %Px%, %Py%, left, 1
			If ErrorLevel
			{
				break
			}
			sleep, 200
		}
		; Up ảnh vào màu đen - đỏ - ID Biến thể 824023
		Loop ,%fdcount%
		{
			If (A_Index = 1)
			{
				click 695, 812 left ,1
			}
			else
			{
				click 640, 624 left ,1
			}
			Loop
			{
				WinGetActiveTitle,Titlecheck
				IfInString,Titlecheck, Open
				{
					break
				}
			}
			sleep, 400
			send, %varFolder%`n
			sleep,100
			send, {"}%varBarcode%_%A_Index%.jpg{"}
			sleep,100
			sendraw, `n
			sleep, 500
		}

			; Click bookmark cm finish - Click Đồng ý
		click, 575, 87 left, 1
		Loop
		{
			PixelGetColor, pxcheck, 1899, 510
		}
		until pxcheck = 0x797876
		sleep, 300
		click, 1116, 299 left, 1
		sleep, 3000
		; Switch to hybris
		send, ^1
		Loop,
		{
			if (upconfig = 1)
			{
				find(1037656)    ; Find biến thể 824023
			}
			if (upconfig = 2)
			{
				find(1071644)    ; Find biến thể 824023
			}
			click, 564, 502 left, 1 ;click picture
			sleep, 400
			CheckMau(1900,883,0xFFFFFF,200)
			sleep, 500
			; switch tab multimedia
			click, 743, 713 left,  1
			sleep, 300
			CheckMau(1730, 965,0xFFFFFF,100)

			ImageSearch, X, Y, 228, 863, 1038, 1012, PNG\_1].png
			If (X = "")
			{
				break
			}
		}
		sleep, 400
		; click gallery image
		click, 252, 878 left, 2
		; ảnh 1 -> click picture -> đổi identifier -> Save
		Loop
		{
			PixelGetColor, pxcheck, 1916, 575
		}
		until pxcheck = 0x887E76
		sleep, 400
		click, 951, 544 left, 2
		Loop
		{
			PixelGetColor, pxcheck, 1905, 575
		}
		until pxcheck = 0x53463C
		sleep, 200
		click, 739, 382 left, 3
		sleep,100
		send, %varID%_1
		sleep, 400
		click, 1244, 233 left, 1
		sleep, 200
		Loop
		{
			PixelGetColor, pxcheck, 1916, 575
		}
		until pxcheck = 0x887E76
		sleep, 200
		click, 791, 416 left, 3
		sleep, 100
		send, %varID%_1
		sleep, 800
		If (fdcount=1)
		{
			click, 1239, 266 left, 1
			sleep, 200
			click, 1264, 183 left, 1
		}
		;MsgBox, bllalblaa200
		else
		{

			click, 1075, 269 left, 1
			sleep, 400
			click, 1107, 224 left, 1
			sleep, 300
			; Loop ảnh 2 -> fdcound -> đổi identifier -> Save
			XAnh_All:=[260,290,320,350,380,410,440,470,500,530]
			;MsgBox, %fdcount3%
			for index, element in XAnh_All
			{
				sttanh:= index+1
				XAnh := element
				If (sttanh > fdcount)
				{
					break
				}
				;MsgBox, %XAnh%
				click, 1205, %XAnh% left,1
				sleep, 200
				click, 951, 544 left, 2
				Loop
				{
					PixelGetColor, pxcheck, 1905, 575
				}
				until pxcheck = 0x53463C
				sleep, 200
				click, 739, 382 left, 3
				sleep,100
				send, %varID%_%sttanh%
				sleep, 400
				click, 1244, 233 left, 1
				sleep, 200
				checkmau(1916,575,0x887E76)
				click, 791, 416 left, 3
				sleep, 100
				send, %varID%_%sttanh%
				sleep, 200
				checkmau(1092, 269,maunutsave)
				click, 1075, 269 left, 1
				sleep, 400
				click, 1107, 224 left, 1
				sleep, 300
					;MsgBox, check
			}
			sleep, 300
			click, 1264, 183 left, 1	
			sleep, 300	
	
		}
	}
	CheckMau(1902,193,"0xFFFFFF")
	endtime:=endtime()
	gosub, Conlaitime
	Row++
}
until (varID="")
return

Doibrand:
Gui 5:submit
Gui 5: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,100
		gosub, Checkloading
		sleep,100
		gosub, CheckDone
		sleep,100
		gosub, checkDatimthay
		ImageSearch,,yPFound,489, 459,1571, 536 , PNG\waitforqc.png
		If (yPFound <> ""){
			baocao.range("K" . Row ).value := "Wait for QC"
		}

		else
		{
			sleep,300
			click, 564, 502 left, 1 ;click picture

			sleep, 400
			Loop
			{
				PixelGetColor, pxcheck, 1900, 883
				timeout++
				If (timeout = 200)
				{
					return
				}
			}
			until pxcheck = 0xFFFFFF ;check đã click sp
			sleep, 500
			;switch tab category
			click, 562, 715 left, 1
			sleep, 400
			send, {End}
			sleep,400
			click, 1844, 862 left, 1
			sleep, 400
			click, 1345, 863 left, 1
			sleep, 200
			send, br15114
			sleep, 800
			click , 1247, 889 left, 1
			gosub, checkDone
			sleep, 200
			gosub, CheckSave
			sleep, 300
			click, 1882, 658 left, 1 ; click save
			sleep,200
			Loop, 50
			{
				PixelGetColor, pxcheck ,1652, 147
				If (pxcheck = 0x5246EF)
				{
					baocao.range("K" . Row ).value := "Loi"
					break
				}
				else
				{
					gosub, checkSaveDone
					gosub, CheckDone
					break
			}
		}
			gosub,endtime
		}
	Row++
}
until (varID = "")
return

Saithuoctinh:
Gui 5:submit
Gui 5: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		find(varID)
		ImageSearch,,yPFound, 1869, 412,1923, 449, PNG\0items.png
		If (yPFound <> ""){
			baocao.range("E" . Row ).value := "SP bi loi"
		}

		else
		{

			sleep, 400
			Loop
			{
				PixelGetColor, pxcheck, 1900, 883
				timeout++
				If (timeout = 200)
				{
					return
				}
			}
			until pxcheck = 0xFFFFFF ;check đã click sp
			sleep, 500
			;-----------------------------bat dau tu cho nay
			click, 588, 713 left, 1
			sleep, 300
			Loop
			{
				PixelGetColor, pxcheck,1879, 922
			}
			until pxcheck = 0xFFFFFF
			Size := getsize() ;Check size dang co
			Sizeexcel := baocao.range("D" . Row ).value
			;Neu size  = cot F -> next
			If (Size.size = Sizeexcel)
			{
				Row++
				gosub,endtime
				Continue
			}
			;Neu size <> cot F -> xoa size
			If (Size.size <> Sizeexcel)
			{
				;click xoa
				If (Size.size <> "Loi")
				{
					vitri := Size.vitri +5
					click, 1015, %vitri% left, 1
					sleep, 400
					MouseMove, 0,0
					sleep, 200
					ImageSearch, bachamX, bachamY, 227, 793, 1028, 960, PNG\bacham.png
					If ErrorLevel
					{
						MsgBox, Loi - Tu lam
						Continue
					}
					click, %bachamX%, %bachamY% left, 1
					sleep, 400
					Loop
					{
						PixelGetColor, pxcheck, 1614, 424
						GuiControl, 1:, GuiPxcheck,  %pxcheck%
					}
					until pxcheck = 0xFFFFFF ;check da hien bảng chọn ?
					sleep, 400
					click,  651, 335 left, 1
					sleep, 300
					If (Sizeexcel = "S")
					{
						send, VVC9882`n
					}
					If (Sizeexcel = "XS")
					{
						send, VVC9891`n
					}
					If (Sizeexcel = "M")
					{
						send, VVC9880`n
					}
					If (Sizeexcel = "L")
					{
						send, VVC9887`n
					}
					If (Sizeexcel = "XL")
					{
						send, VVC9890`n
					}
					If (Sizeexcel = "XXL")
					{
						send, VVC9957`n
					}
					baocao.range("E" . Row ).value := "Da doi"
					sleep, 700,
					Loop
					{
						PixelGetColor, pxcheck, 1607, 490
						GuiControl, 1:, GuiPxcheck,  %pxcheck%
					}
					until pxcheck = 0xFFFFFF
					sleep, 700
					click, 585, 519 left, 1
					sleep, 500
					click, 1603, 862 left, 1
				}
				else
				{
					baocao.range("E" . Row ).value := "Loi"
					Row++
					gosub,endtime
					Continue
				}
				sleep, 400
				gosub, checkDone
				sleep, 200
				gosub, CheckSave
				sleep, 300
				click, 1882, 658 left, 1 ; click save
			}
			;Find size moi

			;Ket thuc
			gosub, checkSaveDone
			gosub, CheckDone
			gosub,endtime
			gosub,endtime
		}
	Row++
}
until (varID = "")
return

;Saithuoctinh:
Gui 5:submit
Gui 5: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		MsgBox, Không còn gì để tạo đâu
		return
	}
		varCurrent = %varID%
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
		gosub,CheckDone
		gosub, FindID
		sleep,100
		gosub, Checkloading
		sleep,100
		gosub, CheckDone
		sleep,100
		gosub, checkDatimthay
		ImageSearch,,yPFound,489, 459,1571, 536 , PNG\waitforqc.png
		If (yPFound <> ""){
			baocao.range("K" . Row ).value := "Wait for QC"
		}

		else
		{
			sleep,300
			click, 564, 502 left, 1 ;click picture

			sleep, 400
			Loop
			{
				PixelGetColor, pxcheck, 1900, 883
				timeout++
				If (timeout = 200)
				{
					MsgBox, Timeout
					return
				}
			}
			until pxcheck = 0xFFFFFF ;check đã click sp
			sleep, 500
			;switch tab category
			click, 562, 715 left, 1
			sleep,400
			ImageSearch,xLocnuoc,yLocnuoc, 1869, 412,1923, 449, PNG\maylocnuoc.png
			yLocnuoc := yLocnuoc +10
			ImageSearch, bachamX, bachamY, 227, 793, 1028, 960, PNG\bacham.png
			If ErrorLevel
			{
				MsgBox, Loi - Tu lam
				Continue
			}
			click, %bachamX%-60, %bachamY% left, 1
			send, 3325600291017
			sleep, 400
			gosub, checkDone
			sleep, 200
			gosub, CheckSave
			sleep, 300
			click, 1882, 658 left, 1 ; click save
			gosub, checkSaveDone
			gosub, CheckDone
			click, 1014, yLocnuoc left, 1
			sleep, 300
			click, 1882, 658 left, 1 ; click save
			gosub, checkSaveDone
			gosub, CheckDone
			}

			gosub,endtime

	Row++
		}
until (varID = "")
return

Checkfolder:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	gosub, starttime
	gosub, excel
	If (varID = "")
	{
		return
	}
	If (fdcount > 0)
	{
		baocao.range("AA" . Row ).value := fdcount
	}
	else
	{
		MsgBox, Dong %row% chua co anh
	}
	Row++
}
until (varID = "")
return
;------------------------------------------------------------------------------------------------------Funtion-----------------------------------------------------------------------



excel:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
if (varBienthe <> "")
{
	varIDtruoc := varID
	varBarcodetruoc := varBarcode
}
varID := baocao.range("C" . Row ).value
varBarcode := baocao.range("B" . Row ).value
varBienthe := baocao.range("D" . Row ).value
StringReplace,varID,varID, .000000,,
StringReplace,varBienthe,varBienthe, .000000,,
StringReplace,varBarcode,varBarcode, .000000,,
if (varID = "" and varBienthe <> "")
{
	varID := varIDtruoc
	varBarcode := varBarcodetruoc
}
Loop, 6
{
	varID_%A_Index% = %varID%_%A_Index%
	temp:= varID_%A_Index%
	;GuiControl, 1:, ID%A_Index%, %temp%
}
varFolder = %folderloc%\%varBarcode%
fdcount :=0
;Dem Anh
loop, %varFolder%\%varBarcode%_*.jpg
{
	fdcount ++
}
loop, %varFolder%\%varBarcode%_*.jpeg
{
	fdcount ++
}
varAnh = %varFolder%\%varBarcode%_1.jpg
GuiControl, 1:, ID, %varID%
GuiControl, 1:, Bienthe, %varBienthe%
GuiControl, 1:, Barcode , %varBarcode%
GuiControl, 1:, GSoAnh, Số ảnh: %fdcount%
GuiControl, 1:, GuiRow , Dòng số: %Row%
GuiControl, 1:, Anh, %varAnh%
return




Count:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
Row:=2
count:=0
Loop
{
	varID := baocao.range("C" . Row ).value
	row++
	count++
}
until (varID="")
MsgBox, Count :%count%
return

starttime:
Gui 7: Show, x800 y0 NoActivate
starttime:= A_Sec
return

endtime:
	endtime:= A_SEC
	lasttime:=estimatedmin
	lastrowtime:=endtime-starttime
	if lastrowtime>0
	{
		estimatedmin:= lastrowtime*(count-row)/60
		if (lastrowtime<best1rowtime AND lastrowtime>0)
		{
			best1rowtime:=lastrowtime
		}

		if (estimatedmin <0)
		{
			estimatedmin := lasttime
		}

		If (lasttime <> "")
		{
			heso:= row/count
			estimatedmin:=estimatedmin*heso+lasttime*(1-heso)
		}
	estimatedhours:=floor(estimatedmin/60)
	estimatedmins:=(estimatedmin/60-estimatedhours)*60
	estimatedsecs:=floor((estimatedmins-floor(estimatedmins))*60)
	estimatedmins:=floor(estimatedmins)
	;StringReplace,estimated,estimated, 00000,,all
	}
	;MsgBox, cound:%count%`nstarttime: %starttime%`nendtime: %endtime%`nEstimated time: %estimated% phút
	GuiControl,1:, Estimated, Còn lại: about %estimatedhours%:%estimatedmins%
	GuiControl,7:, Estimated2, Còn lại: %estimatedhours%:%estimatedmins%:%estimatedsecs% - Row  %row%/%count% - %lastrowtime%s 1 dòng - best time: %best1rowtime%s
	return


Conlaitime:
besttime := timedisplay.besttime
If (endtime > starttime){
;MsgBox, % starttime "-" endtime "-" row "-" count "-" besttime
timedisplay:= timecount(starttime,endtime,row,count,besttime)
;MsgBox, % timedisplay.hour
GuiControl, 1:, Estimated,% "Còn lại: "timedisplay.hour ":" timedisplay.min ":" timedisplay.sec "- Last time :" timedisplay.lastrowtime " Best time: " besttime
}
return

;