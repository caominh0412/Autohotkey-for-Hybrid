time = %A_DD%_%A_MM%_%A_YYYY%
FileCreateDir, C:\it-support\IT-Support\Backup\%time%
FileCreateDir, C:\it-support\IT-Support\Backup\%time%\Image
FileCreateDir, C:\it-support\IT-Support\Backup\%time%\Excel
FileCreateDir, C:\it-support\IT-Support\Backup\%time%\Folder
dir = C:\it-support\IT-Support\Backup\%time%
MsgBox, %dir%
FileMove, %A_Desktop%\*.jpg, %dir%\Image
FileMove, %A_Desktop%\*.png, %dir%\Image
FileMove, %A_Desktop%\*.xlsx, %dir%\Excel
FileMoveDir, %A_Desktop%\*, %dir%\Folder\*
MsgBox, DONE