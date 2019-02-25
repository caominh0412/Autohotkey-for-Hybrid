#Include, Lib\gdip.ahk

Startup:
FileRead,configfile,LamViec.txt
config := []
Loop, Parse, configfile, "`n"
{
	config.push(A_LoopField)
}

folder := config[1]
trim(folder)
FolderServer := config[2]
NamePC := config[3]
RTserver := config[4]

Gui 1: Add, Button, x22 y9 w100 h30 gBack, Back
Gui 1: Add, Button, x122 y9 w100 h30 gNext, Next
Gui 1: Add, Picture, x332 y9 w150 h150 vAnh gNextImage +0xE +0x40
Gui 1: Add, Text, x332 y159 w150 h20 vFolderGui, Folder name
Gui 1: Add, Text, x332 y179 w150 h20 vSizeanh, Size anh
Gui 1: Add, Button, x22 y69 w100 h30 gOpenFolder, Open Folder
Gui 1: Add, GroupBox, x12 y49 w320 h60 , Folder
Gui 1: Add, Button, x122 y69 w100 h30 gOpenPts, Open in Photoshop
Gui 1: Add, GroupBox, x12 y119 w320 h60 , Setting
Gui 1: Add, Button, x22 y139 w100 h30 gNewjob, New Job 
Gui 1: Add, Button, x122 y139 w100 h30 gSetting, Change Folder
Gui 1: Add, Button, x222 y9 w100 h30 gTonotworkingfolder, To next working folder
Gui 1: Add, Button, x222 y139 w100 h30 gCheckfolder, Check folder
Gui 1: Add, Button, x222 y69 w100 h30 gNextPts, Next in Photoshop
Gui 1: +AlwaysOnTop
Gui 1: Show, x1422 y425 w504 h207, Working GUI

Gui 2: Add, Text, x12 y9 w100 h30 , Drop here
Gui 2: Add, ListBox, x12 y39 w300 h310 vMyList gMyList,

Gui 3: Add, Edit, x12 y9 w350 h30 vFolderServer, %FolderServer%
Gui 3: Add, Edit, x12 y49 w100 h30 vNamePC, %namePc%
Gui 3: Add, Edit, x122 y49 w100 h30 vRTserver, %RTserver%
Gui 3: Add, Button, x372 y9 w100 h30 gCopytoPc, Copy to PC
Gui 3: Add, Button, x372 y49 w100 h30 gUpload, Upload to Server
; Generated using SmartGUI Creator for SciTE

Gui, Start: Add, Edit, x92 y9 w290 h60 vfolder,%folder%
Gui, Start: Add, Button, x172 y79 w100 h20 Center gDirSubmit, Submit
; Generated using SmartGUI Creator for SciTE

gosub,Setting
return

GuiClose:
FileDelete, LamViec.txt
FileAppend,%folder%`n,LamViec.txt,UTF-8
FileAppend,%FolderServer%`n,LamViec.txt,UTF-8
FileAppend,%NamePC%`n,LamViec.txt,UTF-8
FileAppend,%RTserver%,LamViec.txt,UTF-8
ExitApp
return

Setting:
Gui, Start: Show, w479 h101, Config GUI
return

DirSubmit:
Gui, Start: Submit
FolderList := []
Loop, Files, %folder%\*.*,D
	FolderList.Push(A_LoopFileName)
Row := 1
gosub, GetRow
return

Next:
Row++
gosub, GetRow
return

Back:
Row--
if (Row <= 1)
{
	Row := 1
	MsgBox, Hết
	return
}
gosub, GetRow
return

OpenFolder:
Run, %CurrentFolder%
return

OpenPts:
Loop, %CurrentFolder%\*.jpg
{
	RunWait, C:\Program Files\Adobe\Adobe Photoshop CC 2015\Photoshop.exe %A_LoopFileFullPath%
}
Loop, %CurrentFolder%\*.png
{
	RunWait, C:\Program Files\Adobe\Adobe Photoshop CC 2015\Photoshop.exe %A_LoopFileFullPath%
}
return

Checkfolder:
Gui 2: Show, w332 h362, Untitled GUI
Loop, Files, %folder%\*.jpg,R
		{
			IfNotInString, A_Loopfilename, renamed
			{	
				If ( A_LoopFileSizeKB >= 450 )
				{
					FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
					;MsgBox, %A_temp%\%A_loopfilename%
					RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
					namenoext := StrSplit(A_loopfilename,".")[1]
					FileCreateDir,%A_LoopFileDir%\rename
					FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.jpg
					FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
					FileDelete,%A_temp%\%A_loopfilename%				
					GuiControl, 2:, MyList, %A_LoopFileName%
				}	
				GDIPToken := Gdip_Startup()                                     
				pBM := Gdip_CreateBitmapFromFile( A_LoopFileFullPath )                 
				W:= Gdip_GetImageWidth( pBM )
				H:= Gdip_GetImageHeight( pBM )   
				Gdip_DisposeImage( pBM )                                          
				Gdip_Shutdown( GDIPToken )
				Sizeanh := W . "x" . H
			}
		}
Loop, Files, %folder%\*.png,R
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
				GuiControl, 2:, MyList, %A_LoopFileName%
		}
	}
Loop, Files, %folder%\*.jpeg,R
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
				GuiControl, 2:, MyList, %A_LoopFileName%				
		}
	}			
GuiControl, 2:,-Redraw	,MyList
GuiControl, 2:,+Redraw	,MyList
MsgBox, DONE
return

NextPts:
^`::
gosub, Next
gosub, OpenPts
return

