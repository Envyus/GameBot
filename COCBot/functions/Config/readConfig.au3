;Reads config file and sets variables

Func readConfig() ;Reads config and sets it to the variables
	If FileExists($config) Then

		;General Settings--------------------------------------------------------------------------
		$frmBotPosX = IniRead($config, "general", "frmBotPosX", "900")
		$frmBotPosY = IniRead($config, "general", "frmBotPosY", "20")

		$ichkBackground = IniRead($config, "general", "Background", "0")
		$ichkBotStop = IniRead($config, "general", "BotStop", "0")
		$icmbBotCommand = IniRead($config, "general", "Command", "0")
		$icmbBotCond = IniRead($config, "general", "Cond", "0")
		$icmbHoursStop = IniRead($config, "general", "Hour", "0")

		;Search Settings------------------------------------------------------------------------
		$iradAttackMode = IniRead($config, "search", "mode", "0")

		$iChkSearchReduction = IniRead($config, "search", "reduction", "1")
		$ReduceCount = IniRead($config, "search", "reduceCount", "20")
		$ReduceGold = IniRead($config, "search", "reduceGold", "2000")
		$ReduceElixir = IniRead($config, "search", "reduceElixir", "2000")
		$ReduceDark = IniRead($config, "search", "reduceDark", "100")
		$ReduceTrophy = IniRead($config, "search", "reduceTrophy", "2")

		$chkConditions[0] = IniRead($config, "search", "conditionGoldElixir", "0")
		$chkConditions[3] = IniRead($config, "search", "conditionGoldorElixir", "0")
		$chkConditions[1] = IniRead($config, "search", "conditionDark", "0")
		$chkConditions[2] = IniRead($config, "search", "conditionTrophy", "0")
		$chkConditions[4] = IniRead($config, "search", "conditionTownHall", "0")
		$chkConditions[5] = IniRead($config, "search", "conditionTownHallO", "0")
		$ichkMeetOne = IniRead($config, "search", "conditionOne", "0")

		$MinGold = IniRead($config, "search", "searchGold", "80000")
		$MinElixir = IniRead($config, "search", "searchElixir", "80000")
		$MinDark = IniRead($config, "search", "searchDark", "0")
		$MinTrophy = IniRead($config, "search", "searchTrophy", "0")
		$icmbTH = IniRead($config, "search", "THLevel", "0")

		$AlertSearch = IniRead($config, "search", "AlertSearch", "0")

		;Attack Basics Settings-------------------------------------------------------------------------
		$deploySettings = IniRead($config, "attack", "deploy", "3")
		$icmbTroopComp = IniRead($config, "attack", "composition", "0")
	    $icmbUnitDelay = IniRead($config, "attack", "UnitD", "0")
	    $icmbWaveDelay = IniRead($config, "attack", "WaveD", "0")
	    $iRandomspeedatk = IniRead($config, "attack", "randomatk", "0")

		$KingAttack[0] = IniRead($config, "attack", "king-dead", "0")
		$KingAttack[2] = IniRead($config, "attack", "king-all", "0")

		$QueenAttack[0] = IniRead($config, "attack", "queen-dead", "0")
		$QueenAttack[2] = IniRead($config, "attack", "queen-all", "0")

		$checkUseClanCastle = IniRead($config, "attack", "use-cc", "0")

		$iActivateKQCondition = IniRead($config, "attack", "ActivateKQ", "Manual")
		$delayActivateKQ = (1000 * IniRead($config, "attack", "delayActivateKQ", "9"))

		$sTimeStopAtk = IniRead($config, "attack", "txtTimeStopAtk", "0")

		$TakeLootSnapShot = IniRead($config, "attack", "TakeLootSnapShot", "0")

		;Attack Adv. Settings--------------------------------------------------------------------------
		$chkATH = IniRead($config, "advanced", "townhall", "0")

		$OptBullyMode = IniRead($config, "advanced", "BullyMode", "0")
		$ATBullyMode = IniRead($config, "advanced", "ATBullyMode", "0")
		$YourTH = IniRead($config, "advanced", "YourTH", "0")

		$OptTrophyMode = IniRead($config, "advanced", "TrophyMode", "0")
		$THaddtiles = IniRead($config, "advanced", "THaddTiles", "0")
		$AttackTHType = IniRead($config, "advanced", "AttackTHType", "0")

		;atk their king
		;atk their queen
		;hit de with lightning spell

		;Donate Settings-------------------------------------------------------------------------
		$ichkRequest = IniRead($config, "donate", "chkRequest", "0")
		$itxtRequest = IniRead($config, "donate", "txtRequest", "")

		$ichkDonateBarbarians = IniRead($config, "donate", "chkDonateBarbarians", "0")
		$ichkDonateAllBarbarians = IniRead($config, "donate", "chkDonateAllBarbarians", "0")
		$itxtDonateBarbarians = StringReplace(IniRead($config, "donate", "txtDonateBarbarians", "barbarians|barb|any"), "|", @CRLF)

		$ichkDonateArchers = IniRead($config, "donate", "chkDonateArchers", "0")
		$ichkDonateAllArchers = IniRead($config, "donate", "chkDonateAllArchers", "0")
		$itxtDonateArchers = StringReplace(IniRead($config, "donate", "txtDonateArchers", "archers|arch|any"), "|", @CRLF)

		$ichkDonateGiants = IniRead($config, "donate", "chkDonateGiants", "0")
		$ichkDonateAllGiants = IniRead($config, "donate", "chkDonateAllGiants", "0")
		$itxtDonateGiants = StringReplace(IniRead($config, "donate", "txtDonateGiants", "giants|giant|any"), "|", @CRLF)

		;Troop Settings--------------------------------------------------------------------------
		$BarbariansComp = IniRead($config, "troop", "barbarian", "0")
		$ArchersComp = IniRead($config, "troop", "archer", "0")
		$GiantsComp = IniRead($config, "troop", "giant", "0")
		$GoblinsComp = IniRead($config, "troop", "goblin", "0")
		$WBComp = IniRead($config, "troop", "WB", "0")
		$WizardsComp = IniRead($config, "troop", "wizard", "0")
		$MinionsComp = IniRead($config, "troop", "minion", "0")
		$HogsComp = IniRead($config, "troop", "hog", "0")

		For $i = 0 To 3 ;Covers all 4 Barracks
			$barrackTroop[$i] = IniRead($config, "troop", "troop" & $i + 1, "0")
		Next

		$fulltroop = IniRead($config, "troop", "fullTroop", "100")
		;barracks boost not saved (no use)

		;Misc Settings--------------------------------------------------------------------------

		$ichkWalls = IniRead($config, "other", "auto-wall", "0")
		$iUseStorage = IniRead($config, "other", "use-storage", "0")

		$icmbWalls = IniRead($config, "other", "walllvl", "0")
		$itxtWallMinGold = IniRead($config, "other", "minwallgold", "0")
		$itxtWallMinElixir = IniRead($config, "other", "minwallelixir", "0")

		$ichkTrap = IniRead($config, "other", "chkTrap", "0")
		$iChkCollect = IniRead($config, "other", "chkCollect", "1")
		$sTimeWakeUp = IniRead($config, "other", "txtTimeWakeUp", "0")
		$iVSDelay = IniRead($config, "other", "VSDelay", "1")

		$itxtMaxTrophy = IniRead($config, "other", "MaxTrophy", "3000")
		$itxtdropTrophy = IniRead($config, "other", "MinTrophy", "3000")

		$TownHallPos[0] = IniRead($config, "other", "xTownHall", "-1")
		$TownHallPos[1] = IniRead($config, "other", "yTownHall", "-1")

		$CCPos[0] = IniRead($config, "other", "xCCPos", "0")
		$CCPos[1] = IniRead($config, "other", "yCCPos", "0")

		$barrackPos[0] = IniRead($config, "other", "xBarrack", "0")
		$barrackPos[1] = IniRead($config, "other", "yBarrack", "0")

		$ArmyPos[0] = IniRead($config, "other", "xArmy", "0")
		$ArmyPos[1] = IniRead($config, "other", "yArmy", "0")

		$SFPos[0] = IniRead($config, "other", "xspellfactory", "-1")
		$SFPos[1] = IniRead($config, "other", "yspellfactory", "-1")

	Else
		Return False
	EndIf
EndFunc   ;==>readConfig
