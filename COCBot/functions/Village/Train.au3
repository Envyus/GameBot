;	Uses the location of manually set Barracks to train specified troops
;	coded by HungLe from gamebot.org
;	Train the troops (Fill the barracks)

Func GetTrainPos($troopKind)
   Switch $troopKind
   Case $eBarbarian ; 261, 366: 0x39D8E0
	  Return $TrainBarbarian
   Case $eArcher ; 369, 366: 0x39D8E0
	  Return $TrainArcher
   Case $eGiant ; 475, 366: 0x3DD8E0
	  Return $TrainGiant
   Case $eWizard ; 475, 366: 0x3DD8E0
	  Return $TrainWizard
   Case $eGoblin ; 581, 366: 0x39D8E0
	  Return $TrainGoblin
   Case $eWallbreaker ; 688, 366, 0x3AD8E0
	  Return $TrainWallbreaker
   Case $eHog ; 688, 366, 0x3AD8E0
	  Return $TrainDarkHog
   Case $eMinion ; 688, 366, 0x3AD8E0
	  Return $TrainDarkMinion
   Case Else
	  SetLog("Don't know how to train the troop " & $troopKind & " yet")
	  Return 0
   EndSwitch
EndFunc

Func TrainIt($troopKind, $howMuch = 1, $iSleep = 400)
   _CaptureRegion()
   Local $pos = GetTrainPos($troopKind)
   If IsArray($pos) Then
	  If CheckPixel($pos) Then
		 ClickP($pos, $howMuch, 20)
		 if _Sleep($iSleep) Then Return False
		 Return True
	  EndIf
   EndIf
EndFunc

