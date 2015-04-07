;Saviart, edit by Hervidero

Func UpgradeWall ()

	IF GUICtrlRead ($chkWalls) = $GUI_CHECKED Then
		If $FreeBuilder > 0 Then
			SetLog("Checking Upgrade Walls", $COLOR_GREEN)

			$itxtWallMinGold = GUICtrlRead($txtWallMinGold)
			$itxtWallMinElixir = GUICtrlRead($txtWallMinElixir)

			Local $MinWallGold = Number($GoldCount - $Wallcost) > Number($itxtWallMinGold) ; Check if enough Gold
			Local $MinWallElixir = Number($ElixirCount - $Wallcost) > Number($itxtWallMinElixir) ; Check if enough Elixir

			If GUICtrlRead($UseGold) = $GUI_CHECKED Then
				$iUseStorage = 1
			ElseIf GUICtrlRead($UseElixir) = $GUI_CHECKED Then
				$iUseStorage = 2
			ElseIf GUICtrlRead($UseElixirGold) = $GUI_CHECKED Then
				$iUseStorage = 3
			EndIf

			Switch $iUseStorage
				Case 1
					If $MinWallGold Then
						SetLog("Upgrading Wall using Gold", $COLOR_GREEN)
						IF CheckWall() Then	UpgradeWallGold()
					Else
						SetLog("Gold is below minimum, Skip Upgrade", $COLOR_RED)
					EndIf
				Case 2
					If $MinWallElixir Then
						Setlog ("Upgrading Wall using Elixir",$COLOR_GREEN)
						IF CheckWall() Then	UpgradeWallElixir()
					Else
						Setlog ("Elixir is below minimum, Skip Upgrade", $COLOR_RED)
					Endif
				Case 3
					If $MinWallElixir Then
						SetLog("Upgrading Wall using Elixir",$COLOR_GREEN)
						IF CheckWall() and NOT UpgradeWallElixir() Then
							SetLog("Upgrade with Elixir failed, Trying upgrade using Gold",$COLOR_RED)
							UpgradeWallGold()
						EndIf
					Else
						SetLog("Elixir is below minimum, Trying upgrade using Gold", $COLOR_RED)
						If $MinWallGold Then
							IF CheckWall() Then	UpgradeWallGold()
						Else
							Setlog ("Gold is below minimum, Skip Upgrade", $COLOR_RED)
						EndIf
					EndIf
;				Case xxx OLD CASE 3
;					If $MinWallGold Then
;						SetLog("Upgrading Wall using Gold")
;						IF NOT UpgradeWallGold() Then
;							SetLog("Upgrade with Gold failed, Trying Upgrade using Elixir")
;							UpgradeWallElixir()
;						EndIf
;					Else
;						SetLog("Gold is below minimum, Trying upgrade using Elixir")
;						If $MinWallElixir Then
;							UpgradeWallElixir()
;						Else
;							Setlog ("Elixir is below minimum, Skip Upgrade", $COLOR_ORANGE)
;						EndIf
;					EndIf
			EndSwitch
			Click(1,1) ; click away
		Else
			SetLog("No free builder", $COLOR_RED)
		EndIf
	EndIf

EndFunc

