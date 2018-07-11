baocaoloc := "C:\it-support\IT-Support\App\Book2.xlsx"
baocao := ComObjCreate("Excel.Application") 
baocao.Workbooks.Open(baocaoloc)
baocao.Visible := True
Row := 1
;dir := %A_Desktop%"\Mozlet"
Loop,
{
	baocao.Range("A" . Row, "W" . Row ).Interior.ColorIndex := 43
	barcode := baocao.range( "B" . Row ).value
	StringReplace, barcode,barcode, ".000000" ,, All]
	FileCreateDir, %A_Desktop%\Mozlet\%barcode%
	If ErrorLevel
	{
		MsgBox, Tao Folder loi
		baocao.Range("A" . Row, "W" . Row ).Interior.ColorIndex := 10
	}
	Else
	{
			Colume := ["C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W"]
		For index, element in Colume
		{
			link := baocao.range(element . Row ).value
			;MsgBox, %link%
			IfInString, link, https
			{
		
				UrlDownloadToFile, %link% , %A_Desktop%\Mozlet\%barcode%\%barcode%_%index%.jpg
				If ErrorLevel
				{
					UrlDownloadToFile, %link% , %A_Desktop%\Mozlet\%barcode%\%barcode%_%index%.jpg
					If ErrorLevel
					{
						MsgBox,File: %A_Desktop%\Mozlet\%barcode%\%barcode%_%index%.jpg`nLink: %link%
						baocao.Range(element . Row).Interior.ColorIndex := 33
					}
				}
			}
		}
	}
	Row++
}
until barcode =""
baocao.Workbooks.Close()
MsgBox,Done