Func Train()
	If _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
		checkArmyCamp()
	EndIf

	If $barrackPos[0] = "" Then
		Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
		If _Sleep(500) Then Return
		LocateBarrack()
		SaveConfig()
		If _Sleep(2000) Then Return
	EndIf

	SetLog("Training Troops...", $COLOR_BLUE)

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If _Sleep(100) Then Return

	Click($barrackPos[0], $barrackPos[1]) ;Click Barrack

	If _Sleep(700) Then Return

	Local $TrainPos = _PixelSearch(155, 603, 694, 605, Hex(0x603818, 6), 5) ;Finds Train Troops button

	If IsArray($TrainPos) = False Then
		SetLog("Your Barrack is not available. (Upgrading? Locate another Barrack on the 'Misc' tab)", $COLOR_RED)
		If _Sleep(500) Then Return
	Else
		Click($TrainPos[0], $TrainPos[1]) ;Click Train Troops button
		If _Sleep(1000) Then Return
		if not $fullArmy then CheckFullArmy()  ;if armycamp not full, check full by barrack
	Endif
	if not $fullArmy and $iTimeTroops <> 0 and $barrackNum = 4 and $barrackDarkNum = 0 then ; if armycamp and barrack return not full, force FULL and Raid if enough time wait
		if _DateDiff('s', _NowCalc(), $iTimeTroops) < 0 and 1=2 then
			$fullArmy = true
			SetLog("Time to Attack now..", $COLOR_RED)
		endif
	endif

	If $fullArmy Then
		SetLog("Army Camp is Full", $COLOR_RED)
	Else
		SetLog("Army Camp not Full yet", $COLOR_RED)
	EndIf

	If $fullArmy Then ; reset all to cook again
		$ArmyComp = 0
		$CurGiant = 0
		$CurWizard = 0
		$CurWB = 0
		$CurArch = 0
		$CurBarb = 0
		$CurGoblin = 0
		$CurHog = 0
		$CurMinion = 0
	Endif

	If $fullArmy and $ArmyComp = 0 Then
		$CurGiant = GUICtrlRead($txtNumGiants)
		$CurHog = GUICtrlRead($txtNumHogs)
		$CurMinion = GUICtrlRead($txtNumMinions)
		$CurWB = GUICtrlRead($txtNumWallbreakers)
		$CurWizard = GUICtrlRead($txtNumWizards)
		$CurGoblin = ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtGoblins)/100
		$CurGoblin = Round($CurGoblin)
		$CurBarb = ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtBarbarians)/100
		$CurBarb = Round($CurBarb)
		$CurArch = ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtArchers)/100
		$CurArch = Round($CurArch)
	elseif $ArmyComp = 0 or $FirstStart Then
		$CurGiant += GUICtrlRead($txtNumGiants)
		$CurHog += GUICtrlRead($txtNumHogs)
		$CurMinion += GUICtrlRead($txtNumMinions)
		$CurWB += GUICtrlRead($txtNumWallbreakers)
		$CurWizard = GUICtrlRead($txtNumWizards)
		$CurGoblin += ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtGoblins)/100
		$CurGoblin = Round($CurGoblin)
		$CurBarb += ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtBarbarians)/100
		$CurBarb = Round($CurBarb)
		$CurArch += ($TotalCamp-(GUICtrlRead($txtNumWizards)*4)-(GUICtrlRead($txtNumMinions)*2)-(GUICtrlRead($txtNumHogs)*5)-(GUICtrlRead($txtNumGiants)*5)-(GUICtrlRead($txtNumWallbreakers)*2))*GUICtrlRead($txtArchers)/100
		$CurArch = Round($CurArch)
	EndIf

	Local $GiantEBarrack ,$WallEBarrack ,$ArchEBarrack ,$BarbEBarrack ,$GoblinEBarrack,$HogEBarrack,$MinionEBarrack, $WizardEBarrack
	if $barrackNum <> 0 then
		$GiantEBarrack = Floor($CurGiant/$barrackNum)
		$WallEBarrack = Floor($CurWB/$barrackNum)
		$ArchEBarrack = Floor($CurArch/$barrackNum)
		$BarbEBarrack = Floor($CurBarb/$barrackNum)
		$GoblinEBarrack = Floor($CurGoblin/$barrackNum)
		$WizardEBarrack = Floor($CurWizard/$barrackNum)
	else
		$GiantEBarrack = Floor($CurGiant/4)
		$WallEBarrack = Floor($CurWB/4)
		$ArchEBarrack = Floor($CurArch/4)
		$BarbEBarrack = Floor($CurBarb/4)
		$GoblinEBarrack = Floor($CurGoblin/4)
		$WizardEBarrack = Floor($CurWizard/4)
	endif
	$HogEBarrack = Floor($CurHog/2)
	$MinionEBarrack = Floor($CurMinion/2)

	If $ArmyComp = 0 Then
		If $fullArmy Then
			Local $TimeETroops = $WizardEBarrack * $iTimeWizard + $GiantEBarrack * $iTimeGiant + $WallEBarrack * $iTimeWall + $ArchEBarrack * $iTimeArch + $BarbEBarrack * $iTimeBarba + $GoblinEBarrack*$iTimeGoblin + 180
			$iTimeTroops = _DateAdd( 's',$TimeETroops,  _NowCalc())
		Endif
		If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 Then
			$iTimeTroops = 0
		endif
	EndIf
	Local $hTimer = TimerInit()
	Local $troopFirstHog,$troopSecondHog,$troopFirstMinion,$troopSecondMinion,$troopFirstGiant,$troopSecondGiant,$troopFirstWall,$troopSecondWall,$troopFirstGoblin,$troopSecondGoblin
	Local $troopFirstBarba,$troopSecondBarba,$troopFirstArch,$troopSecondArch,$troopFirstWizard,$troopSecondWizard
	$troopFirstGiant = 0
	$troopSecondGiant = 0
	$troopFirstHog = 0
	$troopSecondHog = 0
	$troopFirstMinion = 0
	$troopSecondMinion = 0
	$troopFirstWall = 0
	$troopSecondWall = 0
	$troopFirstGoblin = 0
	$troopSecondGoblin = 0
	$troopFirstBarba = 0
	$troopSecondBarba = 0
	$troopFirstArch = 0
	$troopSecondArch = 0
	$troopFirstWizard = 0
	$troopSecondWizard = 0

	If _Sleep(1000) Then return
	Local $NextPos = _PixelSearch(749, 333, 787, 349, Hex(0xF08C40, 6), 5)
    Local $PrevPos = _PixelSearch(70, 336, 110, 351, Hex(0xF08C40, 6), 5)
	
	Local $iBarrHere
	$iBarrHere = 0
	while isBarrack()
		If IsArray($NextPos) Then Click($NextPos[0], $NextPos[1]) ;click next button
		$iBarrHere += 1
		If _Sleep(1000) Then ExitLoop
		if($iBarrHere = $barrackNumSpecial) then ExitLoop
	wend

	$brrNum = 0
	If _Sleep(300) Then return
	If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button

	If _Sleep(1000) Then return
	_CaptureRegion()
	If _Sleep(10) Then return
	
	Local $IsTraining = true
	if _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 8 then
		while isBarrack()
			_CaptureRegion()
			if $FirstStart then
				 Click(496, 197, 80,5)
			endif
		    If _Sleep(500) Then ExitLoop
			$brrNum += 1
			Switch $barrackTroop[$brrNum-1]
				Case 0
						Click(220, 320, 25, 10)
				Case 1
						Click(331, 320, 25, 10)
				Case 2
						Click(432, 320, 25, 10)
				Case 3
						Click(546, 320, 25, 10)
				Case 4
						Click(647, 320, 25, 10)
			EndSwitch

		    If _Sleep(500) Then ExitLoop
			 Click($PrevPos[0], $PrevPos[1]) ;click prev button
			 If $brrNum >= 4 Then ExitLoop ; make sure no more infiniti loop
			 If _Sleep(1000) Then ExitLoop
			;endif
		wend
	else
		while isBarrack()
			$brrNum += 1
			; SetLog("====== Barrack: " & $brrNum & " ======", $COLOR_BLUE)

			_CaptureRegion()
			;while _ColorCheck(_GetPixelColor(496, 200), Hex(0x880000, 6), 20) Then
			if $fullArmy or $FirstStart then
				 Click(496, 197, 80,5)
			endif
			;wend

		   If _Sleep(500) Then ExitLoop
		   _CaptureRegion()
		   If GUICtrlRead($txtNumGiants) <> "0" Then
			  $troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  if $troopFirstGiant = 0 then
				  $troopFirstGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  endif
		   Endif
		   If GUICtrlRead($txtNumWizards) <> "0" Then
			  $troopFirstWizard = Number(getOther(171 + 107 * 1, 384, "Barrack"))
			  if $troopFirstWizard = 0 then
				  $troopFirstWizard = Number(getOther(171 + 107 * 1, 384, "Barrack"))
			  endif
		   Endif
		   if GUICtrlRead($txtNumWallbreakers) <> "0" then
			  $troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  if $troopFirstWall = 0 then
				  $troopFirstWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  endif
		   EndIf
		   if GUICtrlRead($txtGoblins) <> "0" then
			  $troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  if $troopFirstGoblin = 0 then
				  $troopFirstGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  endif
		   EndIf
		   If GUICtrlRead($txtBarbarians) <> "0" then
			  $troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  if $troopFirstBarba = 0 then
				  $troopFirstBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  endif
		   EndIf
		   If GUICtrlRead($txtArchers) <> "0" Then
			  $troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  if $troopFirstArch = 0 then
				  $troopFirstArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  endif
		   Endif

		   If GUICtrlRead($txtArchers) <> "0" And $CurArch > 0 Then
			   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurArch > 0 Then
			   If $CurArch > 0  Then
					if $ArchEBarrack = 0 then
					    TrainIt($eArcher, 1)
					elseif $ArchEBarrack >= $CurArch then
					    TrainIt($eArcher, $CurArch)
				    else
					    TrainIt($eArcher, $ArchEBarrack)
				    endif
			   EndIf
		   EndIf

		   If GUICtrlRead($txtNumGiants) <> "0" And $CurGiant > 0 Then
			   ;If _ColorCheck(_GetPixelColor(475, 366), Hex(0x3DD8E0, 6), 20) And $CurGiant > 0 Then
			   If $CurGiant > 0 Then
				   if $GiantEBarrack = 0 then
					    TrainIt($eGiant, 1)
					elseif $GiantEBarrack >= $CurGiant or $GiantEBarrack = 0  then
					   TrainIt($eGiant, $CurGiant)
				   else
					   TrainIt($eGiant, $GiantEBarrack)
				   endif
			   endif
		   EndIf
		   
		   If GUICtrlRead($txtNumWizards) <> "0" And $CurWizard > 0 Then
			   If $CurWizard > 0 Then
				   if $WizardEBarrack = 0 then
					    TrainIt($eWizard, 1)
					elseif $WizardEBarrack >= $CurWizard or $WizardEBarrack = 0  then
					   TrainIt($eWizard, $CurWizard)
				   else
					   TrainIt($eWizard, $WizardEBarrack)
				   endif
			   endif
		   EndIf


		   If GUICtrlRead($txtNumWallbreakers) <> "0" And $CurWB > 0 Then
			   ;If _ColorCheck(_GetPixelColor(688, 366), Hex(0x3AD8E0, 6), 20) And $CurWB > 0  Then
			   If $CurWB > 0  Then
				   if $WallEBarrack = 0 then
					    TrainIt($eWallbreaker, 1)
					elseif $WallEBarrack >= $CurWB or $WallEBarrack = 0  then
					   TrainIt($eWallbreaker, $CurWB)
				   else
					   TrainIt($eWallbreaker, $WallEBarrack)
				   endif
			   EndIf
		   EndIf


		   If GUICtrlRead($txtBarbarians) <> "0" And $CurBarb > 0 Then
			   ;If _ColorCheck(_GetPixelColor(369, 366), Hex(0x39D8E0, 6), 20) And $CurBarb > 0 Then
			   If $CurBarb > 0  Then
				   if $BarbEBarrack = 0 then
					    TrainIt($eBarbarian, 1)
					elseif $BarbEBarrack >= $CurBarb or $BarbEBarrack = 0  then
					   TrainIt($eBarbarian, $CurBarb)
				   else
					   TrainIt($eBarbarian, $BarbEBarrack)
				   endif
			   EndIf
		   EndIf



		   If GUICtrlRead($txtGoblins) <> "0" And $CurGoblin > 0 Then
			   ;If _ColorCheck(_GetPixelColor(261, 366), Hex(0x39D8E0, 6), 20) And $CurGoblin > 0 Then
			   If $CurGoblin > 0  Then
				   if $GoblinEBarrack = 0 then
					    TrainIt($eGoblin, 1)
					elseif $GoblinEBarrack >= $CurGoblin or $GoblinEBarrack = 0  then
					   TrainIt($eGoblin, $CurGoblin)
				   else
					   TrainIt($eGoblin, $GoblinEBarrack)
				   endif
			   EndIf
		   EndIf


		   If _Sleep(900) Then ExitLoop
		   _CaptureRegion()
		   If GUICtrlRead($txtNumGiants) <> "0" Then
			  $troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			  if $troopSecondGiant = 0 then
				  $troopSecondGiant = Number(getOther(171 + 107 * 2, 278, "Barrack"))
			   endif
			EndIf
		   If GUICtrlRead($txtNumWizards) <> "0" Then
			  $troopSecondWizard = Number(getOther(171 + 107 * 1, 384, "Barrack"))
			  if $troopSecondWizard = 0 then
				  $troopSecondWizard = Number(getOther(171 + 107 * 1, 384, "Barrack"))
			   endif
			EndIf
		   if GUICtrlRead($txtNumWallbreakers) <> "0" then
			  $troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			  if $troopSecondWall = 0 then
				  $troopSecondWall = Number(getOther(171 + 107 * 4, 278, "Barrack"))
			   endif
			EndIf
		   if GUICtrlRead($txtGoblins) <> "0" then
			  $troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			  if $troopSecondGoblin = 0 then
				  $troopSecondGoblin = Number(getOther(171 + 107 * 3, 278, "Barrack"))
			   endif
			EndIf
		   If GUICtrlRead($txtBarbarians) <> "0" then
			  $troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			  if $troopSecondBarba = 0 then
				  $troopSecondBarba = Number(getOther(171 + 107 * 0, 278, "Barrack"))
			   endif
		   EndIf
		   If GUICtrlRead($txtArchers) <> "0" Then
			  $troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  if $troopSecondArch = 0 then
				  $troopSecondArch = Number(getOther(171 + 107 * 1, 278, "Barrack"))
			  endif
		   EndIf

		   if $troopSecondGiant > $troopFirstGiant and GUICtrlRead($txtNumGiants) <> "0" then
			   $ArmyComp += ($troopSecondGiant - $troopFirstGiant)*5
			   $CurGiant -= ($troopSecondGiant - $troopFirstGiant)
