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
	time := {hour:%estimatedhours%,min:%estimatedmins%,sec:%estimatedsecs%,lastrowtime:%lastrowtime%,besttime:%best1rowtime%}
	MsgBox, %estimatedhours% - %estimatedmins% - %estimatedsecs%
	return time
	;StringReplace,estimated,estimated, 00000,,all
	}
}
/*
timecountinsec(starttime,endtime,row,count,lastcount)
{
	lastrowtime:=endtime-starttime
	MsgBox, 1 %lastrowtime%
	if lastrowtime>0
	{
		estimatedmin:= lastrowtime*(count-row)/60
		if (estimatedmin <0)
		{
			estimatedmin := lastcount
			return estimatedmin
		}
		return estimatedmin
	}
}

estimatedhours(min)
{
	estimatedhours:=floor(min/60)
	return estimatedhours
}

estimatedsecs(min)
{
	estimatedsecs:=floor((min-floor(min))*60)
	return estimatedsecs
}

estimatedmins(min)
{
	estimatedmins:=floor(min)
	return estimatedmins
}

thoigianconlai(estimatedmin,heso,lasttime)
{
	If (lasttime <> "")
	{
		heso:= row/count
		thoigianconlai:=estimatedmin*heso+lasttime*(1-heso)
		return thoigianconlai
	}	
}

*/
;------
debug:
starttime:=10
endtime:=100
row:=20
count:=60
best1rowtime:=15
lastcount:=19
min:=timecount(10,100,20,60,15)
MsgBox, % min.lastrowtime