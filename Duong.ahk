﻿numpad0::
b := ContainerCount()
MsgBox, %b%
return

ContainerCount()
{
	Loop, 6
	{
		ImageSearch,,yContainerCount%A_Index%,1576, 450 ,1633, 491, PNG\%A_Index%items.png
		If (yContainerCount%A_Index% <> "")
		{
			ContainerCount = %A_Index%
		}
	}
	return ContainerCount
}