Tonotworkingfolder:
Row := 1
Loop,
{
	gosub, GetRow
	If(Sizeanh <> "820x820" AND Sizeanh <> "762x1100")
		Break
	Row ++
}
until Row > FolderList.Length()
return

GetRow:
CurrentFolder := FolderList[Row]
GuiControl, 1:,FolderGui, Folder: %CurrentFolder%
CurrentFolder := folder . "\" . CurrentFolder
Anh := []
Loop, Files, %CurrentFolder%\*.jpg
		{
			IfNotInString, A_Loopfilename, renamed
			{	
				If ( A_LoopFileSizeKB >= 450 )
				{
					FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
					;MsgBox, %A_temp%\%A_loopfilename%
					RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
					namenoext := StrSplit(A_loopfilename,".")[1]
					FileCreateDir,%A_LoopFileDir%\rename
					FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.jpg
					FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
					FileDelete,%A_temp%\%A_loopfilename%				
					GuiControl, 2:, MyList, %A_LoopFileName%
				}	
			}
		}
Loop, Files, %CurrentFolder%\*.png
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
				GuiControl, 2:, MyList, %A_LoopFileName%
		}
	}
Loop, Files, %CurrentFolder%\*.jpeg
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
				GuiControl, 2:, MyList, %A_LoopFileName%				
		}
	}			
Loop, %CurrentFolder%\*.jpg
{
	Anh.Push(A_LoopFileName)
}
	Anh1 := CurrentFolder . "\" . Anh[1]
	GuiControl, 1:, Anh, %Anh1%
	GDIPToken := Gdip_Startup()                                     
	pBM := Gdip_CreateBitmapFromFile( Anh1 )                 
	W:= Gdip_GetImageWidth( pBM )
	H:= Gdip_GetImageHeight( pBM )   
	Gdip_DisposeImage( pBM )                                          
	Gdip_Shutdown( GDIPToken )
	Sizeanh := W . "x" . H
	GuiControl, 1 :,Sizeanh, Size: %Sizeanh%
	AnhID = 1
return

MyList:
If A_GuiControlEvent <> DoubleClick
	return
GuiControlget, MyList
Msgbox, U click %MyList%
return

NextImage:
if (AnhID = Anh.Length())
{
	AnhID = 1
}
Else
{
	AnhID ++
}
CurrentAnh := Anh[AnhID]
CurrentAnh := CurrentFolder . "\" . CurrentAnh
GuiControl, 1:, Anh, %CurrentAnh%
	GDIPToken := Gdip_Startup()                                     
	pBM := Gdip_CreateBitmapFromFile( CurrentAnh )                 
	W:= Gdip_GetImageWidth( pBM )
	H:= Gdip_GetImageHeight( pBM )   
	Gdip_DisposeImage( pBM )                                          
	Gdip_Shutdown( GDIPToken )
	Sizeanh := W . "x" . H
	GuiControl, 1 :,Sizeanh, Size: %Sizeanh%
Return

Newjob:
Gui 3: Show, w479 h93, New Job GUI
return

Upload:
return

CopytoPc:
Gui 3: Submit, NoHide
folder = C:\Users\minhcq\AppData\data\download\%NamePC%
SplashTextOn, 300,300, Copying, Copying.......
FileCopyDir, %FolderServer%, C:\Users\minhcq\AppData\data\download\%NamePC%
SplashTextOff
FolderList := []
Loop, Files, %folder%\*.*,D
	FolderList.Push(A_LoopFileName)
Row := 1
gosub, GetRow
return