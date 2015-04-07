Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)

_GDIPlus_Startup()

Func GUIControl($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam
	Switch $iMsg
		Case 273
			Switch $nID
				Case $GUI_EVENT_CLOSE
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
			    Case $labelGameBotURL
					 ShellExecute("https://www.GameBot.org") ;open web site when clicking label
			    Case $labelClashGameBotURL
					 ShellExecute("https://www.ClashGameBot.com") ;open web site when clicking label
			    Case $labelForumURL
			         ShellExecute("https://GameBot.org/forumdisplay.php?fid=2") ;open web site when clicking label
				Case $btnStop
					If $RunState Then btnStop()
 				Case $btnPause
 					If $RunState Then btnPause()
				Case $btnResume
					If $RunState Then btnResume()
				Case $btnHide
					If $RunState Then btnHide()
			EndSwitch
		Case 274
			Switch $wParam
				Case 0xf060
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($txtLog)
					SaveConfig()
					Exit
			EndSwitch
		 EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl

Func SetTime()
    Local $time = _TicksToTime(Int(TimerDiff($sTimer)), $hour, $min, $sec)
	If _GUICtrlTab_GetCurSel($tabMain) = 7 Then GUICtrlSetData($lblresultruntime, StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
EndFunc   ;==>SetTime

Func btnStart()
	CreateLogFile()

	SaveConfig()
	readConfig()
	applyConfig()

	_GUICtrlEdit_SetText($txtLog, "")

	If WinExists($Title) Then
		DisableBS($HWnD, $SC_MINIMIZE)
		DisableBS($HWnD, $SC_CLOSE)
		If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
			Local $BSsize = [ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[2], ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")[3]]
			If $BSsize[0] <> 860 Or $BSsize[1] <> 720 Then
				SetLog("BlueStacks resolution is not set to 860x720!", $COLOR_RED)
				sleep(1000)
				SetLog("We will now automatically resize for you", $COLOR_RED)
				SetLog("Please Wait...", $COLOR_RED)

	If Not FileExists(@ScriptDir & "\860x720.reg") Then
		$Resize = InetGet("http://tinyurl.com/l9tnh8b", @ScriptDir & "\860x720.reg")
		InetClose($Resize)
		Sleep(4000)

		Run('Regedit.exe /s "' & @ScriptDir & '\860x720.reg"')
				SetLog("Resize complete", $COLOR_BLUE)
				SetLog("Close BlueStacks then press Start Bot", $COLOR_BLUE)
				sleep(10000)
				FileDelete(@ScriptDir & "\860x720.reg")
				EndIf
				Else
	WinActivate($Title)

	SetLog("~~~~Welcome to " & $sBotTitle & "!~~~~", $COLOR_PURPLE)
;				Global $Source = StringMid(_INetGetSource(StringFromASCIIArray($G)), 504, 1)
;				If Not($Source = StringFromASCIIArray($eThing)) Then SetLog(StringMid(_INetGetSource(StringFromASCIIArray($G)), 35148, 500), $COLOR_PURPLE)
				;SetLog($Compiled & " running on " & @OSArch & " OS")
				SetLog($Compiled & " running on " & @OSVersion & " " & @OSServicePack & " " & @OSArch)
				SetLog("Bot is starting...", $COLOR_GREEN)

				$RunState = True
				For $i = $FirstControlToHide To $LastControlToHide ; Save state of all controls on tabs
					If $i = $tabGeneral or $i = $tabSearch or $i = $tabAttack or $i = $tabAttackAdv or $i = $tabDonate or $i = $tabTroops or $i = $tabMisc then $i += 1 ; exclude tabs
					$iPrevState[$i] = GUICtrlGetState($i)
				Next
				For $i = $FirstControlToHide To $LastControlToHide ; Disable all controls in 1 go on all tabs
					If $i = $tabGeneral or $i = $tabSearch or $i = $tabAttack or $i = $tabAttackAdv or $i = $tabDonate or $i = $tabTroops or $i = $tabMisc then $i += 1 ; exclude tabs
					GUICtrlSetState($i, $GUI_DISABLE)
				Next

				GUICtrlSetState($chkBackground, $GUI_DISABLE)
				GUICtrlSetState($btnStart, $GUI_HIDE)
				GUICtrlSetState($btnStop, $GUI_SHOW)
 				GUICtrlSetState($btnPause, $GUI_SHOW)
				GUICtrlSetState($btnResume, $GUI_HIDE)

			    $sTimer = TimerInit()
			    AdlibRegister("SetTime", 1000)
				runBot()
		EndIf
		Else
		SetLog("Please Launch The Game", $COLOR_RED)
		EndIf
		Else
		SetLog("Please Launch BlueStacks", $COLOR_RED)

		EndIf
EndFunc   ;==>btnStart

	Func btnStop()
	If $RunState Then
		$RunState = False
		;$FirstStart = true
		EnableBS($HWnD, $SC_MINIMIZE)
		EnableBS($HWnD, $SC_CLOSE)
		For $i = $FirstControlToHide To $LastControlToHide ; Restore previous state of controls
			If $i = $tabGeneral or $i = $tabSearch or $i = $tabAttack or $i = $tabAttackAdv or $i = $tabDonate or $i = $tabTroops or $i = $tabMisc then $i += 1 ; exclude tabs
			GUICtrlSetState($i, $iPrevState[$i])
		Next

		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)
 		GUICtrlSetState($btnPause, $GUI_HIDE)
		GUICtrlSetState($btnResume, $GUI_HIDE)

		AdlibUnRegister("SetTime")
		_BlockInputEx(0, "", "", $HWnD)

		FileClose($hLogFileHandle)
		SetLog("Bot has stopped", $COLOR_ORANGE)
	EndIf
EndFunc   ;==>btnStop

	Func btnPause()
	Send ("{PAUSE}")
	EndFunc

	Func btnResume()
	Send ("{PAUSE}")
	EndFunc

Func Check()
	If IsArray(ControlGetPos($Title, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
	btnStart()
 Else
	Sleep(500)
	Check()
	EndIf
EndFunc

Func btnLocateBarracks()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateBarracks

Func btnLocateArmyCamp()
	$RunState = True
	While 1
		ZoomOut()
		LocateBarrack(True)
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateArmyCamp

Func btnLocateClanCastle()
	$RunState = True
	While 1
		ZoomOut()
		LocateClanCastle()
		ExitLoop
	WEnd
	$RunState = False
 EndFunc   ;==>btnLocateClanCastle

 Func btnLocateSpellfactory()
	$RunState = True
	While 1
		ZoomOut()
		LocateSpellFactory()
		ExitLoop
	WEnd
	$RunState = False
 EndFunc		;==>btnLocateSpellFactory

Func btnLocateTownHall()
	$RunState = True
	While 1
		ZoomOut()
		LocateTownHall()
		ExitLoop
	WEnd
	$RunState = False
EndFunc   ;==>btnLocateTownHall

Func btnSearchMode()
	While 1
		GUICtrlSetState($btnStart, $GUI_HIDE)
		GUICtrlSetState($btnStop, $GUI_SHOW)

		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnSearchMode, $GUI_DISABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_DISABLE)
		GUICtrlSetState($chkBackground, $GUI_DISABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_DISABLE)

		$RunState = True
			PrepareSearch()
			If _Sleep(1000) Then Return
			VillageSearch()
		$RunState = False

		GUICtrlSetState($btnStart, $GUI_SHOW)
		GUICtrlSetState($btnStop, $GUI_HIDE)

		GUICtrlSetState($btnLocateBarracks, $GUI_ENABLE)
		GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
		GUICtrlSetState($cmbTroopComp, $GUI_ENABLE)
		GUICtrlSetState($chkBackground, $GUI_ENABLE)
		;GUICtrlSetState($btnLocateCollectors, $GUI_ENABLE)
		ExitLoop
	WEnd
EndFunc   ;==>btnSearchMode

Func btnHide()
	If $Hide = False Then
		GUICtrlSetData($btnHide, "Show BS")
		$botPos[0] = WinGetPos($Title)[0]
		$botPos[1] = WinGetPos($Title)[1]
		WinMove($Title, "", -32000, -32000)
		$Hide = True
	Else
		GUICtrlSetData($btnHide, "Hide BS")

		If $botPos[0] = -32000 Then
			WinMove($Title, "", 0, 0)
		Else
			WinMove($Title, "", $botPos[0], $botPos[1])
			WinActivate($Title)
		EndIf
		$Hide = False
	EndIf
EndFunc   ;==>btnHide

Func cmbTroopComp()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> $icmbTroopComp Then
		$icmbTroopComp = _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		$ArmyComp = 0
		$CurArch = 1
		$CurBarb = 1
		$CurGoblin = 1
		$CurGiant = 1
		$CurWizard = 1
		$CurWB = 1
		SetComboTroopComp()
	EndIf
EndFunc   ;==>cmbTroopComp

Func SetComboTroopComp()
	Switch _GUICtrlComboBox_GetCurSel($cmbTroopComp)
		Case 0
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "100")
			GUICtrlSetData($txtGoblins, "0")

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 1
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "100")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 2
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "0")
			GUICtrlSetData($txtArchers, "0")
			GUICtrlSetData($txtGoblins, "100")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 3
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "50")
			GUICtrlSetData($txtArchers, "50")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 4
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, False)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 5
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, False)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "50")
			GUICtrlSetData($txtArchers, "50")
			GUICtrlSetData($txtGoblins, "0")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 6
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, True)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, True)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, True)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, "0")
			GUICtrlSetData($txtNumWallbreakers, "0")
			GUICtrlSetData($txtNumWizards, "0")
			GUICtrlSetData($txtNumMinions, "0")
			GUICtrlSetData($txtNumHogs, "0")
		Case 7
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, True)
			_GUICtrlEdit_SetReadOnly($txtArchers, True)
			_GUICtrlEdit_SetReadOnly($txtGoblins, True)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, False)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, False)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, False)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, True)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, True)

			GUICtrlSetData($txtBarbarians, "60")
			GUICtrlSetData($txtArchers, "30")
			GUICtrlSetData($txtGoblins, "10")

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)
			GUICtrlSetData($txtNumWizards, $WizardsComp)
			GUICtrlSetData($txtNumMinions, $MinionsComp)
			GUICtrlSetData($txtNumHogs, $HogsComp)
		Case 8
			GUICtrlSetState($cmbBarrack1, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_ENABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_ENABLE)
			;GUICtrlSetState($txtCapacity, $GUI_DISABLE)
			GUICtrlSetState($txtBarbarians, $GUI_DISABLE)
			GUICtrlSetState($txtArchers, $GUI_DISABLE)
			GUICtrlSetState($txtGoblins, $GUI_DISABLE)
			GUICtrlSetState($txtNumGiants, $GUI_DISABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_DISABLE)
			GUICtrlSetState($txtNumWizards, $GUI_DISABLE)
			GUICtrlSetState($txtNumMinions, $GUI_DISABLE)
			GUICtrlSetState($txtNumHogs, $GUI_DISABLE)
		Case 9
			GUICtrlSetState($cmbBarrack1, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack2, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack3, $GUI_DISABLE)
			GUICtrlSetState($cmbBarrack4, $GUI_DISABLE)
			;GUICtrlSetState($txtCapacity, $GUI_ENABLE)
			GUICtrlSetState($txtBarbarians, $GUI_ENABLE)
			GUICtrlSetState($txtArchers, $GUI_ENABLE)
			GUICtrlSetState($txtGoblins, $GUI_ENABLE)
			GUICtrlSetState($txtNumGiants, $GUI_ENABLE)
			GUICtrlSetState($txtNumWallbreakers, $GUI_ENABLE)
			GUICtrlSetState($txtNumWizards, $GUI_ENABLE)
			GUICtrlSetState($txtNumMinions, $GUI_ENABLE)
			GUICtrlSetState($txtNumHogs, $GUI_ENABLE)

			_GUICtrlEdit_SetReadOnly($txtBarbarians, False)
			_GUICtrlEdit_SetReadOnly($txtArchers, False)
			_GUICtrlEdit_SetReadOnly($txtGoblins, False)
			_GUICtrlEdit_SetReadOnly($txtNumGiants, False)
			_GUICtrlEdit_SetReadOnly($txtNumWallbreakers, False)
			_GUICtrlEdit_SetReadOnly($txtNumWizards, False)
			_GUICtrlEdit_SetReadOnly($txtNumMinions, False)
			_GUICtrlEdit_SetReadOnly($txtNumHogs, False)

			GUICtrlSetData($txtBarbarians, $BarbariansComp)
			GUICtrlSetData($txtArchers, $ArchersComp)
			GUICtrlSetData($txtGoblins, $GoblinsComp)

			GUICtrlSetData($txtNumGiants, $GiantsComp)
			GUICtrlSetData($txtNumWallbreakers, $WBComp)
			GUICtrlSetData($txtNumWizards, $WizardsComp)
			GUICtrlSetData($txtNumMinions, $MinionsComp)
			GUICtrlSetData($txtNumHogs, $HogsComp)
	EndSwitch
	lblTotalCount()
