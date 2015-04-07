;Searches for a village that until meets conditions

Func VillageSearch() ;Control for searching a village that meets conditions
	$iSkipped = 0
	$AimGold = $MinGold
	$AimElixir = $MinElixir
	$AimDark = $MinDark
	$AimTrophy = $MinTrophy

	_WinAPI_EmptyWorkingSet(WinGetProcess($Title))

	If _Sleep(1000) Then Return

	_CaptureRegion() ; Check Break Shield button again
	If _ColorCheck(_GetPixelColor(513, 416), Hex(0x5DAC10, 6), 50) Then
		Click(513, 416);Click Okay To Break Shield
	EndIf

	Switch $iradAttackMode
		Case 0
			SetLog(_PadStringCenter(" Searching For Dead Bases ", 54, "="), $COLOR_BLUE)
		Case 1
			SetLog(_PadStringCenter(" Searching For Weak Bases ", 54, "="), $COLOR_BLUE)
		Case 2
			SetLog(_PadStringCenter(" Searching For All Bases ", 54, "="), $COLOR_BLUE)
	EndSwitch

	Local $MeetGxEtext = "", $MeetGorEtext = "", $MeetDEtext = "", $MeetTrophytext = "", $MeetTHtext = "", $icmbTHtext = "", $MeetTHOtext = "", $MeetOnetext = "", $AimTHtext = ""

	SetLog(_PadStringCenter(" SEARCH CONDITIONS ", 50, "~"), $COLOR_BLUE)

	If $chkConditions[0] = 1 Then $MeetGxEtext = "Meet: Gold and Elixir"
	If $chkConditions[3] = 1 Then $MeetGorEtext = "Meet: Gold or Elixir"
	If $chkConditions[1] = 1 Then $MeetDEtext = ", Dark"
	If $chkConditions[2] = 1 Then $MeetTrophytext = ", Trophy"
	If $chkConditions[4] = 1 Then $MeetTHtext = ", Max TH " & $MaxTH ;$icmbTH
	If $chkConditions[5] = 1 Then $MeetTHOtext = ", TH Outside"

	SetLog($MeetGxEtext & $MeetGorEtext & $MeetDEtext & $MeetTrophytext & $MeetTHtext & $MeetTHOtext)

	If $ichkMeetOne = 1 Then SetLog("Meet One and Attack!")

	SetLog(_PadStringCenter(" RESOURCE CONDITIONS ", 50, "~"), $COLOR_BLUE)
	If $chkConditions[4] = 1 Then $AimTHtext = " [TH]:" & StringFormat("%2s", $MaxTH) ;$icmbTH
	If $chkConditions[5] = 1 Then $AimTHtext &= ", Out"

	SetLog("Aim: [G]:" & StringFormat("%7s", $AimGold) & " [E]:" & StringFormat("%7s", $AimElixir) & " [D]:" & StringFormat("%5s", $AimDark) & " [T]:" & StringFormat("%2s", $AimTrophy) & $AimTHtext, $COLOR_BLUE, "Lucida Console", 7.5)

	If $OptBullyMode + $OptTrophyMode + $chkATH > 0 Then
		SetLog(_PadStringCenter(" ADVANCED SETTINGS ", 50, "~"), $COLOR_BLUE)
		Local $YourTHText = "", $AttackTHTypeText = "", $chkATHText = "", $OptTrophyModeText = ""

		If $OptBullyMode = 1 Then
			For $i = 0 To 4
				If $YourTH = $i Then $YourTHText = "TH" & $THText[$i]
			Next
		EndIf

		If $OptBullyMode = 1 Then SETLOG("THBully Combo @" & $ATBullyMode & " SearchCount, " & $YourTHText)

		If $chkATH = 1 Then $chkATHText = "AttackTH"
		If $chkATH = 1 And $AttackTHType = 0 Then $AttackTHTypeText = ", Barch"
		If $chkATH = 1 And $AttackTHType = 1 Then $AttackTHTypeText = ", Attack1:Normal"
		If $chkATH = 1 And $AttackTHType = 2 Then $AttackTHTypeText = ", Attack2:Extreme"
		If $OptTrophyMode = 1 Then $OptTrophyModeText = "THSnipe Combo, " & $THaddtiles & " Tile(s), "
		If $OptTrophyMode = 1 Or $chkATH = 1 Then Setlog($OptTrophyModeText & $chkATHText & $AttackTHTypeText)
	EndIf

	SetLog(_StringRepeat("=", 50), $COLOR_BLUE)

	$SearchCount = 0
	While 1
		If _Sleep(1000 * $iVSDelay) Then Return
		GetResources() ;Reads Resource Values
		If $Restart = True Then Return ; exit func

		If Mod(($iSkipped + 1), 100) = 0 Then
			_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS memory
			If _Sleep(1000) Then Return
			If CheckZoomOut() = False Then Return
		EndIf

		If CompareResources() Then
			If $iradAttackMode = 0 Then
				If checkDeadBase() Then
					SetLog(_PadStringCenter(" Dead Base Found! ", 50, "~"), $COLOR_GREEN)
					ExitLoop
				ElseIf $OptBullyMode = 1 And ($SearchCount >= $ATBullyMode) Then
					If $SearchTHLResult = 1 Then
						SetLog(_PadStringCenter(" Not a Dead Base, but TH Bully Level Found! ", 50, "~"), $COLOR_GREEN)
						ExitLoop
					Else
						If _Sleep(1000) Then ExitLoop (2)
						SetLog(_PadStringCenter(" Not a Dead Base, Not TH Bully Level, Skipping ", 50, "~"), $COLOR_ORANGE)
						Click(750, 500) ;Click Next
						$iSkipped = $iSkipped + 1
						GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
						ContinueLoop
					EndIf
				ElseIf $OptTrophyMode = 1 Then ;Enables Triple Mode Settings
					If SearchTownHallLoc() Then
						SetLog(_PadStringCenter(" Not a Dead Base, but TH Outside Found! ", 50, "~"), $COLOR_GREEN)
						ExitLoop
					Else
						SetLog(_PadStringCenter(" Not a Dead base, Not TH Outside!, Skipping", 50, "~"), $COLOR_ORANGE)
						Click(750, 500) ;Click Next
						$iSkipped = $iSkipped + 1
						GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
						ContinueLoop
					EndIf

				Else
					If _Sleep(1000) Then Return
					SetLog(_PadStringCenter(" Not a Dead Base, Skipping ", 50, "~"), $COLOR_ORANGE)
					Click(750, 500) ;Click Next
					$iSkipped = $iSkipped + 1
					GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
					ContinueLoop
				EndIf
			Else
				ExitLoop ; attack Allbase
			EndIf
		ElseIf $OptTrophyMode = 1 Then ;Enables Triple Mode Settings ;---compare resources
			If SearchTownHallLoc() Then ; attack this base anyway because outside TH found to snipe
				SetLog(_PadStringCenter(" TH Outside Found! ", 50, "~"), $COLOR_GREEN)
				ExitLoop
			Else
				Click(750, 500) ;Click Next
				$iSkipped = $iSkipped + 1
				GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
				ContinueLoop
			EndIf
		Else
			If _Sleep(1000) Then Return
			Click(750, 500) ;Click Next
			$iSkipped = $iSkipped + 1
			GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
			ContinueLoop
		EndIf
	WEnd

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		TrayTip("Match Found!", "Gold: " & $searchGold & "; Elixir: " & $searchElixir & "; Dark: " & $searchDark & "; Trophy: " & $searchTrophy, "", 0)
		If FileExists(@WindowsDir & "\media\Festival\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		ElseIf FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
			SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		EndIf
	EndIf

	SetLog(_PadStringCenter(" Search Complete ", 50, "="), $COLOR_BLUE)

	; TH Detection Check Once Conditions
	If $OptBullyMode = 0 And $OptTrophyMode = 0 And $chkConditions[4] = 0 And $chkConditions[5] = 0 And $chkATH = 1 Then
		$searchTH = checkTownhallADV()
		If SearchTownHallLoc() = False And $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is inside, skip Attack TH")
		ElseIf $searchTH <> "-" Then
			SetLog("Checking Townhall location: TH is outside, Attacking Townhall!")
		Else
			SetLog("Checking Townhall location: Could not locate TH, skipping attack TH...")
		EndIf
	EndIf

;~	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; reduce BS Memory

;~	readConfig()
	_BlockInputEx(0, "", "", $HWnD) ; block all keyboard keys

EndFunc   ;==>VillageSearch