;~ 			   SetLog("        Giants: " & ($troopSecondGiant - $troopFirstGiant))
			   ;SetLog("Remaining Giants: " & $CurGiant , $COLOR_ORANGE)
		   endif
		   
		   if $troopSecondWizard > $troopFirstWizard and GUICtrlRead($txtNumWizards) <> "0" then
			   $ArmyComp += ($troopSecondWizard - $troopFirstWizard)*5
			   $CurWizard -= ($troopSecondWizard - $troopFirstWizard)
		   endif


		   if $troopSecondWall > $troopFirstWall and GUICtrlRead($txtNumWallbreakers) <> "0" then
			   $ArmyComp += ($troopSecondWall - $troopFirstWall)*2
			   $CurWB -= ($troopSecondWall - $troopFirstWall)
;~ 			   SetLog("  WallBreakers: " & ($troopSecondWall - $troopFirstWall))
			   ;SetLog("Remaining WallBreakers: " & $CurWB , $COLOR_ORANGE)
		   endif

		   if $troopSecondGoblin > $troopFirstGoblin and GUICtrlRead($txtGoblins) <> "0" then
			   $ArmyComp += ($troopSecondGoblin - $troopFirstGoblin)
			   $CurGoblin -= ($troopSecondGoblin - $troopFirstGoblin)
