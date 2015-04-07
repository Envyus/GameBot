; Improved attack algorithm, using Barbarians, Archers, Goblins, Giants and Wallbreakers as they are available
; Create by Fast French, edited by safar46

Func SetSleep($type)
   Switch $type
   Case 0
	  If $iRandomspeedatk = 1 Then
		 Return Round(Random(1, 10))*10
	  Else
		 Return ($icmbUnitDelay+1)*10
	  EndIf
   Case 1
	  If $iRandomspeedatk = 1 Then
		 Return Round(Random(1, 10))*100
	  Else
		 Return ($icmbWaveDelay+1)*100
	  EndIf
   EndSwitch
EndFunc

; Old mecanism, not used anymore
Func OldDropTroop($troop, $position, $nbperspot)
  SelectDropTroop($troop) ;Select Troop
  If _Sleep(100) Then Return
  For $i = 0 To 4
	 Click($position[$i][0], $position[$i][1], $nbperspot, 1)
	 If _Sleep(50) Then Return
  Next
EndFunc


; improved function, that avoids to only drop on 5 discret drop points :
Func DropOnEdge($troop, $edge, $number, $slotsPerEdge = 0, $edge2 = -1, $x = -1)
   if $number = 0 Then Return
   If _Sleep(100) Then Return
   SelectDropTroop($troop) ;Select Troop
   If _Sleep(300) Then Return
   If $slotsPerEdge = 0 Or $number < $slotsPerEdge Then $slotsPerEdge = $number
   If $number = 1 Or $slotsPerEdge = 1 Then ; Drop on a single point per edge => on the middle
	  Click($edge[2][0], $edge[2][1], $number,250)
	  If $edge2 <> -1 Then Click($edge2[2][0], $edge2[2][1], $number,250)
	  If _Sleep(50) Then Return
  ElseIf $slotsPerEdge = 2 Then ; Drop on 2 points per edge
	 Local $half = Ceiling($number/2)
	 Click($edge[1][0], $edge[1][1], $half)
	 If $edge2 <> -1 Then
		If _Sleep(SetSleep(0)) Then Return
		Click($edge2[1][0], $edge2[1][1], $half)
	 EndIf
	 If _Sleep(SetSleep(0)) Then Return
	 Click($edge[3][0], $edge[3][1], $number  - $half)
	 If $edge2 <> -1 Then
		If _Sleep(SetSleep(0)) Then Return
		Click($edge2[3][0], $edge2[3][1], $number  - $half)
	 EndIf
	 If _Sleep(SetSleep(0)) Then Return
   Else
	    Local $minX = $edge[0][0]
		Local $maxX = $edge[4][0]
		Local $minY = $edge[0][1]
		Local $maxY = $edge[4][1]
	    If $edge2 <> -1 Then
			Local $minX2 = $edge2[0][0]
			Local $maxX2 = $edge2[4][0]
			Local $minY2 = $edge2[0][1]
			Local $maxY2 = $edge2[4][1]
	    EndIf
		Local $nbTroopsLeft = $number
  	    For $i = 0 To $slotsPerEdge - 1
			Local $nbtroopPerSlot = Round($nbTroopsLeft/($slotsPerEdge - $i)) ; progressively adapt the number of drops to fill at the best
	  		Local $posX = $minX + (($maxX - $minX) * $i) / ($slotsPerEdge - 1)
			Local $posY = $minY + (($maxY - $minY) * $i) / ($slotsPerEdge - 1)
			Click($posX, $posY, $nbtroopPerSlot)
			If $edge2 <> -1 Then ; for 2, 3 and 4 sides attack use 2x dropping
			   Local $posX2 = $maxX2 - (($maxX2 - $minX2) * $i) / ($slotsPerEdge - 1)
			   Local $posY2 = $maxY2 - (($maxY2 - $minY2) * $i) / ($slotsPerEdge - 1)
			   If $x = 0 Then
				  If _Sleep(SetSleep(0)) Then Return ; add delay for first wave attack to prevent skip dropping troops, must add for 4 sides attack
			   EndIf
			   Click($posX2, $posY2, $nbtroopPerSlot)
			   $nbTroopsLeft -= $nbtroopPerSlot
			Else
			   $nbTroopsLeft -= $nbtroopPerSlot
			EndIf
			If _Sleep(SetSleep(0)) Then Return
		 Next
	  EndIf