EndFunc   ;==>SetComboTroopComp

Func cmbBotCond()
   If _GUICtrlComboBox_GetCurSel($cmbBotCond) = 13 Then
	  If _GUICtrlComboBox_GetCurSel($cmbHoursStop) = 0 Then _GUICtrlComboBox_SetCurSel($cmbHoursStop, 1)
	  GUICtrlSetState($cmbHoursStop, $GUI_ENABLE)
   Else
	  _GUICtrlComboBox_SetCurSel($cmbHoursStop, 0)
	  GUICtrlSetState($cmbHoursStop, $GUI_DISABLE)
   EndIf
EndFunc	  ;==>cmbBotCond

Func Randomspeedatk()
   If GUICtrlRead($Randomspeedatk) = $GUI_CHECKED Then
	  $iRandomspeedatk = 1
	  GUICtrlSetState($cmbUnitDelay, $GUI_DISABLE)
	  GUICtrlSetState($cmbWaveDelay, $GUI_DISABLE)
   Else
	  $iRandomspeedatk = 0
	  GUICtrlSetState($cmbUnitDelay, $GUI_ENABLE)
	  GUICtrlSetState($cmbWaveDelay, $GUI_ENABLE)
   EndIf
EndFunc   ;==>Randomspeedatk

Func chkSearchReduction()
	If GUICtrlRead($chkSearchReduction) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtSearchReduceCount, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGold, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceElixir, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceDark, False)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceTrophy, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtSearchReduceCount, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceGold, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceElixir, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceDark, True)
		_GUICtrlEdit_SetReadOnly($txtSearchReduceTrophy, True)
	EndIf