;~ 			   SetLog("       Goblins: " & ($troopSecondGoblin - $troopFirstGoblin))
			   ;SetLog("Remaining Goblins: " & $CurGoblin , $COLOR_ORANGE)
		   endif

		   if $troopSecondBarba > $troopFirstBarba and GUICtrlRead($txtBarbarians) <> "0" then
			   $ArmyComp += ($troopSecondBarba - $troopFirstBarba)
			   $CurBarb -= ($troopSecondBarba - $troopFirstBarba)
;~ 			   SetLog("    Barbarians: " & ($troopSecondBarba - $troopFirstBarba))
			   ;SetLog("Remaining Barbarians: " & $CurBarb , $COLOR_ORANGE)
		   endif

		   if $troopSecondArch > $troopFirstArch and GUICtrlRead($txtArchers) <> "0" then
			   $ArmyComp += ($troopSecondArch - $troopFirstArch)
			   $CurArch -= ($troopSecondArch - $troopFirstArch)
;~ 			   SetLog("       Archers: " & ($troopSecondArch - $troopFirstArch))
			   ;SetLog("Remaining Archers: " & $CurArch , $COLOR_ORANGE)
		   endif
		   ;SetLog("Total Troops building : " & $ArmyComp , $COLOR_RED)

			if ($troopSecondWizard = 0 and $troopSecondGiant = 0 and $troopSecondWall = 0 and $troopSecondGoblin = 0 and $CurHog<=0 and $CurMinion <= 0) then
				if GUICtrlRead($txtGoblins) <> "0" or GUICtrlRead($txtBarbarians) <> "0" or GUICtrlRead($txtArchers) <> "0" then
					if $troopSecondArch <= 10 and $troopSecondBarba = 0 then
						TrainIt($eArcher, 20)
					elseif $troopSecondBarba <= 10 and $troopSecondArch = 0 then
						TrainIt($eBarbarian, 20)
					endif
				endif
			endif
			if ($troopSecondWizard <= 1 and $troopSecondGiant <= 1 and $troopSecondWall <= 1 and $troopSecondArch = 0 and $troopSecondBarba = 0 and $troopSecondGoblin = 0 and $CurHog<=0 and $CurMinion <= 0) then
				if GUICtrlRead($txtGoblins) <> "0" or GUICtrlRead($txtBarbarians) <> "0" or GUICtrlRead($txtArchers) <> "0" then
					if _ColorCheck(_GetPixelColor(327, 520), Hex(0xD03838, 6), 20) then
						Click(496, 197, 5,5)
						If _Sleep(100) Then ExitLoop
						TrainIt($eArcher, 20)
					endif
				endif
			endif

		   Click($PrevPos[0], $PrevPos[1]) ;click prev button
		   If $brrNum >= $barrackNumSpecial Then ExitLoop ; make sure no more infiniti loop
		   If _Sleep(1000) Then ExitLoop
		wend
	EndIf

	If $brrNum > 0 and $brrNum <> $barrackNum then
		$barrackNum = $brrNum
	endif


	;dark here

	If $CurHog > 0 or $CurMinion > 0 Then
		$iBarrHere = 0
		$brrDarkNum = 0
		while 1
			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
			$iBarrHere += 1
			If _Sleep(1000) Then ExitLoop
			if(isDarkBarrack() or $iBarrHere = 5) then ExitLoop
		wend

		while isDarkBarrack()
			$brrDarkNum += 1
