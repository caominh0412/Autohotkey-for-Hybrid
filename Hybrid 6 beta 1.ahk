global maubangtao =   0x8F8781 ; màu bảng tạo 1900, 180
global maudodatao = 0x4E4EF4 ; màu đỏ đã tạo 1196, 236
global maudatimthay = 0xF1EDEA  ; màu đã tìm thấy sp 1874, 608
global maunutsave =  0x42DFFB ; màu nút save  1902,658 0x2BDFFC
global mauloading =0x664C3C ; màu xám loading quay quay 960,518
global mausavedone = 0xE4DAD2 ; màu nút savedone
global maunutconvert = 0x76583F ;màu nút convert

#Include, Lib\function.ahk
;---------------------------------------------
/*

Bookmark checkmap
javascript:var text = document.getElementsByClassName('ye-default-reference-editor-selected-item-label z-label')[2].innerText; var copyFrom = $('<textarea/>'); copyFrom.css({ position: "absolute", left: "-1000px", top: "-1000px", }); copyFrom.text(text); $('body').append(copyFrom); copyFrom.select(); document.execCommand('copy');

*/

;-----------------------------------Start -----------------------
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
goto, Guichinh
;goto, start
return

GuiStartClose:
ExitApp

;------------------------------------Gui chinh---------------------------
Guichinh:
baocao := ComObjCreate("Excel.Application") 
baocao.Workbooks.Open(baocaoloc)
baocao.Visible := True
gosub, Count

WinActivate, ahk_exe chrome.exe
Row := 2
gosub, excel
Process,close, GoTiengViet.exe


Gui 1: Add, Button, x2 y9 w100 h30 gFolder vFolder, Folder - %fdcount%
Gui 1: Add, Button, x102 y9 w100 h30 gID vID, %varID%
Gui 1: Add, Button, x2 y39 w100 h30 vBarcode gBarcode, %Barcode%
Gui 1: Add, Button, x102 y39 w100 h30 gBienthe vBienthe, Bienthe
Gui 1: Add, GroupBox, x2 y79 w200 h90 , Auto
Gui 1: Add, Button, x12 y99 w180 h30 gUp, Up anh
Gui 1: Add, Button, x12 y129 w180 h30 gMapContainSP, Map ảnh
Gui 1: Add, GroupBox, x2 y179 w200 h90 , Excel
Gui 1: Add, Button, x12 y199 w80 h30 gBack, Back
Gui 1: Add, Button, x112 y199 w80 h30 gNext, Next
Gui 1: Add, Button, x12 y229 w80 h30 gTop, Top
Gui 1: Add, Button, x112 y229 w80 h30 gSelectRow, Chọn dòng
Gui 1: Add, Text, x2 y279 w80 h20 vGuiRow, Dòng số: %Row%
Gui 1: Add, Text, x92 y279 w100 h20 vCurrent, %varCurrent%
Gui 1: Add, Progress, x2 y299 w190 h20 vProgressBar, 0
Gui 1: Add, Text, x2 y329 w190 h30 vEstimated, Còn lại: 
;Gui 1: Add, Button, x2 y359 w100 h30 gNewSession, Open Chrome
;Gui 1: Add, Button, x102 y359 w100 h30 gOtherThings, Các chức năng khác
Gui 1: Add, Button, x102 y389 w100 h30 gQuit, Quit
Gui 1: Add, Button, x2 y389 w100 h30 gReset, Reset
; Generated using SmartGUI Creator for SGui 1: +AlwaysOnTop
Gui 1: +AlwaysOnTop
Gui 1: Show, x0 y79, Hybrid 6.0

Gui 2: Add, Button, x2 y10 w100 h30 gMapSanPham, Map Sản Phẩm
Gui 2: Add, Button, x112 y10 w100 h30 gMapBienthe, Map Biến thể
Gui 2: +AlwaysOnTop +LastFound +ToolWindow
/*
Gui 3: Add, Button, x10 y10 w100 h30  gDownanh, Down ảnh
Gui 3: Add, Button, x110 y10 w100 h30  gDuyet, Duyệt SP
Gui 3: Add, Button, x210 y10 w100 h30  gThayten, Thay tên
Gui 3: Add, Button, x310 y10 w100 h30  gCheckthuoctinh, Check thuộc tính
Gui 3: Add, Button, x510 y10 w100 h30  gDoibrand, Doi Brand 
Gui 3: Add, Button, x610 y10 w100 h30  gSaithuoctinh, Sai thuoc tinh 
Gui 3: +AlwaysOnTop +LastFound +ToolWindow
*/

