;Clickes the collector locations

Func Collect()
	If $iChkCollect = 0 Then Return

	Local $collx, $colly, $i = 0

	SetLog("Collecting Resources", $COLOR_BLUE)
	If _Sleep(250) Then Return

	Click(1, 1) ;Click Away

	While 1
		If _Sleep(300) Or $RunState = False Then ExitLoop
		_CaptureRegion(0,0,780)
		If _ImageSearch(@ScriptDir & "\images\collect.png", 1, $collx, $colly, 20) Then
			Click($collx, $colly) ;Click collector
		Elseif $i >= 20 Then
			ExitLoop
		EndIf
		$i += 1
		Click(1, 1) ;Click Away
	WEnd
EndFunc   ;==>Collect