EndFunc

Func DropOnEdges($troop, $nbSides, $number, $slotsPerEdge=0)
    If $nbSides = 0 Or $number = 1 Then
	   OldDropTroop($troop, $Edges[0], $number);
	   Return
    EndIf
	If $nbSides < 1 Then Return
    Local $nbTroopsLeft = $number
	If $nbSides = 4 Then
	  For $i = 0 to $nbSides-3
		 Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i*2))
		 DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i+2], $i)
		 $nbTroopsLeft -= $nbTroopsPerEdge*2
	  Next
	  Return
	EndIf
  	For $i = 0 to $nbSides-1
	   If $nbSides = 1 Or ($nbSides = 3 And $i = 2) Then
	     Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i))
		 DropOnEdge($troop, $Edges[$i], $nbTroopsPerEdge, $slotsPerEdge)
	     $nbTroopsLeft -= $nbTroopsPerEdge
	   Elseif ($nbSides = 2 And $i = 0) Or ($nbSides = 3 And $i <> 1) Then
	     Local $nbTroopsPerEdge = Round($nbTroopsLeft/($nbSides-$i*2))
		 DropOnEdge($troop, $Edges[$i+3], $nbTroopsPerEdge, $slotsPerEdge, $Edges[$i+1])
	     $nbTroopsLeft -= $nbTroopsPerEdge*2
	   EndIf
    Next
EndFunc

Func LauchTroop($troopKind, $nbSides, $waveNb, $maxWaveNb, $slotsPerEdge=0)
   Local $troop = -1
   Local $troopNb = 0
   Local $name = ""
   For $i = 0 To 8 ; identify the position of this kind of troop
	  If $atkTroops[$i][0] = $troopKind Then
		 $troop = $i
		 $troopNb = Ceiling($atkTroops[$i][1]/$maxWaveNb)
		 Local $plural = 0
		 if $troopNb > 1 Then $plural = 1
		 $name = NameOfTroop($troopKind, $plural)
	  EndIf
   Next

   if ($troop = -1) Or ($troopNb = 0) Then
	  ;if $waveNb > 0 Then SetLog("Skipping wave of " & $name & " (" & $troopKind & ") : nothing to drop" )
	  Return False; nothing to do => skip this wave
   EndIf

   Local $waveName = "first"
   if $waveNb = 2 Then $waveName = "second"
   if $waveNb = 3 Then $waveName = "third"
   if $maxWaveNb = 1 Then $waveName = "only"
   if $waveNb = 0 Then $waveName = "last"
   SetLog("Dropping " & $waveName & " wave of " & $troopNb & " " & $name, $COLOR_GREEN)
   DropOnEdges($troop, $nbSides, $troopNb, $slotsPerEdge)
   Return True
EndFunc

Func algorithm_AllTroops() ;Attack Algorithm for all existing troops
		$King = -1
		$Queen = -1
		$CC = -1
	    For $i = 0 To 8
			If $atkTroops[$i][0] = $eCastle Then
				$CC = $i
			ElseIf $atkTroops[$i][0] = $eKing Then
				$King = $i
			ElseIf $atkTroops[$i][0] = $eQueen Then
				$Queen = $i
			EndIf
		 Next

		If _Sleep(2000) Then Return