EndFunc

Func chkMeetDE()
	If GUICtrlRead($chkMeetDE) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtMinDarkElixir, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtMinDarkElixir, True)
	EndIf
EndFunc

Func chkMeetTrophy()
	If GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Then
		_GUICtrlEdit_SetReadOnly($txtMinTrophy, False)
	Else
		_GUICtrlEdit_SetReadOnly($txtMinTrophy, True)
	EndIf
EndFunc

Func chkMeetTH()
	If GUICtrlRead($chkMeetTH) = $GUI_CHECKED Then
		GUICtrlSetState($cmbTH, $GUI_ENABLE)
	Else
		GUICtrlSetState($cmbTH, $GUI_DISABLE)
	EndIf
EndFunc

Func chkBackground()
	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		$ichkBackground = 1
		GUICtrlSetState($btnHide, $GUI_ENABLE)
	Else
		$ichkBackground = 0
		GUICtrlSetState($btnHide, $GUI_DISABLE)
	EndIf
EndFunc   ;==>chkBackground


Func chkBullyMode()
	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		$OptBullyMode = 1
		GUICtrlSetState($txtATBullyMode, $GUI_ENABLE)
		GUICtrlSetState($cmbYourTH, $GUI_ENABLE)
	Else
		$OptBullyMode = 0
		GUICtrlSetState($txtATBullyMode, $GUI_DISABLE)
		GUICtrlSetState($cmbYourTH, $GUI_DISABLE)
	EndIf
