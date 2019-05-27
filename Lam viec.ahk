﻿#Include, Lib\gdip.ahk


Startup:
imageext := ["jpg","png","jpeg","tif","gif","bmp"]
FileRead,configfile,LamViec.txt
config := []
Loop, Parse, configfile, `n,`r
{
	config.push(A_LoopField)
}

folder := config[1]
FolderServer := config[2]
NamePC := config[3]
RTserver := config[4]

Gui 1: Add, Button, x22 y9 w100 h30 gBack, Back
Gui 1: Add, Button, x122 y9 w100 h30 gNext, Next
Gui 1: Add, Picture, x332 y9 w150 h150 vAnh gNextImage +0xE +0x40
Gui 1: Add, Text, x332 y159 w150 h20 vFolderGui, Folder name
Gui 1: Add, Text, x332 y179 w70 h40 vSizeanh, Size anh
Gui 1: Add, Text, x412 y179 w70 h40 vSoanh, So anh
Gui 1: Add, Button, x22 y69 w100 h30 gOpenFolder, Open Folder
Gui 1: Add, GroupBox, x12 y49 w320 h60 , Folder
Gui 1: Add, Button, x122 y69 w100 h30 gOpenPts, Open in Photoshop
Gui 1: Add, GroupBox, x12 y119 w320 h60 , Setting
Gui 1: Add, Button, x22 y139 w100 h30 gNewjob, New Job 
Gui 1: Add, Button, x122 y139 w100 h30 gSetting, Change Folder
Gui 1: Add, Button, x222 y9 w100 h30 gTonotworkingfolder, To next working folder
Gui 1: Add, Button, x222 y139 w100 h30 gCheckfolder, Check folder
Gui 1: Add, Button, x222 y69 w100 h30 gContentGen, Create Content Image


Gui 1: +AlwaysOnTop
Gui 1: Show, x1422 y425 w504 h207, Working GUI

Gui 2: Add, Text, x12 y9 w100 h30 , Drop here
Gui 2: Add, ListBox, x12 y39 w300 h310 vMyList gMyList,

Gui 3: Add, Edit, x12 y9 w340 h80 vFolderServer, %FolderServer%
Gui 3: Add, Edit, x12 y99 w340 h30 vNamePC, %NamePc%
Gui 3: Add, Edit, x12 y139 w340 h30 vRTserver, %RTserver%
Gui 3: Add, Button, x372 y9 w100 h30 gCopytoPc, Copy to PC
Gui 3: Add, Button, x372 y59 w100 h30 gUpload, Upload to Server
Gui 3: Add, Button, x372 y99 w100 h30 gSelectFolder, Select folder
Gui 3: Add, Text, x372 y139 w100 h30 , RT folder name


Gui, Start: Add, Edit, x12 y9 w370 h70 vfolder,%folder%
Gui, Start: Add, Button, x392 y9 w100 h30 gBrowse, Browse
Gui, Start: Add, Button, x392 y49 w100 h30 Center gDirSubmit, Submit
; Generated using SmartGUI Creator for SciTE
Gui 2: +AlwaysOnTop
Gui 3: +AlwaysOnTop
Gui Start: +AlwaysOnTop

gosub,Setting
return

SelectFolder:
Gui 3:Submit, nohide
FileSelectFolder, FolderServer, %FolderServer%
GuiControl, 3:, FolderServer, %FolderServer%
return


Browse:
Run, C:\Users\minhcq\AppData\data\download
GuiControl, Start:, folder, %folder%
return

GuiClose:

ExitApp
return

Setting:
Gui, Start: Show, w507 h92, Config GUI
return

DirSubmit:
Gui, Start: Submit
FolderList := []
Loop, Files, %folder%\*.*,D
	FolderList.Push(A_LoopFileName)