If SearchTownHallLoc() AND GUICtrlRead($chkAttackTH)=$GUI_CHECKED Then
		 Switch $AttackTHType
		 Case 0
			   algorithmTH()
			   _CaptureRegion()
			   If _ColorCheck(_GetPixelColor(746,498), Hex(0x0E1306, 6), 20) Then AttackTHNormal() ;if 'no star' use another attack mode.
		 Case 1
			   AttackTHNormal();Good for Masters
		 Case 2
			   AttackTHXtreme();Good for Champ
			EndSwitch

		 While 1
			 _CaptureRegion()
			If _ColorCheck(_GetPixelColor(746,498), Hex(0x0E1306, 6), 20)=False Then ExitLoop ;exit if not 'no star'
			   _Sleep(1000)
		 WEnd

 		 If $OptBullyMode=0  And $OptTrophyMode=1 And SearchTownHallLoc() Then; Return ;Exit attacking if trophy hunting and not bullymode
			Click(62, 519) ;Click Surrender
			If _Sleep(3000) Then Return
			Click(512, 394) ;Click Confirm
			Return
		 EndIf
EndIf


	    Local $nbSides = 0
		Switch $deploySettings
			Case 0 ;Single sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking on a single side...")
				$nbSides = 1
			Case 1 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking on two sides...")
				$nbSides = 2
			Case 2 ;Three sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking on three sides...")
				$nbSides = 3
			Case 3 ;Two sides ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				SetLog("~Attacking on all sides...")
				$nbSides = 4
		 EndSwitch
		 if ($nbSides = 0) Then Return
		 If _Sleep(1000) Then Return

         ; ================================================================================?
         ; ========= Here is coded the main attack strategy ===============================
         ; ========= Feel free to experiment something else ===============================
         ; ================================================================================?
;         algorithmTH()
         if LauchTroop($eGiant, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eBarbarian, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eWallbreaker, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         if LauchTroop($eArcher, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         If LauchTroop($eBarbarian, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
            EndIf
         If LauchTroop($eGoblin, $nbSides, 1, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

		 $RandomEdge = $Edges[Round(Random(0, 3))]
		 $RandomXY = Round(Random(0, 4))
		 dropCC($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $CC)

         if LauchTroop($eHog, $nbSides, 1, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

         if LauchTroop($eWizard, $nbSides, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
			   
         if LauchTroop($eMinion, $nbSides, 1, 1) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf

         If LauchTroop($eArcher, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         If LauchTroop($eGoblin, $nbSides, 2, 2) Then
            If _Sleep(SetSleep(1)) Then Return
               EndIf
         ; ================================================================================?


		 Local $RandomEdge = $Edges[Round(Random(0, 3))]
		 Local $RandomXY = Round(Random(0, 4))
		 dropHeroes($RandomEdge[$RandomXY][0], $RandomEdge[$RandomXY][1], $King, $Queen)

		 If _Sleep(SetSleep(1)) Then Return

		If _Sleep(100) Then Return
		SetLog("Dropping left over troops", $COLOR_BLUE)
		For $x = 0 To 1
		   PrepareAttack(True) ;Check remaining quantities
		   For $i = $eBarbarian To $eWizard ; lauch all remaining troops
			  ;If $i = $eBarbarian Or $i = $eArcher Then
				 LauchTroop($i, $nbSides, 0, 1)
			  ;Else
			;	 LauchTroop($i, $nbSides, 0, 1, 2)
			  ;EndIf
			  If _Sleep(500) Then Return
		   Next
		Next

		;Activate KQ's power
		If ($checkKPower Or $checkQPower) and $iActivateKQCondition = "Manual" Then
			SetLog("Waiting " & $delayActivateKQ / 1000 & " seconds before activating Hero abilities", $COLOR_BLUE)
			_Sleep($delayActivateKQ)
			If $checkKPower Then
				SetLog("Activating King's power", $COLOR_BLUE)
				SelectDropTroop($King)
				$checkKPower = false
			EndIf
			If $checkQPower Then
				SetLog("Activating Queen's power", $COLOR_BLUE)
				SelectDropTroop($Queen)
				$checkQPower = false
			EndIf
		EndIf

		SetLog("~Finished Attacking, waiting to end battle", $COLOR_GREEN)
 EndFunc   ;==>algorithm_AllTroops
