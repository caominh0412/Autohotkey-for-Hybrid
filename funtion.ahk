AutoMapMediaContainerSP()
{
WinActivate, ahk_exe chrome.exe
sleep, 300
ContainerCount2:=0
Loop,6
{
	ImageSearch,,y%A_Index%,299, 511,663, 743,_%A_Index%.png
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
	ImageSearch,,yContainerCount%A_Index%,1579, 445 ,1633, 470,%A_Index%items.png
	If (yContainerCount%A_Index% <> "")
	{
		ContainerCount = %A_Index%
	}
}
return ContainerCount
}
	

excel:
GuiControl,1:,AppStatus, Label %A_ThisLabel%
varID := baocao.range("C" . Row ).value
varBarcode := baocao.range("B" . Row ).value
varBienthe := baocao.range("D" . Row ).value
StringReplace,varID,varID, .000000,,
StringReplace,varBienthe,varBienthe, .000000,,
StringReplace,varBarcode,varBarcode, .000000,,
if (varID = "")
{
	varID := varIDtruoc
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
	}
	GuiControl,7:, Estimated2, Còn lại: %estimatedhours%:%estimatedmins%:%estimatedsecs% - Row  %row%/%count% - %lastrowtime%s 1 dòng - best time: %best1rowtime%s
	return


CheckQC()
{
		ImageSearch,,ysubmit,276, 645,490, 688 , submittoQC.png
		ImageSearch,,yapprove,276, 645,490, 688 , Approve.png
		ImageSearch,,yqcdone,276, 645,490, 688 , qcdone.png
		if (ysubmit <> ""){
			return "submit"
		}
		If (yapprove <> ""){
			return "approve"
		}
		If (yqcdone <> ""){
			return "qcdone"
		}
}

find(var)
{
	click, 637, 228 left,3
	sleep, 200
	SendRaw, %var%`n
}

colorcheck(pxcheck,x,y)
{
    Loop
	{
		PixelGetColor, var, x,y
	}
	until var = pxcheck
}