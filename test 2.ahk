varFolder := "C:\it-support\download\181122_098014_Canifa_89sku\OH_Le Minh Duc_29sku\6TE18W027-SM205"
varBarcode := 6TE18W027-SM205
Loop, Files, %varFolder%\%varBarcode%*.jpg,R
		{
			MsgBox, %A_Loopfilename%
			If ( A_LoopFileSizeKB > 450 )
			{
				
				MsgBox, 4402, File size warning! 1, %A_Loopfilename% qu� dung lu?ng 500kb
				IfMsgBox, Abort
					break
				IfMsgBox, Ignore
				{
					return
				}
				IfMsgBox, Retry
					Run, %varFolder%
			}
			If ( A_LoopFileSizeKB > "450" )
			{
				
				MsgBox, 4402, File size warning! 2, %A_Loopfilename% qu� dung lu?ng 500kb
				IfMsgBox, Abort
					break
				IfMsgBox, Ignore
				{
					return
				}
				IfMsgBox, Retry
					Run, %varFolder%
			}
		}