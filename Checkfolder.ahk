Checkfolder:
Gui, Add, Text, x12 y9 w100 h30 , Drop here
Gui, Add, ListBox, x12 y39 w300 h310 vMyList gMyList,
; Generated using SmartGUI Creator for SciTE
Gui, Show, w332 h362, Untitled GUI
return

GuiClose:
ExitApp
Gui, +AlwaysOnTop +ToolWindow

return

GuiDropFiles:
Folder = %A_GuiEvent%
Loop, Files, %Folder%\*.jpg,R
		{
			If ( A_LoopFileSizeKB > 450 )
			{	
				IfNotInString, A_Loopfilename, renamed
				{
				FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
				;MsgBox, %A_temp%\%A_loopfilename%
				RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
				namenoext := StrSplit(A_loopfilename,".")[1]
				FileCreateDir,%A_LoopFileDir%\rename
				FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.jpg
				FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
				FileDelete,%A_temp%\%A_loopfilename%				
				GuiControl,, MyList, %A_LoopFileName%
				}
			}
		}
Loop, Files, %Folder%\*.png,R
	{
		IfNotInString, A_Loopfilename, renamed
		{
				FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
				;MsgBox, %A_temp%\%A_loopfilename%
				RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
				namenoext := StrSplit(A_loopfilename,".")[1]
				FileCreateDir,%A_LoopFileDir%\rename
				FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
				FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.png
				FileDelete,%A_temp%\%namenoext%.jpg
				FileDelete,%A_temp%\%A_loopfilename%
				GuiControl,, MyList, %A_LoopFileName%
		}
	}
Loop, Files, %Folder%\*.jpeg,R
	{
		IfNotInString, A_Loopfilename, renamed
		{
				FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
				;MsgBox, %A_temp%\%A_loopfilename%
				RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
				namenoext := StrSplit(A_loopfilename,".")[1]
				FileCreateDir,%A_LoopFileDir%\rename
				FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
				FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.jpeg
				FileDelete,%A_temp%\%namenoext%.jpg
				FileDelete,%A_temp%\%A_loopfilename%	
				GuiControl,, MyList, %A_LoopFileName%				
		}
	}			
GuiControl,-Redraw	,MyList
GuiControl,+Redraw	,MyList
MsgBox, DONE
return

MyList:
If A_GuiControlEvent <> DoubleClick
	return
GuiControlget, MyList
Msgbox, U click %MyList%
return