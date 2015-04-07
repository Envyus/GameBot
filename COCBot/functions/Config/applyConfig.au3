;Applies all of the  variable to the GUI

Func applyConfig() ;Applies the data from config to the controls in GUI

	;General Settings--------------------------------------------------------------------------
	If $frmBotPosX <> -32000 Then WinMove($sBotTitle, "", $frmBotPosX, $frmBotPosY)

	If $ichkBackground = 1 Then
		GUICtrlSetState($chkBackground, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBackground, $GUI_UNCHECKED)
	EndIf
	chkBackground() ;Applies it to hidden button

	If $ichkBotStop = 1 Then
		GUICtrlSetState($chkBotStop, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbBotCommand, $icmbBotCommand)
	_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)
	_GUICtrlComboBox_SetCurSel($cmbHoursStop, $icmbHoursStop)
	cmbBotCond()

	;Search Settings------------------------------------------------------------------------

	Switch $iradAttackMode
		Case 0
			GUICtrlSetState($radDeadBases, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($radWeakBases, $GUI_CHECKED)
		Case 2
			GUICtrlSetState($radAllBases, $GUI_CHECKED)
	EndSwitch

	If $iChkSearchReduction = 1 Then
		GUICtrlSetState($chkSearchReduction, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkSearchReduction, $GUI_UNCHECKED)
	EndIf
	chkSearchReduction()

	GUICtrlSetData($txtSearchReduceCount, $ReduceCount)
	GUICtrlSetData($txtSearchReduceGold, $ReduceGold)
	GUICtrlSetData($txtSearchReduceElixir, $ReduceElixir)
	GUICtrlSetData($txtSearchReduceDark, $ReduceDark)
	GUICtrlSetData($txtSearchReduceTrophy, $ReduceTrophy)

	If $chkConditions[0] = 1 Then
		GUICtrlSetState($chkMeetGxE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGxE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[3] = 1 Then
		GUICtrlSetState($chkMeetGorE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGorE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[1] = 1 Then
		GUICtrlSetState($chkMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetDE, $GUI_UNCHECKED)
	EndIf
	chkMeetDE()

	If $chkConditions[2] = 1 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTrophy, $GUI_UNCHECKED)
	EndIf
	chkMeetTrophy()

	If $chkConditions[4] = 1 Then
		GUICtrlSetState($chkMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTH, $GUI_UNCHECKED)
	EndIf
	chkMeetTH()

	If $chkConditions[5] = 1 Then
		GUICtrlSetState($chkMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTHO, $GUI_UNCHECKED)
	EndIf

   If $ichkMeetOne = 1 Then
		GUICtrlSetState($chkMeetOne, $GUI_CHECKED)
   Else
		GUICtrlSetState($chkMeetOne, $GUI_UNCHECKED)
	 EndIf

	GUICtrlSetData($txtMinGold, $MinGold)
	GUICtrlSetData($txtMinElixir, $MinElixir)
	GUICtrlSetData($txtMinDarkElixir, $MinDark)
	GUICtrlSetData($txtMinTrophy, $MinTrophy)

	For $i = 0 To 4
	   If $icmbTH = $i Then $MaxTH = $THText[$i]
    Next
	_GUICtrlComboBox_SetCurSel($cmbTH, $icmbTH)

	If $AlertSearch = 1 Then
		GUICtrlSetState($chkAlertSearch, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAlertSearch, $GUI_UNCHECKED)
	EndIf

	;Attack Settings-------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbDeploy, $deploySettings)
	_GUICtrlComboBox_SetCurSel($cmbTroopComp, $icmbTroopComp)
	_GUICtrlComboBox_SetCurSel($cmbUnitDelay, $icmbUnitDelay)
	_GUICtrlComboBox_SetCurSel($cmbWaveDelay, $icmbWaveDelay)
	If $iRandomspeedatk = 1 Then
		GUICtrlSetState($Randomspeedatk, $GUI_CHECKED)
	Else
		GUICtrlSetState($Randomspeedatk, $GUI_UNCHECKED)
	EndIf
	Randomspeedatk()

	If $KingAttack[0] = 1 Then
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $KingAttack[2] = 1 Then
		GUICtrlSetState($chkKingAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKingAttackAllBases, $GUI_UNCHECKED)
	EndIf

	If $QueenAttack[0] = 1 Then
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackDeadBases, $GUI_UNCHECKED)
	EndIf
	If $QueenAttack[2] = 1 Then
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkQueenAttackAllBases, $GUI_UNCHECKED)
	EndIf

	If $checkUseClanCastle = 1 Then
		GUICtrlSetState($chkUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseClanCastle, $GUI_UNCHECKED)
	EndIf

	Switch $iActivateKQCondition
		Case "Manual"
			GUICtrlSetState($radManAbilities, $GUI_CHECKED)
		Case "Auto"
			GUICtrlSetState($radAutoAbilities, $GUI_CHECKED)
	EndSwitch

	GUICtrlSetData($txtManAbilities, ($delayActivateKQ / 1000))

	GUICtrlSetData($txtTimeStopAtk, $sTimeStopAtk)

	If $TakeLootSnapShot = 1 Then
		GUICtrlSetState($chkTakeLootSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeLootSS, $GUI_UNCHECKED)
	EndIf

	;Attack Adv. Settings--------------------------------------------------------------------------
	If $chkATH = 1 Then
		GUICtrlSetState($chkAttackTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAttackTH, $GUI_UNCHECKED)
	EndIf

	If $OptBullyMode = 1 Then
		GUICtrlSetState($chkBullyMode, $GUI_CHECKED)
	ElseIf $OptBullyMode = 0 Then
		GUICtrlSetState($chkBullyMode, $GUI_UNCHECKED)
	 EndIf
	GUICtrlSetData($txtATBullyMode, $ATBullyMode)
	_GUICtrlComboBox_SetCurSel($cmbYourTH, $YourTH)
	chkBullyMode()

	If $OptTrophyMode = 1 Then
		GUICtrlSetState($chkTrophyMode, $GUI_CHECKED)
	ElseIf $OptTrophyMode = 0 Then
		GUICtrlSetState($chkTrophyMode, $GUI_UNCHECKED)
	 EndIf

	GUICtrlSetData($txtTHaddTiles, $THaddTiles)
	_GUICtrlComboBox_SetCurSel($cmbAttackTHType, $AttackTHType)

	;attk their king
	;attk their queen
	;hit de with lightning spell

	;Donate Settings-------------------------------------------------------------------------
	If $ichkRequest = 1 Then
		GUICtrlSetState($chkRequest, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRequest, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtRequest, $itxtRequest)
	chkRequest()

	If $ichkDonateBarbarians = 1 Then
		GUICtrlSetState($chkDonateBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
	EndIf
	chkDonateBarbarians()
	GUICtrlSetData($txtDonateBarbarians, $itxtDonateBarbarians)

	If $ichkDonateArchers = 1 Then
		GUICtrlSetState($chkDonateArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
	EndIf
	chkDonateArchers()
	GUICtrlSetData($txtDonateArchers, $itxtDonateArchers)

	If $ichkDonateGiants = 1 Then
		GUICtrlSetState($chkDonateGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)
	EndIf
	chkDonateGiants()
	GUICtrlSetData($txtDonateGiants, $itxtDonateGiants)

	If $ichkDonateAllBarbarians = 1 Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_CHECKED)
		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllArchers = 1 Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_CHECKED)
		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateAllGiants = 1 Then
		GUICtrlSetState($chkDonateAllGiants, $GUI_CHECKED)
		GUICtrlSetState($txtDonateBarbarians, $GUI_DISABLE)
		GUICtrlSetState($txtDonateArchers, $GUI_DISABLE)
		GUICtrlSetState($txtDonateGiants, $GUI_DISABLE)
	Else
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
	EndIf

	;Troop Settings--------------------------------------------------------------------------
	GUICtrlSetData($txtBarbarians, $BarbariansComp)
	GUICtrlSetData($txtArchers, $ArchersComp)
	GUICtrlSetData($txtNumGiants, $GiantsComp)
	GUICtrlSetData($txtGoblins, $GoblinsComp)
	GUICtrlSetData($txtNumWallbreakers, $WBComp)
	GUICtrlSetData($txtNumWizards, $WizardsComp)
	GUICtrlSetData($txtNumMinions, $MinionsComp)
	GUICtrlSetData($txtNumHogs, $HogsComp)
	SetComboTroopComp()
	lblTotalCount()

	_GUICtrlComboBox_SetCurSel($cmbBarrack1, $barrackTroop[0])
	_GUICtrlComboBox_SetCurSel($cmbBarrack2, $barrackTroop[1])
	_GUICtrlComboBox_SetCurSel($cmbBarrack3, $barrackTroop[2])
	_GUICtrlComboBox_SetCurSel($cmbBarrack4, $barrackTroop[3])

	GUICtrlSetData($txtFullTroop, $fulltroop)
	;barracks boost not saved (no use)

	;Other Settings--------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbWalls, $icmbWalls)
	Switch $iUseStorage
		Case 0
			GUICtrlSetState($UseGold, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($UseElixir, $GUI_CHECKED)
		Case 2
			GUICtrlSetState($UseElixirGold, $GUI_CHECKED)
    EndSwitch

	GUICtrlSetData($txtWallMinGold, $itxtWallMinGold)
	GUICtrlSetData($txtWallMinElixir, $itxtWallMinElixir)
	cmbwalls()

	If $ichkWalls = 1 Then
		GUICtrlSetState($chkWalls, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWalls, $GUI_UNCHECKED)
	EndIf
	chkWalls()

	If $ichkTrap = 1 Then
		GUICtrlSetState($chkTrap, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrap, $GUI_UNCHECKED)
	EndIf
	chkTrap()

	If $iChkCollect = 1 Then
		GUICtrlSetState($chkCollect, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkCollect, $GUI_UNCHECKED)
	EndIf

	GUICtrlSetData($txtTimeWakeUp, $sTimeWakeUp)

	GUICtrlSetData($sldVSDelay, $iVSDelay)
	GUICtrlSetData($lblVSDelay, $iVSDelay)

	GUICtrlSetData($txtMaxTrophy, $itxtMaxTrophy)
	GUICtrlSetData($txtdropTrophy, $itxtdropTrophy)

	;location of TH, CC, Army Camp, Barrack and Spell Fact. not Applied, only read

EndFunc   ;==>applyConfig
