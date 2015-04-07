;Saves all of the GUI values to the config.

Func saveConfig() ;Saves the controls settings to the config

	;General Settings--------------------------------------------------------------------------
	Local $frmBotPos = WinGetPos($sBotTitle)
	IniWrite($config, "general", "frmBotPosX", $frmBotPos[0])
	IniWrite($config, "general", "frmBotPosY", $frmBotPos[1])

	If GUICtrlRead($chkBackground) = $GUI_CHECKED Then
		IniWrite($config, "general", "Background", 1)
	Else
		IniWrite($config, "general", "Background", 0)
	EndIf

	If GUICtrlRead($chkBotStop) = $GUI_CHECKED Then
		IniWrite($config, "general", "BotStop", 1)
	Else
		IniWrite($config, "general", "BotStop", 0)
	EndIf

	IniWrite($config, "general", "Command", _GUICtrlComboBox_GetCurSel($cmbBotCommand))
	IniWrite($config, "general", "Cond", _GUICtrlComboBox_GetCurSel($cmbBotCond))
	IniWrite($config, "general", "Hour", _GUICtrlComboBox_GetCurSel($cmbHoursStop))

	;Search Settings------------------------------------------------------------------------

	If GUICtrlRead($radDeadBases) = $GUI_CHECKED Then
		IniWrite($config, "search", "mode", 0)
	ElseIf GUICtrlRead($radWeakBases) = $GUI_CHECKED Then
		IniWrite($config, "search", "mode", 1)
	ElseIf GUICtrlRead($radAllBases) = $GUI_CHECKED Then
		IniWrite($config, "search", "mode", 2)
	EndIf

	If GUICtrlRead($chkSearchReduction) = $GUI_CHECKED Then
		IniWrite($config, "search", "reduction", 1)
	Else
		IniWrite($config, "search", "reduction", 0)
	EndIf

	IniWrite($config, "search", "reduceCount", GUICtrlRead($txtSearchReduceCount))
	IniWrite($config, "search", "reduceGold", GUICtrlRead($txtSearchReduceGold))
	IniWrite($config, "search", "reduceElixir", GUICtrlRead($txtSearchReduceElixir))
	IniWrite($config, "search", "reduceDark", GUICtrlRead($txtSearchReduceDark))
	IniWrite($config, "search", "reduceTrophy", GUICtrlRead($txtSearchReduceTrophy))

	If GUICtrlRead($chkMeetGxE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionGoldElixir", 1)
	Else
		IniWrite($config, "search", "conditionGoldElixir", 0)
	EndIf

	If GUICtrlRead($chkMeetGorE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionGoldorElixir", 1)
	Else
		IniWrite($config, "search", "conditionGoldorElixir", 0)
	EndIf

	If GUICtrlRead($chkMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionDark", 1)
	Else
		IniWrite($config, "search", "conditionDark", 0)
	EndIf

	If GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTrophy", 1)
	Else
		IniWrite($config, "search", "conditionTrophy", 0)
	 EndIf

	If GUICtrlRead($chkMeetTH) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTownHall", 1)
	Else
		IniWrite($config, "search", "conditionTownHall", 0)
	 EndIf

	If GUICtrlRead($chkMeetTHO) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionTownHallO", 1)
	Else
		IniWrite($config, "search", "conditionTownHallO", 0)
	 EndIf

	If GUICtrlRead($chkMeetOne) = $GUI_CHECKED Then
		IniWrite($config, "search", "conditionOne", 1)
	Else
		IniWrite($config, "search", "conditionOne", 0)
	 EndIf

	IniWrite($config, "search", "searchGold", GUICtrlRead($txtMinGold))
	IniWrite($config, "search", "searchElixir", GUICtrlRead($txtMinElixir))
	IniWrite($config, "search", "searchDark", GUICtrlRead($txtMinDarkElixir))
	IniWrite($config, "search", "searchTrophy", GUICtrlRead($txtMinTrophy))
	IniWrite($config, "search", "THLevel", _GUICtrlComboBox_GetCurSel($cmbTH))

	If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
		IniWrite($config, "search", "AlertSearch", 1)
	Else
		IniWrite($config, "search", "AlertSearch", 0)
	 EndIf


	;Attack Basic Settings-------------------------------------------------------------------------
	IniWrite($config, "attack", "deploy", _GUICtrlComboBox_GetCurSel($cmbDeploy))
	IniWrite($config, "attack", "composition", _GUICtrlComboBox_GetCurSel($cmbTroopComp))

	IniWrite($config, "attack", "UnitD", _GUICtrlComboBox_GetCurSel($cmbUnitDelay))
	IniWrite($config, "attack", "WaveD", _GUICtrlComboBox_GetCurSel($cmbWaveDelay))
	IniWrite($config, "attack", "randomatk", GUICtrlRead($Randomspeedatk))

	If GUICtrlRead($chkKingAttackDeadBases) = $GUI_CHECKED Then
		IniWrite($config, "attack", "king-dead", 1)
	Else
		IniWrite($config, "attack", "king-dead", 0)
	EndIf
	If GUICtrlRead($chkKingAttackAllBases) = $GUI_CHECKED Then
		IniWrite($config, "attack", "king-all", 1)
	Else
		IniWrite($config, "attack", "king-all", 0)
	EndIf

	If GUICtrlRead($chkQueenAttackDeadBases) = $GUI_CHECKED Then
		IniWrite($config, "attack", "queen-dead", 1)
	Else
		IniWrite($config, "attack", "queen-dead", 0)
	EndIf
	If GUICtrlRead($chkQueenAttackAllBases) = $GUI_CHECKED Then
		IniWrite($config, "attack", "queen-all", 1)
	Else
		IniWrite($config, "attack", "queen-all", 0)
	EndIf

	If GUICtrlRead($chkUseClanCastle) = $GUI_CHECKED Then
		IniWrite($config, "attack", "use-cc", 1)
	Else
		IniWrite($config, "attack", "use-cc", 0)
	EndIf

	If GUICtrlRead($radManAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Manual")
	Elseif GUICtrlRead($radAutoAbilities) = $GUI_CHECKED Then
		IniWrite($config, "attack", "ActivateKQ", "Auto")
	EndIf

	IniWrite($config, "attack", "delayActivateKQ", GUICtrlRead($txtManAbilities))

	IniWrite($config, "attack", "txtTimeStopAtk", GUICtrlRead($txtTimeStopAtk))

	If GUICtrlRead($chkTakeLootSS) = $GUI_CHECKED Then
		IniWrite($config, "attack", "TakeLootSnapShot", 1)
	Else
		IniWrite($config, "attack", "TakeLootSnapShot", 0)
	EndIf

	;Advanced Settings--------------------------------------------------------------------------
	If GUICtrlRead($chkAttackTH) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "townhall", 1)
	Else
		IniWrite($config, "advanced", "townhall", 0)
	EndIf

	If GUICtrlRead($chkBullyMode) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "BullyMode", 1)
	Else
		IniWrite($config, "advanced", "BullyMode", 0)
	EndIf

	IniWrite($config, "advanced", "ATBullyMode", GUICtrlRead($txtATBullyMode))
	IniWrite($config, "advanced", "YourTH", _GUICtrlComboBox_GetCurSel($cmbYourTH))

	If GUICtrlRead($chkTrophyMode) = $GUI_CHECKED Then
		IniWrite($config, "advanced", "TrophyMode", 1)
	Else
		IniWrite($config, "advanced", "TrophyMode", 0)
	EndIf

	IniWrite($config, "advanced", "THaddTiles", GUICtrlRead($txtTHaddtiles))
	IniWrite($config, "advanced", "AttackTHType", _GUICtrlComboBox_GetCurSel($cmbAttackTHType))

	;atk their king
	;attk their queen
	;hit de with lightning spell

	;Donate Settings-------------------------------------------------------------------------
	If GUICtrlRead($chkRequest) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkRequest", 1)
	Else
		IniWrite($config, "donate", "chkRequest", 0)
	EndIf

	IniWrite($config, "donate", "txtRequest", GUICtrlRead($txtRequest))

	If GUICtrlRead($chkDonateBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateBarbarians", 0)
	EndIf

	If GUICtrlRead($chkDonateAllBarbarians) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllBarbarians", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllBarbarians", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateBarbarians", StringReplace(GUICtrlRead($txtDonateBarbarians), @CRLF, "|"))

	If GUICtrlRead($chkDonateArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateArchers", 0)
	EndIf

	If GUICtrlRead($chkDonateAllArchers) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllArchers", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllArchers", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateArchers", StringReplace(GUICtrlRead($txtDonateArchers), @CRLF, "|"))

	If GUICtrlRead($chkDonateGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateGiants", 0)
	EndIf

	If GUICtrlRead($chkDonateAllGiants) = $GUI_CHECKED Then
		IniWrite($config, "donate", "chkDonateAllGiants", 1)
	Else
		IniWrite($config, "donate", "chkDonateAllGiants", 0)
	EndIf

	IniWrite($config, "donate", "txtDonateGiants", StringReplace(GUICtrlRead($txtDonateGiants), @CRLF, "|"))

	;Troop Settings--------------------------------------------------------------------------
	;IniWrite($config, "troop", "capacity", GUICtrlRead($txtCapacity))
	;If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 9 Then
		IniWrite($config, "troop", "barbarian", GUICtrlRead($txtBarbarians))
		IniWrite($config, "troop", "archer", GUICtrlRead($txtArchers))
		IniWrite($config, "troop", "goblin", GUICtrlRead($txtGoblins))
	;EndIf
	IniWrite($config, "troop", "giant", GUICtrlRead($txtNumGiants))
	IniWrite($config, "troop", "WB", GUICtrlRead($txtNumWallbreakers))
	IniWrite($config, "troop", "wizard", GUICtrlRead($txtNumWizards))
	IniWrite($config, "troop", "minion", GUICtrlRead($txtNumMinions))
	IniWrite($config, "troop", "hog", GUICtrlRead($txtNumHogs))
	IniWrite($config, "troop", "troop1", _GUICtrlComboBox_GetCurSel($cmbBarrack1))
	IniWrite($config, "troop", "troop2", _GUICtrlComboBox_GetCurSel($cmbBarrack2))
	IniWrite($config, "troop", "troop3", _GUICtrlComboBox_GetCurSel($cmbBarrack3))
	IniWrite($config, "troop", "troop4", _GUICtrlComboBox_GetCurSel($cmbBarrack4))

	IniWrite($config, "troop", "fulltroop", GUICtrlRead($txtFullTroop))
	;barracks boost not saved (no use)

	;Misc Settings--------------------------------------------------------------------------
	If GUICtrlRead($chkWalls) = $GUI_CHECKED Then
		IniWrite($config, "other", "auto-wall", 1)
	Else
		IniWrite($config, "other", "auto-wall", 0)
	EndIf

	If GUICtrlRead($UseGold) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 0)
	ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 1)
	ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
		IniWrite($config, "other", "use-storage", 2)
	EndIf

	IniWrite($config, "other", "walllvl", _GUICtrlComboBox_GetCurSel($cmbWalls))
	IniWrite($config, "other", "minwallgold", GUICtrlRead($txtWallMinGold))
	IniWrite($config, "other", "minwallelixir", GUICtrlRead($txtWallMinElixir))

	If GUICtrlRead($chkTrap) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkTrap", 1)
	Else
		IniWrite($config, "other", "chkTrap", 0)
	 EndIf
	If GUICtrlRead($chkCollect) = $GUI_CHECKED Then
		IniWrite($config, "other", "chkCollect", 1)
	Else
		IniWrite($config, "other", "chkCollect", 0)
	 EndIf
	IniWrite($config, "other", "txtTimeWakeUp", GUICtrlRead($txtTimeWakeUp))
	IniWrite($config, "other", "VSDelay", GUICtrlRead($sldVSDelay))

	IniWrite($config, "other", "MaxTrophy", GUICtrlRead($txtMaxTrophy))
	IniWrite($config, "other", "MinTrophy", GUICtrlRead($txtdropTrophy))

	IniWrite($config, "other", "xTownHall", $TownHallPos[0])
	IniWrite($config, "other", "yTownHall", $TownHallPos[1])

	IniWrite($config, "other", "xCCPos", $CCPos[0])
	IniWrite($config, "other", "yCCPos", $CCPos[1])

    IniWrite($config, "other", "xArmy", $ArmyPos[0])
    IniWrite($config, "other", "yArmy", $ArmyPos[1])

	;For $i = 0 To 3 ;Covers all 4 Barracks
		IniWrite($config, "other", "xBarrack", $barrackPos[0])
		IniWrite($config, "other", "yBarrack", $barrackPos[1])
	;Next

	If GUICtrlRead($chklighspell) = $GUI_CHECKED Then
		IniWrite($config, "other", "xSpellfactory", $SFPos[0])
		IniWrite($config, "other", "ySpellfactory", $SFPos[1])
	EndIf

EndFunc   ;==>saveConfig
