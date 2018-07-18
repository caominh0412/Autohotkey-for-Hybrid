;-------------------------------Dem anh luc map ---------------------------

AutoMapMediaContainerSP()
{
WinActivate, ahk_exe chrome.exe
sleep, 300
ContainerCount2:=0
Loop,6
{
	ImageSearch,,y%A_Index%,299, 511,663, 743,PNG\_%A_Index%.png
	y%A_Index% := y%A_Index% +10
	If (y%A_Index% <> "")
	{
		yMouse:= y%A_Index%
		click, 555, %yMouse% left,1
		ContainerCount2++
	}
}
MouseMove, 1609, 862
return ContainerCount2
}

ContainerCount()
{
Loop, 6
{
	ImageSearch,,yContainerCount%A_Index%,1579, 445 ,1633, 470,PNG\%A_Index%items.png
	If (yContainerCount%A_Index% <> "")
	{
		ContainerCount = %A_Index%
	}
}
return ContainerCount
}

;--------------------------------- Dem excel ----------------------

ExcelCount()
{
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
}

;------------------------------- Tinh thoi gian 1 dong ------------------------

starttime()
{
	starttime:= A_Sec
	return starttime
}

endtime()
{
	endtime := A_Sec
	return endtime
}

timecount(starttime,endtime,row,count,lasttime)
{
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
	time := {hour: estimatedhours , min: estimatedmins , sec: estimatedsecs , lastrowtime: lastrowtime , besttime: best1rowtime }
	;MsgBox, %estimatedmin% - %estimatedhours% - %estimatedmins% - %estimatedsecs%
	return time
	}
}

;----------------------- Get size sp -----------
getsize()
{
	ImageSearch, Sx, Sy, 227, 793, 1028, 960, PNG\S.png
	ImageSearch, XSx, XSy, 227, 793, 1028, 960, PNG\XS.png
	ImageSearch, Mx, My, 227, 793, 1028, 960, PNG\M.png
	ImageSearch, Lx, Ly, 227, 793, 1028, 960, PNG\L.png
	ImageSearch, XLx, XLy, 227, 793, 1028, 960, PNG\XL.png
	ImageSearch, XXLx, XXLy, 227, 793, 1028, 960, PNG\XXL.png
	If (Sx <> "")
	{
		Giatri := {size: "S", Vitri: Sy}
	}
	If (XSx <> "")
	{
		Giatri := {size: "XS", Vitri: XSy}
	}
	If (Mx <> "")
	{
		Giatri := {size: "M", Vitri: My}
	}
	If (Lx <> "")
	{
		Giatri := {size: "L", Vitri: Ly}
	}
	If (XLx <> "")
	{
		Giatri := {size: "XL", Vitri: XLy}
	}
	If (XXLx <> "")
	{
		Giatri := {size: "XXL", Vitri: XXLy}
	}
	If (Sx = "" AND XSX = "" AND Mx = "" AND Lx = "" AND XLx = "" AND XXLx = "")
	{
		Giatri := {size: "Loi", Vitri: "Loi"}
	}
	return Giatri
}

;------------------------------- Tim kiem -------------------

find(var)
{
	click, 637, 228 left,3
	sleep, 200
	SendRaw, %var%`n
}


;---------------------------------Check trang thai QC---------------------
CheckQC()
{
		ImageSearch,,ysubmit,276, 645,490, 688 , PNG\submittoQC.png
		ImageSearch,,yapprove,276, 645,490, 688 , PNG\Approve.png
		ImageSearch,,yqcdone,276, 645,490, 688 , PNG\qcdone.png
		if (ysubmit <> ""){
			trangthai := "submit"
		}
		If (yapprove <> ""){
			trangthai := "approve"
		}
		If (yqcdone <> ""){
			trangthai := "qcdone"
		}
		return trangthai
}

;----------------------------- Count excel ---------------------------

debug:
starttime:=10
endtime:=100
row:=20
count:=60
best1rowtime:=15
lastcount:=19
thoigian:=timecount(starttime,endtime,row,count,best1rowtime)
MsgBox, % thoigian.hour ":" thoigian.min ":" thoigian.sec "-" thoigian.lastrowtime "-" thoigian.besttime
return

;---------------- Check trang
CheckMau(X,Y,Color)
{
	Loop
	{
		PixelGetColor, pxcheck, %X%, %Y%				
	}
	until (pxcheck = Color)  ;check đã tìm thấy
}

CheckDaTao()
{
	GuiControl,1:,AppStatus, Label %A_ThisLabel%
	Loop
	{
		PixelGetColor, pxcheck, 1196, 236
		PixelGetColor, pxcheck2, 1897, 189
		GuiControl, 1:, GuiPxcheck,  %pxcheck%		
		timeout++
		If (pxcheck = maudodatao)
		{
			click, 1144, 622 left,1
			sleep, 200
			click, 1149, 524 left, 1
			sleep, 200
			break
		}
		If (pxcheck2 = 0xFFFFFF){
			break
		}
		If (timeout = 100){
			MsgBox, Timeout
		}
	}
}

CheckBangtao()
{
	CheckMau(1900,190,maubangtao)
}