EndFunc

Func chkSnipeMode()
		If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		$OptBullyMode = 1
		GUICtrlSetState($txtTHaddtiles, $GUI_ENABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_ENABLE)
	Else
		$OptBullyMode = 0
		GUICtrlSetState($txtTHaddtiles, $GUI_DISABLE)
		GUICtrlSetState($cmbAttackTHType, $GUI_DISABLE)
	EndIf
EndFunc

Func chkRequest()
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		$ichkRequest = 1
		GUICtrlSetState($txtRequest, $GUI_ENABLE)
	Else
		$ichkRequest = 0
		GUICtrlSetState($txtRequest, $GUI_DISABLE)
	EndIf
EndFunc

Func lblTotalCount()
	GUICtrlSetData($lblTotalCount, GUICtrlRead($txtBarbarians) + GUICtrlRead($txtArchers) + GUICtrlRead($txtGoblins))
	IF GUICtrlRead($lblTotalCount) = "100" Then
		GUICtrlSetBkColor ($lblTotalCount, $COLOR_MONEYGREEN)
	ElseIf GUICtrlRead($lblTotalCount) = "0" Then
		GUICtrlSetBkColor ($lblTotalCount, $COLOR_ORANGE)
	Else
		GUICtrlSetBkColor ($lblTotalCount, $COLOR_RED)
	EndIf