Gui 4: Add, Button, x2 y10 w100 h30 gUpsanpham, San pham
Gui 4: Add, Button, x112 y10 w100 h30 gUpThoitrang, Thoitrang
Gui 4: +AlwaysOnTop +LastFound +ToolWindow

return

GuiClose:
Quit:
^Q::
Run, C:\GoTiengViet\GoTiengViet.exe
FileDelete, Lastdir.txt
FileAppend,%folderloc%,LastDir.txt,UTF-8
baocao.Workbooks.Close()
ExitApp

;------------------------------Gui phu---------------------------------




;-------------------------------Gui 1 funtion-------------------
Up:
Gui 4:Show, x500 y500 w300 h100, UP
return

MapContainSP:
Gui 2: Show
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
GuiControl, 1:, Folder , *%varFolder%
return

ID:
Clipboard := varID
varCurrent := Clipboard
GuiControl, 1:, Current, %varCurrent%
GuiControl, 1:, ID , *%varID%
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
baocao.Workbooks.Close()
Reload

Progress1:

Percent := Row/count*100
GuiControl,1:, ProgressBar, %Percent%
return

;-------------------------------------Gui 4 funtion ----------------------
Upsanpham:
upconfig:=1
gui 4: Submit
goto, NewUp
return

UpThoitrang:
upconfig:=2
gui 4: Submit
goto, NewUp
return

;------------------ Up moi --------------------

NewUp:
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
		sleep, 1800
		; Switch to hybris
		send, ^1	
		if (upconfig = 1)
		{
			find(824023)    ; Find biến thể 824023 
		}
		if (upconfig = 2)
		{
			find(990802)    ; Find biến thể 824023 
		}
		click, 564, 502 left, 1 ;click picture
		sleep, 400
		CheckMau(1900,883,0xFFFFFF,200)
		sleep, 500
		; switch tab multimedia
		click, 743, 713 left,  1
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
			XAnh_All:=[260,290,320,350,380,410,440]
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
				click, 776, 380 left, 3
				sleep, 100
				send, %varID%_%sttanh%
				sleep, 600
				click, 1073, 235 left, 1
				sleep, 500
				;MsgBox, check
			}
			sleep, 300
			click, 1264, 183 left, 1
		}
	}
	endtime:=endtime()
	gosub, Conlaitime
	Row++
}
until (varID="")
return

;--------------------------------- Map sp + bt--------------------------------------
MapSanPham:
Gui 2: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
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
		Clipboard = ""
		GuiControl, 1:, Current, %varCurrent%
		gosub, Progress1
		WinActivate, ahk_exe chrome.exe
		sleep, 200
        find(varCurrent)
		CheckMau(1900,883,0xFFFFFF,200)
		sleep, 500
		click, 752, 712 left, 1
		sleep, 400
		click, 1012, 991  left,1
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
		checkDone()
		sleep, 300
		click, 1011, 1033 left, 1
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
			Checkloading()
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
		checkDone()
		sleep, 200
		checkSave()
		sleep, 300
		click, 1882, 658 left, 1 ; click save
		sleep,200
		checkSaveDone()
		checkDone()
	}
	endtime:=endtime()
	gosub, Conlaitime
	Row++
}
until (varBarcode="")
return

MapBienThe:
Gui 2: Submit
GuiControl,1:,AppStatus, Label %A_ThisLabel%
WinMove, Hybrid 3.0,, -60
Winset, Trans, 199, Hybrid 3.0
Loop
{
	;gosub, starttime
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
		CheckDone()
        find(varCurrent)
		CheckMau(1900,883,0xFFFFFF,200)
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
		checkDone()
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
			Checkloading()
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
		checkDone()
		sleep, 200
		checkSave()
		sleep, 300
		click, 1882, 658 left, 1 ; click save
		sleep,200
		checkSaveDone()
		checkDone()
	}
	;gosub, endtime
	Row++
}
until (varBarcode="")
return

;--------------------------------------------------------------------------
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
if (varID = "")
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
GuiControl, 1:, ID, %varID%
GuiControl, 1:, Bienthe, %varBienthe%
GuiControl, 1:, Barcode , %varBarcode%
GuiControl, 1:, GSoAnh, Số ảnh: %fdcount%
GuiControl, 1:, GuiRow , Dòng số: %Row%
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

Conlaitime:
besttime := timedisplay.besttime
If (endtime > starttime){
;MsgBox, % starttime "-" endtime "-" row "-" count "-" besttime
timedisplay:= timecount(starttime,endtime,row,count,besttime)
;MsgBox, % timedisplay.hour 
GuiControl, 1:, Estimated,% "Còn lại: "timedisplay.hour ":" timedisplay.min ":" timedisplay.sec "- Last time :" timedisplay.lastrowtime " Best time: " besttime
}
return