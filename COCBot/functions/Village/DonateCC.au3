;Donates troops

Func DonateCC($Check = False)
	Global $Donate = $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Or $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1
	If $Donate = False Then Return
	Local $y = 119
	;check for new chats first
	IF $Check = True Then
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(34, 321), Hex(0xE00300, 6), 20) = False And $CommandStop <> 3 Then
			Return ;exit if no new chats
		EndIf
	EndIf


	 Click(1, 1) ;Click Away
	 _CaptureRegion()
	 If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	 If _Sleep(200) Then Return
	 Click(189, 24) ; clicking clan tab

	While $Donate
		 If _Sleep(250) Then ExitLoop
		 Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
		 Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		 If IsArray($DonatePixel) Then
			 $Donate = False
			 If ($ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1) Then
				 _CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
				 Local $String = getString($DonatePixel[1] - 31)
				 If $String = "" Or $String = " " Or $String = "  " Then
					 $String = getString($DonatePixel[1] - 17)
				 Else
					 $String &= @CRLF & getString($DonatePixel[1] - 17)
				 EndIf

				 SetLog("Chat Request: " & $String)

				 If $ichkDonateBarbarians = 1 Then
					 Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
					 For $i = 0 To UBound($Barbs) - 1
						 If CheckDonate($Barbs[$i], $String) Then
							 DonateBarbs()
							 ExitLoop
						 EndIf
					  Next
					 If $Donate Then
						 $y = $DonatePixel[1] + 10
						 ContinueLoop
					 EndIf
				 EndIf
				 If $ichkDonateArchers = 1 Then
					 Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
					 For $i = 0 To UBound($Archers) - 1
						 If CheckDonate($Archers[$i], $String) Then
							 DonateArchers()
							 ExitLoop
						 EndIf
					 Next
					 If $Donate Then
						 $y = $DonatePixel[1] + 10
						 ContinueLoop
					 EndIf
				 EndIf
				 If $ichkDonateGiants = 1 Then
					 Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
					 For $i = 0 To UBound($Giants) - 1
						 If CheckDonate($Giants[$i], $String) Then
							 DonateGiants()
							 ExitLoop
						 EndIf
					 Next
					 If $Donate Then
						 $y = $DonatePixel[1] + 10
						 ContinueLoop
					 EndIf
				 EndIf
			  EndIf
			  If ($ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1) Then
				 Select
					 Case $ichkDonateAllBarbarians = 1
						 DonateBarbs()
					 Case $ichkDonateAllArchers = 1
						 DonateArchers()
					 Case $ichkDonateAllGiants = 1
						 DonateGiants()
				 EndSelect
			  EndIf
			$Donate = True
			$y = $DonatePixel[1] + 10
			Click(1, 1)
			If _Sleep(250) Then ExitLoop
		 EndIf
		 $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		 If IsArray($DonatePixel) Then ContinueLoop

		 Local $Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
		 $Donate = True
		 If IsArray($Scroll) Then
			Click($Scroll[0], $Scroll[1])
			$y = 119
			If _Sleep(250) Then ExitLoop
			ContinueLoop
		 EndIf
		 $Donate = False
	WEnd

	If _Sleep(300) Then Return
	;SetLog("Finished Donating", $COLOR_GREEN)
	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
	    If _Sleep(250) Then Return
	EndIf
EndFunc   ;==>DonateCC

Func CheckDonate($string, $clanString) ;Checks if it exact
	$Contains = StringMid($string, 1, 1) & StringMid($string, StringLen($string), 1)
	If $Contains = "[]" Then
		If $clanString = StringMid($string, 2, StringLen($string) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($clanString, $string, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc

Func DonateBarbs()
	If $ichkDonateBarbarians = 1 Or $ichkDonateAllBarbarians = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(237, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Or _ColorCheck(_GetPixelColor(237, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Barbarians", $COLOR_GREEN)
			If _Sleep(250) Then Return
			Click(237, $DonatePixel[1] - 5, 5, 50)
			$CurBarb += 5
			$ArmyComp -= 5
			$Donate = True
		ElseIf $ichkDonateAllArchers = 1 Then
			DonateArchers()
			Return
		Else
			SetLog("No Barbarians available to donate..", $COLOR_RED)
			Return
		EndIf
		If _Sleep(250) Then Return
		Click(1, 1)
		If _Sleep(250) Then Return
	Else
		DonateArchers()
		Return
	EndIf
EndFunc   ;==>DonateBarbs

Func DonateArchers()
	If $ichkDonateArchers = 1 Or $ichkDonateAllArchers = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(315, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Or _ColorCheck(_GetPixelColor(315, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then
			SetLog("Donating Archers", $COLOR_GREEN)
			If _Sleep(250) Then Return
			Click(315, $DonatePixel[1] - 5, 5, 50)
			$CurArch += 5
			$ArmyComp -= 5
			$Donate = True
		ElseIf $ichkDonateAllGiants = 1 Then
			DonateGiants()
			Return
		Else
			SetLog("No Archers available to donate..", $COLOR_RED)
			Return
		EndIf
		If _Sleep(250) Then Return
		Click(1, 1)
		If _Sleep(250) Then Return
	Else
		DonateGiants()
		Return
	EndIf
EndFunc   ;==>DonateArchers

Func DonateGiants()
	If $ichkDonateGiants = 1 Or $ichkDonateAllGiants = 1 Then
		Click($DonatePixel[0], $DonatePixel[1] + 11)
		If _Sleep(1000) Then Return
		_CaptureRegion(0, 0, 517, $DonatePixel[1] + 50)
		If _ColorCheck(_GetPixelColor(397, $DonatePixel[1] - 5), Hex(0x507C00, 6), 10) Or _ColorCheck(_GetPixelColor(480, $DonatePixel[1] - 10), Hex(0x507C00, 6), 10) Then  ; quick fix by promac from gamebot.org
			SetLog("Donating Giants", $COLOR_GREEN)
			If _Sleep(250) = True Then Return
			Click(397, $DonatePixel[1] - 5, 5, 50)
			$CurGiant += 5
			$ArmyComp -= 25
			$Donate = True
		Else
			SetLog("No Giants available to donate..", $COLOR_RED)
		EndIf
		If _Sleep(250) Then Return
		Click(1, 1)
		If _Sleep(250) Then Return
	Else
		SetLog("No troops available to donate..", $COLOR_RED)
		If _Sleep(250) Then Return
	EndIf
EndFunc   ;==>DonateGiants