;~ 			; SetLog("====== Barrack: " & $brrDarkNum & " ======", $COLOR_PURPLE)
			if StringInStr($sBotDll, "CGBPlugin.dll") < 1 then
				ExitLoop
			endif
			if $fullArmy or $FirstStart then
				 Click(496, 197, 40,5)
			endif
			_CaptureRegion()
		  $troopFirstHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		  if $troopFirstHog = 0 then
			  $troopFirstHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
		  endif

		  $troopFirstMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		  if $troopFirstMinion = 0 then
			  $troopFirstMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
		  endif

			If _Sleep(500) Then ExitLoop

		   If $CurHog > 0 Then
			   if $HogEBarrack = 0 then
					TrainIt($eHog, 1)
				elseif $HogEBarrack >= $CurHog or $HogEBarrack = 0  then
				   TrainIt($eHog, $CurHog)
			   else
				   TrainIt($eHog, $HogEBarrack)
			   endif
		   endif
		   If $CurMinion > 0 Then
			   if $MinionEBarrack = 0 then
					TrainIt($eMinion, 1)
				elseif $MinionEBarrack >= $CurMinion or $MinionEBarrack = 0  then
				   TrainIt($eMinion, $CurMinion)
			   else
				   TrainIt($eMinion, $MinionEBarrack)
			   endif
		   endif
			If _Sleep(900) Then ExitLoop
		   _CaptureRegion()
				  $troopSecondHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
				  if $troopSecondHog = 0 then
					  $troopSecondHog = Number(getOther(171 + 107 * 1, 278, "Barrack"))
				   endif
				  $troopSecondMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				  if $troopSecondMinion = 0 then
					  $troopSecondMinion = Number(getOther(171 + 107 * 0, 278, "Barrack"))
				   endif


				if $troopSecondHog > $troopFirstHog and GUICtrlRead($txtNumHogs) <> "0" then
				   $ArmyComp += ($troopSecondHog - $troopFirstHog)*5
				   $CurHog -= ($troopSecondHog - $troopFirstHog)
			   endif
				if $troopSecondMinion > $troopFirstMinion and GUICtrlRead($txtNumMinions) <> "0" then
				   $ArmyComp += ($troopSecondMinion - $troopFirstMinion)*2
				   $CurMinion -= ($troopSecondMinion - $troopFirstMinion)
			   endif

			If _Sleep(500) Then ExitLoop

			If IsArray($PrevPos) Then Click($PrevPos[0], $PrevPos[1]) ;click prev button
			If _Sleep(1000) Then ExitLoop
			If $brrDarkNum >= $barrackDarkNumSpecial Then ExitLoop ; make sure no more infiniti loop
		wend
		If $brrDarkNum > 0 and $brrDarkNum <> $barrackDarkNum then
			$barrackDarkNum = $brrDarkNum
		endif
		;end dark
	EndIf

	If _Sleep(200) Then Return
	Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay

	$FirstStart = false
