;Checks is your Barrack or no

Func isBarrack()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(218, 294), Hex(0xBBBBBB, 6), 10) Or _ColorCheck(_GetPixelColor(217, 297), Hex(0xF8AD20, 6), 10) Then
		return True
	EndIf
	Return False
EndFunc   ;==>isBarrack

Func isDarkBarrack()
	_CaptureRegion()
	;-----------------------------------------------------------------------------
	If _ColorCheck(_GetPixelColor(639, 456), Hex(0xD7DBC8, 6), 10) Or _ColorCheck(_GetPixelColor(526, 419), Hex(0xC9CCBB, 6), 10) Then
		return True
	EndIf
	Return False
EndFunc   ;==>isDarkBarrack ; gamebot.org