Row := 1
FolderNum := FolderList.length()
gosub, GetRow
FileDelete, LamViec.txt
FileAppend,%folder%`n,LamViec.txt,UTF-8
FileAppend,%FolderServer%`n,LamViec.txt,UTF-8
FileAppend,%NamePC%`n,LamViec.txt,UTF-8
FileAppend,%RTserver%,LamViec.txt,UTF-8
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
list := []
For k,ext in imageext
{
	Loop, %CurrentFolder%\*.%ext%
	{
		RunWait, C:\Program Files\Adobe\Adobe Photoshop CC 2015\Photoshop.exe %A_LoopFileFullPath%
		sleep, 100
		list.Push(A_LoopFileFullPath)	
	}

}
random,RD1,1,list.MaxIndex()
randomfile := RD1
for i,k in list
{
	If (i = randomfile)
	{
		SplitPath, k, name, dir,ext
		FileCopy, %k%, %dir%\ct_%i%.%ext%
		RunWait, C:\Program Files\Adobe\Adobe Photoshop CC 2015\Photoshop.exe %dir%\ct_%i%.%ext%
		sleep,100
		;MsgBox, %dir%\ct_%i%.%ext%
		break
	}
}
return

Checkfolder:
Gui 2: Show, w332 h362, Untitled GUI
For k,ext in imageext
{
	Loop, Files, %folder%\*.%ext%,R
			{
				IfNotInString, A_Loopfilename, renamed
				{	
					If ( A_LoopFileSizeKB >= 450 OR A_LoopFileExt <> "jpg")
					{
						FileCopy, %A_LoopFilefullpath%, %A_temp%\%A_loopfilename%
						;MsgBox, %A_temp%\%A_loopfilename%
						RunWait, topng.exe `"%A_temp%\%A_LoopFileName%`" jpg
						namenoext := StrSplit(A_loopfilename,".")[1]
						FileCreateDir,%A_LoopFileDir%\rename
						FileMove, %A_LoopFilefullpath%, %A_Loopfiledir%\rename\%namenoext%_renamed.%ext%
						FIleCopy, %A_temp%\%namenoext%.jpg,%A_LoopFileDir%,1
						FileDelete,%A_temp%\%A_loopfilename%				
						GuiControl, 2:, MyList, %A_LoopFileName%
					}	
				}
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
For k,ext in imageext
{
	Loop, %CurrentFolder%\*.%ext%
	{
		Anh.Push(A_LoopFileName)
	}
}
	Soanh := Anh.length()
	Anh1 := CurrentFolder . "\" . Anh[1]
	GuiControl, 1:, Anh, %Anh1%
	GDIPToken := Gdip_Startup()                                     
	pBM := Gdip_CreateBitmapFromFile( Anh1 )                 
	W:= Gdip_GetImageWidth( pBM )
	H:= Gdip_GetImageHeight( pBM )   
	Gdip_DisposeImage( pBM )                                          
	Gdip_Shutdown( GDIPToken )
	Sizeanh := W . "x" . H
	GuiControl, 1 :,Sizeanh, %Sizeanh%`nFolder: %Row%
	GuiControl, 1 :,Soanh, So anh: %Soanh%`n/%Foldernum%
	AnhID = 1
	Clipboard := CurrentFolder
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
Gui 3: Show, w488 h179, New Job GUI
return

Upload:
Gui 3: Submit, NoHide
SplashTextOn, 300,300, Copying, Copying.......
FileCopyDir, %folder%, %FolderServer%\%RTserver%
SplashTextOff
return

CopytoPc:
Gui 3: Submit, NoHide
folder = C:\Users\minhcq\AppData\data\download\%NamePC%
SplashTextOn, 300,300, Copying, Copying.......
;FileCreateDir,C:\Users\minhcq\AppData\data\download\%NamePC%
MsgBox, %FolderServer%`n%folder%
FileCopyDir, %FolderServer%, %folder%
SplashTextOff
FolderList := []
Loop, Files, %folder%\*.*,D
	FolderList.Push(A_LoopFileName)
Row := 1
FileDelete, LamViec.txt
FileAppend,%folder%`n,LamViec.txt,UTF-8
FileAppend,%FolderServer%`n,LamViec.txt,UTF-8
FileAppend,%NamePC%`n,LamViec.txt,UTF-8
FileAppend,%RTserver%,LamViec.txt,UTF-8
gosub, GetRow
return

ContentGen:
Loop, Files, %folder%\*,D
		{
			list := []
			IfNotInString, A_Loopfilename, renamed
			{	
				Loop, Files, %A_LoopFileFullPath%\*.jpg
				{
					temp = %A_LoopFileFullPath%
					GDIPToken := Gdip_Startup()                                     
					pBM := Gdip_CreateBitmapFromFile( temp )                 
					W:= Gdip_GetImageWidth( pBM )
					H:= Gdip_GetImageHeight( pBM )   
					Gdip_DisposeImage( pBM )                                          
					Gdip_Shutdown( GDIPToken )
					Sizeanh := W . "x" . H
					if W = 914
					{
						continue 2
					}
					list.Push(A_LoopFileFullPath)	
				}
			}
			;MsgBox, % list.MaxIndex()
				random,RD1,1,list.MaxIndex()

				randomfile := RD1
				for i,k in list
				{
					If (i = randomfile)
					{
						SplitPath, k, name, dir,ext
						FileCopy, %k%, %dir%\ct_%i%.%ext%
						RunWait, C:\Program Files\Adobe\Adobe Photoshop CC 2015\Photoshop.exe %dir%\ct_%i%.%ext%
						sleep,100
						;MsgBox, %dir%\ct_%i%.%ext%
						break
					}
				}
			RD1 := ""
		}
MsgBox, Done
return