EndFunc

Func chkDonateAllBarbarians()
	IF GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkDonateAllArchers()
	IF GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkDonateAllGiants()
	IF GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkDonateBarbarians()
	IF GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkDonateArchers()
	IF GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkDonateGiants()
	IF GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)

		GUICtrlSetState($txtDonateBarbarians, $GUI_ENABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_ENABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_ENABLE)
	EndIf
EndFunc

Func chkWalls()
	IF GUICtrlRead($chkWalls) = $GUI_CHECKED Then
		GUICtrlSetState($UseGold, $GUI_ENABLE)
;		GUICtrlSetState($UseElixir, $GUI_ENABLE)
;		GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
		GUICtrlSetState($cmbWalls, $GUI_ENABLE)
		GUICtrlSetState($txtWallMinGold, $GUI_ENABLE)
;		GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		cmbWalls()
	Else
		GUICtrlSetState($UseGold, $GUI_DISABLE)
		GUICtrlSetState($UseElixir, $GUI_DISABLE)
		GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		GUICtrlSetState($cmbWalls, $GUI_DISABLE)
		GUICtrlSetState($txtWallMinGold, $GUI_DISABLE)
		GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
	EndIf
EndFunc

Func cmbWalls()
	Switch _GUICtrlComboBox_GetCurSel($cmbWalls)
		Case 0
			$WallCost = 30000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		  GUICtrlSetState($UseElixir, $GUI_DISABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 1
			$WallCost = 75000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		  GUICtrlSetState($UseElixir, $GUI_DISABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 2
			$WallCost = 200000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		  GUICtrlSetState($UseElixir, $GUI_DISABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 3
			$WallCost = 500000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		  GUICtrlSetState($UseElixir, $GUI_DISABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_DISABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_DISABLE)
		Case 4
			$WallCost = 1000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
		  GUICtrlSetState($UseElixir, $GUI_ENABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		Case 5
			$WallCost = 3000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
		  GUICtrlSetState($UseElixir, $GUI_ENABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
		Case 6
			$WallCost = 4000000
			GUICtrlSetData($lblWallCost, StringRegExpReplace($WallCost, "(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))", "\1 "))
		  GUICtrlSetState($UseElixir, $GUI_ENABLE)
		  GUICtrlSetState($UseElixirGold, $GUI_ENABLE)
		  GUICtrlSetState($txtWallMinElixir, $GUI_ENABLE)
	EndSwitch
EndFunc

Func chkTrap()
	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		$ichkTrap = 1
		GUICtrlSetState($btnLocateTownHall, $GUI_ENABLE)
	Else
		$ichkTrap = 0
		GUICtrlSetState($btnLocateTownHall, $GUI_DISABLE)
	EndIf
EndFunc

Func sldVSDelay()
	$iVSDelay = GUICtrlRead($sldVSDelay)
	GUICtrlSetData($lblVSDelay, $iVSDelay)

	If $iVSDelay = 1 Then
		GUICtrlSetData($lbltxtVSDelay, "second")
	Else
		GUICtrlSetData($lbltxtVSDelay, "seconds")
	EndIf
EndFunc

Func tabMain()
	If _GUICtrlTab_GetCurSel($tabMain) = 0 Then
		ControlShow("", "", $txtLog)
		ControlShow("", "", $grpControls)
		For $i = $chkBotStop To $cmbHoursStop
			ControlShow("", "", $i)
		Next
	Else
		ControlHide("", "", $txtLog)
		ControlHide("", "", $grpControls)
		For $i = $chkBotStop To $cmbHoursStop
			ControlHide("", "", $i)
		Next
	EndIf
EndFunc ;==>tabMain

Func DisableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 0)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>DisableBS

Func EnableBS($HWnD, $iButton)
	ConsoleWrite('+ Window Handle: ' & $HWnD & @CRLF)
	$hSysMenu = _GUICtrlMenu_GetSystemMenu($HWnD, 1)
	_GUICtrlMenu_RemoveMenu($hSysMenu, $iButton, False)
	_GUICtrlMenu_DrawMenuBar($HWnD)
EndFunc   ;==>EnableBS

;---------------------------------------------------
If FileExists($config) Then
	readConfig()
	applyConfig()
EndIf

GUIRegisterMsg($WM_COMMAND, "GUIControl")
GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")
;---------------------------------------------------