;~         SetLog("========================", $COLOR_GREEN)
	IF _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 1 Then
;~ 		SetLog("========================", $COLOR_GREEN)
	EndIf

	if $iTimeTroops <> 0 and $barrackNum = 4 and $barrackDarkNum = 0 then
		Local $TimeWaiting = _DateDiff('s', _NowCalc(),$iTimeTroops) - Round(TimerDiff($hTimer) / 1000, 2)
		if $TimeWaiting > 0 then
			SetLog("Time until Next attack: " & StringFormat("%02i", Floor(Floor($TimeWaiting / 60) / 60)) & ":" & StringFormat("%02i", Floor(Mod(Floor($TimeWaiting / 60), 60))) & ":" & StringFormat("%02i", Floor(Mod($TimeWaiting, 60))), $COLOR_ORANGE)
		Endif
		;SetLog("...", $COLOR_GREEN)
    Endif
 EndFunc   ;==>Train

Func checkArmyCamp()
	SetLog("Checking Army Camp...", $COLOR_BLUE)
   If _Sleep(100) Then Return

   ClickP($TopLeftClient) ;Click Away

	If $ArmyPos[0] = "" Then
		LocateBarrack(True)
		SaveConfig()
    else
	   If _Sleep(100) Then Return
	   Click($ArmyPos[0], $ArmyPos[1]) ;Click Army Camp
    endif
	_CaptureRegion()
   If _Sleep(500) Then Return
   Local $BArmyPos = _PixelSearch(309, 581, 433, 583, Hex(0x4084B8, 6), 5) ;Finds Info button
   If IsArray($BArmyPos) = False Then
	   SetLog("Your Army Camp is not available", $COLOR_RED)
	   if $TotalCamp = "" and $TotalCamp = 0 then
		   $TotalCamp = InputBox("Question", "Enter your total Army Camp capacity", "200", "", _
				 - 1, -1, 0, 0)
			$TotalCamp = int($TotalCamp)
		 Endif
	   If _Sleep(500) Then Return
   Else
	   Click($BArmyPos[0], $BArmyPos[1]) ;Click Info button
	   If _Sleep(1000) Then Return
	   $CurCamp = Number(getOther(586, 193, "Camp"))
	   if $TotalCamp = "" or $TotalCamp = 0 then
		$TotalCamp = Number(getOther(586, 193, "Camp", True))
	   endif

	   SetLog("Total Army Camp capacity: " & $CurCamp & "/" & $TotalCamp)
	   ;If _ColorCheck(_GetPixelColor(692, 208), Hex(0x90DB38, 6), 20) and $ichkFullTroop = 0 Then
	   
		if ($CurCamp >= ($TotalCamp * $fulltroop/100)) then
			$fullArmy = True
		endif

	   if $fullArmy then
	   elseIf $CurCamp=$TotalCamp Then
		   $fullArmy = True
	   Else
		  _CaptureRegion()
		  For $i = 0 To 6
			  Local $TroopKind = _GetPixelColor(230 + 71 * $i, 359)
			  Local $TroopName = 0
			  Local $TroopQ = getOther(229 + 71 * $i, 413, "Camp")
			  If _ColorCheck($TroopKind, Hex(0xF85CCB, 6), 20) Then
				 if ($CurArch=0 and $FirstStart) then $CurArch -= $TroopQ
				 $TroopName = "Archers"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8E439, 6), 20) Then
				 if ($CurBarb=0 and $FirstStart) then $CurBarb -= $TroopQ
				 $TroopName = "Barbarians"
			  ElseIf _ColorCheck($TroopKind, Hex(0xF8D198, 6), 20) Then
				 if ($CurGiant=0 and $FirstStart) then $CurGiant -= $TroopQ
				 $TroopName = "Giants"
			  ElseIf _ColorCheck($TroopKind, Hex(0x93EC60, 6), 20) Then
				 if ($CurGoblin=0 and $FirstStart) then $CurGoblin -= $TroopQ
				 $TroopName = "Goblins"
			  ElseIf _ColorCheck($TroopKind, Hex(0x48A8E8, 6), 20) Then
				 if ($CurWB=0 and $FirstStart) then $CurWB -= $TroopQ
				 $TroopName = "Wallbreakers"
			  ElseIf _ColorCheck($TroopKind, Hex(0x302018, 6), 20) Then
				 if ($CurHog=0 and $FirstStart) then $CurHog -= $TroopQ
				 $TroopName = "Hog Riders"
			  ElseIf _ColorCheck($TroopKind, Hex(0x1F1712, 6), 20) Then
				 if ($CurHog=0 and $FirstStart) then $CurHog -= $TroopQ
				 $TroopName = "Hog Riders"
			  ElseIf _ColorCheck($TroopKind, Hex(0x081010, 6), 20) Then
				 if ($CurHog=0 and $FirstStart) then $CurHog -= $TroopQ
				 $TroopName = "Hog Riders"
			  ElseIf _ColorCheck($TroopKind, Hex(0x131D38, 6), 20) Then
				 if ($CurMinion=0 and $FirstStart) then $CurMinion -= $TroopQ
				 $TroopName = "Minions"
			  ElseIf _ColorCheck($TroopKind, Hex(0xC07870, 6), 20) Then
				 if ($CurWizard=0 and $FirstStart) then $CurWizard -= $TroopQ
				 $TroopName = "Wizards"
			  EndIf
			  ;656,359,0xBCBAAC   ---   6  --nothing
			  If $TroopQ <> 0 Then SetLog(" - No. of " & $TroopName & ": " & $TroopQ)
		   Next
		EndIf
		if not $fullArmy and $FirstStart then
			$ArmyComp = $CurCamp
	    endif
	   ClickP($TopLeftClient) ;Click Away
	   $FirstCampView = True
	 EndIf

Endfunc