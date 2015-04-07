;Tries to zoom out of the screen until the borders, located at the top of the game (usually black), is located.
;Only does it for 20 zoom outs, no more than that.

Func ZoomOut() ;Zooms out
	Local $i = 0
	While 1
		_CaptureRegion(0, 0, 860, 2)
		If _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6) Then SetLog("Zooming Out", $COLOR_BLUE)
		While _GetPixelColor(1, 1) <> Hex(0x000000, 6) And _GetPixelColor(850, 1) <> Hex(0x000000, 6)
			If _Sleep(600) Then Return
			If ControlSend($Title, "", "", "{DOWN}") Then $i += 1
			If $i = 40 Then
				ExitLoop
			EndIf
			_CaptureRegion(0, 0, 860, 2)
		 WEnd
		ExitLoop
	WEnd
EndFunc   ;==>ZoomOut