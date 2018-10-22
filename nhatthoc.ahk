start:
a := object()
Loop, read, X:\nhatthoc.txt
{
    a[A_Index] := A_LoopReadLine
}


dir := "V:\2.SXMOI\TTKD Thời Trang\me & be\Chụp hình\Năm 2018\00_ Mẹ bé Sau Quy Hoạch\SNG1_Au Chau\180806_SNG1_Au Chau_sku\Quần áo_OH Quynh Anh"
loop, Files, %dir%\*.*,DR
{
    MsgBox, %A_LoopFileName%
    for i in a
        IfInString, A_Loopfilename, a[i]
        {
            MsgBox, %A_Loopfilelongpath%
        }
}