Func UpgradeWallGold()

	Click($WallX, $WallY)
	If _Sleep(600) Then Return

	Local $offColors[3][3] = [[0x854833, 35, 33], [0xE2C73A, 70, 7], [0x2B2D1F, 76, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 600, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; first white pixel of button
	If IsArray($ButtonPixel) Then
		Click($ButtonPixel[0]+ 20, $ButtonPixel[1] + 20) ; Click Upgrade Gold Button
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) Then ; wall upgrade window red x
			Click(440, 480)
			If _Sleep(500) Then Return
			SetLog("Upgrade complete", $COLOR_GREEN)
			$wallgoldmake = $wallgoldmake + 1
			GUICtrlSetData ($lblWallgoldmake , $Wallgoldmake)
			Return True
		EndIf
	Else
		Setlog("No Upgrade Gold Button", $COLOR_RED)
		Return False
	EndIf

;		_CaptureRegion()
;		If _ColorCheck(_GetPixelColor(523, 641), Hex(0x000000, 6), 20) = False Then  ; checking wall level higher than level 8
;			If _ColorCheck(_GetPixelColor(500, 570), Hex(0xE70A12, 6), 20) or  _ColorCheck(_GetPixelColor(496, 570), Hex(0xE70A12, 6), 20)  Then
;				SetLog("Not enough Gold...", $COLOR_ORANGE)
;				Click(1, 1) ; click away
;				Return False
;			ElseIf _ColorCheck(_GetPixelColor(500, 570), Hex(0xFFFFFF, 6), 20) = True  or _ColorCheck(_GetPixelColor(583, 570), Hex(0xFFFFFF, 6), 20) = True  Then
;				Click(505, 596)
;				IF _Sleep(2000) Then Return
;				Click(472, 482)
;				SetLog("Upgrade done", $COLOR_GREEN)
;				Return True
;			Endif
;		Else
;			If _ColorCheck(_GetPixelColor(549, 570), Hex(0xE70A12, 6), 20) or  _ColorCheck(_GetPixelColor(540, 570), Hex(0xE70A12, 6), 20)  Then
;				SetLog("Not enough Gold...", $COLOR_ORANGE)
;				Click(1, 1)
;				Return False
;			ElseIf _ColorCheck(_GetPixelColor(549, 570), Hex(0xFFFFFF, 6), 20) or  _ColorCheck(_GetPixelColor(540, 570), Hex(0xFFFFFF, 6), 20)  Then
;				Click(505, 596)
;				IF _Sleep(2000) Then Return
;				Click(472, 482) ; Click Okay
;				SetLog("Upgrade done", $COLOR_GREEN)
;				Return True
;			EndIf
;		EndIf
;	EndIf

EndFunc

Func UpgradeWallElixir()

	Click($WallX, $WallY)
	If _Sleep(1000) Then Return

	Local $offColors[3][3] = [[0x854833, 35, 33], [0xEF6CEE, 70, 7], [0x2B2D1F, 76, 0]] ; 2nd pixel brown hammer, 3rd pixel gold, 4th pixel edge of button
	Global $ButtonPixel = _MultiPixelSearch(240, 563, 670, 600, 1, 1, Hex(0xF2F6F5, 6), $offColors, 30) ; first white pixel of button
	If IsArray($ButtonPixel) Then
		Click($ButtonPixel[0]+ 20, $ButtonPixel[1] + 20) ; Click Upgrade Elixir Button
		If _Sleep(1000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(685, 150), Hex(0xE1090E, 6), 20) Then
			Click(440, 480)
			If _Sleep(500) Then Return
			SetLog("Upgrade complete", $COLOR_GREEN)
			$wallelixirmake = $wallelixirmake + 1
			GUICtrlSetData ($lblWallelixirmake , $Wallelixirmake)
			Return True
		EndIf
	Else
		Setlog("No Upgrade Elixir Button", $COLOR_RED)
		Return False
	EndIf



;		_CaptureRegion()
;		If _ColorCheck(_GetPixelColor(596, 570), Hex(0xFFFFFF, 6), 20) = False Then
;			SetLog("Not enough Elixir...", $COLOR_ORANGE)
;			Click(1,1)
;			Return False
;		ElseIf _ColorCheck(_GetPixelColor(596, 570), Hex(0xFFFFFF, 6), 20) = True  or _ColorCheck(_GetPixelColor(583, 570), Hex(0xFFFFFF, 6), 20) = True Then
;			Click(560, 599)
;			If _Sleep(2000) Then Return
;			Click(472, 482)
;			SetLog("Upgrade done", $COLOR_GREEN)
;			Return True
;		EndIf
;	EndIf

EndFunc
