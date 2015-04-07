;GUI Design

;~ ------------------------------------------------------
;~ Main GUI
;~ ------------------------------------------------------
$frmBot = GUICreate($sBotTitle, 470, 605)
	GUISetIcon(@ScriptDir & "\Icons\cocbot.ico")
	TraySetIcon(@ScriptDir & "\Icons\cocbot.ico")
$tabMain = GUICtrlCreateTab(40, 85, 450, 395, BitOR($TCS_MULTILINE, $TCS_BUTTONS, $TCS_TOOLTIPS, $TCS_FIXEDWIDTH)) ;dont use as reference points (true size of tab = (150, 80, 450, 400)
	GUICtrlSetOnEvent(-1, "tabMain")
	;GUICtrlCreatePic (@ScriptDir & "\Icons\logo.jpg", 0, 0, 470, 80)
	Local $hGIF = _GUICtrlCreateGIF($sFile, "", 0, 0)
    GUICtrlSetTip($sFile, "Image")
	_ArrayConcatenate($G, $F)

;~ ------------------------------------------------------
;~ Lower part visible on all Tabs
;~ ------------------------------------------------------
;Local $btnColor = True
Local $btnColor = False

;~ Buttons
$grpButtons = GUICtrlCreateGroup("", 10, 490, 190, 85)
Local $x = 15, $y = 500
	$btnStart = GUICtrlCreateButton("Start Bot", $x, $y + 2, 90, 40)
		GUICtrlSetOnEvent(-1, "btnStart")
		IF $btnColor then GUICtrlSetBkColor(-1, 0x33CC33)
	$btnStop = GUICtrlCreateButton("Stop Bot", -1, -1, 90, 40)
		GUICtrlSetOnEvent(-1, "btnStop")
		IF $btnColor then GUICtrlSetBkColor(-1, 0xFA0334)
		GUICtrlSetState(-1, $GUI_HIDE)
 	$btnPause = GUICtrlCreateButton("Pause Bot", $x + 90, -1, 90, 40)
		$txtTip = "Use this to PAUSE all actions of the bot until you Resume."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnPause")
		IF $btnColor then GUICtrlSetBkColor(-1,  0xFFA500)
 		GUICtrlSetState(-1, $GUI_HIDE)
	$btnResume = GUICtrlCreateButton("Resume Bot", -1, -1, 90, 40)
 		$txtTip = "Use this to RESUME a paused Bot."
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnResume")
 		IF $btnColor then GUICtrlSetBkColor(-1,  0xFFA500)
 		GUICtrlSetState(-1, $GUI_HIDE)
	$btnHide = GUICtrlCreateButton("Hide BS", $x + 10, $y + 45, 70, -1)
		$txtTip = "Use this to move the BlueStacks Window out of sight." & @CRLF & "(Not minimized, but hidden)"
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "btnHide")
		IF $btnColor Then GUICtrlSetBkColor(-1, 0x22C4F5)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$chkBackground = GUICtrlCreateCheckbox("Background" & @CRLF & "Mode", $x + 100, $y + 48, 70, 20, BITOR($BS_MULTILINE, $BS_CENTER))
		$txtTip = "Check this to ENABLE the Background Mode of the Bot." & @CRLF & "With this you can also hide the BlueStacks window out of sight."
		GUICtrlSetFont(-1, 7)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetOnEvent(-1, "chkBackground")
		GUICtrlSetState(-1, $GUI_UNCHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)

#cs
;~ Max Trophy
$grpMaxTrophy = GUICtrlCreateButton("", 205, 495, 60, 80) ; fake (disabled) button: has rounded thick border and can have backgroundcolor
Local $x = 210, $y = 500
	IF $btnColor then GUICtrlSetBkColor(-1, 0xF4E27B)
		GUICtrlSetState(-1, $GUI_DISABLE) ; always disable!
	$lblMaxTrophy = GUICtrlCreateLabel("Max Trophy", $x + 5, $y + 5, 40, 35, $SS_CENTER)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$txtTip = "Bot will drop trophies if your trophy count is greater than this." & @CRLF & "You can edit this setting on the Misc Tab."
	GUICtrlSetTip(-1, $txtTip)
	$lblMaxTrophy2 = GUICtrlCreateLabel("", $x + 5, $y + 40, 40, 21)
		GUICtrlSetTip(-1, $txtTip)
;~ No close group, because actually disabled button border.. Not a real Group.
#ce

;~ Village
Local $x = 290, $y = 510
$grpVillage = GUICtrlCreateGroup("Village", $x - 20, $y - 20, 190, 85)
	$lblResultGoldNow = GUICtrlCreateLabel("", $x, $y + 2, 50, 15, $SS_RIGHT)
	$picResultGoldNow = GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x + 60, $y, 15, 15)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultGoldTemp = GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x - 5, $y, 15, 15)
	$lblResultElixirNow = GUICtrlCreateLabel("", $x, $y + 22, 50, 15, $SS_RIGHT)
	$picResultElixirNow = GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x + 60, $y + 20, 15, 15)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultElixirTemp = GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x - 5, $y + 20, 15, 15)
	$lblResultDENow = GUICtrlCreateLabel("", $x, $y + 42, 50, 15, $SS_RIGHT)
	$picResultDENow = GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", $x + 60, $y + 40, 15, 15)
		GUICtrlSetState(-1, $GUI_HIDE)
	$picResultDETemp = GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", $x - 5, $y + 40, 15, 15)
	$x += 80
	$lblResultTrophyNow = GUICtrlCreateLabel("", $x, $y + 2, 50, 15, $SS_RIGHT)
	$picResultTrophyNow = GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x + 59, $y , 20, 20)
	$lblResultBuilderNow = GUICtrlCreateLabel("", $x, $y + 22, 50, 15, $SS_RIGHT)
	$picResultBuilderNow = GUICtrlCreatePic (@ScriptDir & "\Icons\Builder.jpg", $x + 60, $y + 20, 18, 18)
	$lblResultGemNow = GUICtrlCreateLabel("", $x, $y + 42, 50, 15, $SS_RIGHT)
	$picResultGemNow = GUICtrlCreatePic (@ScriptDir & "\Icons\Gem.jpg", $x + 60, $y + 40, 18, 18)
	$x = 290
	$lblVillageReportTemp = GUICtrlCreateLabel("Village Report" & @CRLF & "will appear here" & @CRLF & "on first run.", $x + 27, $y + 5, 100, 45, BITOR($SS_CENTER, $BS_MULTILINE))
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ -------------------------------------------------------------
;~ This fake label is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $FirstControlToHide = GUICtrlCreateLabel("", 1, 1, 1, 1)
	GUICtrlSetState(-1, $GUI_HIDE)
;~ -------------------------------------------------------------

;~ -------------------------------------------------------
;~ General Tab
;~ -------------------------------------------------------

$tabGeneral = GUICtrlCreateTabItem("General")
	$txtLog = _GUICtrlRichEdit_Create($frmBot, "", 10, 140, 450, 290, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912), $WS_EX_STATICEDGE)
		_ArrayConcatenate($G, $A)
	$grpControls = GUICtrlCreateGroup("Halt Attack", 10, 435, 450, 50)
		$chkBotStop = GUICtrlCreateCheckbox("", 25, 455, 16, 16)
			$txtTip = "Use these options to set when the bot will stop attacking."
			GUICtrlSetTip(-1, $txtTip)
		$cmbBotCommand = GUICtrlCreateCombo("", 50, 452, 90, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "Halt Attack|Shutdown PC|Sleep PC", "Halt Attack")
		$lblBotCond = GUICtrlCreateLabel("When...", 155, 455, 45, 17)
		$cmbBotCond = GUICtrlCreateCombo("", 205, 452, 160, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "G and E Full and Max.Trophy|(G and E) Full or Max.Trophy|(G or E) Full and Max.Trophy|G or E Full or Max.Trophy|Gold and Elixir Full|Gold or Elixir Full|Gold Full and Max.Trophy|Elixir Full and Max.Trophy|Gold Full or Max.Trophy|Elixir Full or Max.Trophy|Gold Full|Elixir Full|Reach Max. Trophy|Bot running for...|Now (Train/Donate Only)", "Now (Train/Donate Only)")
			GUICtrlSetOnEvent(-1, "cmbBotCond")
		$cmbHoursStop = GUICtrlCreateCombo("", 365, 452, 80, 35, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "-|1 Hour|2 Hours|3 Hours|4 Hours|5 Hours|6 Hours|7 Hours|8 Hours|9 Hours|10 Hours|11 Hours|12 Hours|13 Hours|14 Hours|15 Hours|16 Hours|17 Hours|18 Hours|19 Hours|20 Hours|21 Hours|22 Hours|23 Hours|24 Hours", "-")
			GUICtrlSetState (-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Search Tab
;~ -------------------------------------------------------------

$tabSearch = GUICtrlCreateTabItem("Search")
	Local $x = 30, $y = 160
	$grpAttackMode = GUICtrlCreateGroup("Search Mode", $x - 20, $y - 20, 450, 120)
		$radDeadBases = GUICtrlCreateRadio("Dead Bases", $x, $y - 5, -1, -1)
			 $txtTip = "Search for a Base with Full Collectors and meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
		$y +=22
		$radWeakBases = GUICtrlCreateRadio("Weak Bases -->", $x, $y - 5, -1, -1)
			$txtTip =  "Search for a Base able to get 50% star and meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		$radAllBases = GUICtrlCreateRadio("All Bases", $x, $y -5, -1, -1)
			$txtTip = "Search for a Base that meets all search conditions."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 150, $y = 160
	$grpWeakBaseSettings = GUICtrlCreateGroup("", $x - 20, $y - 20, 330, 85)
		$txtTip = "Use these options to specify the WeakBase settings."
		$lblWBMortar = GUICtrlCreateLabel("Max. Mortar Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBMortar = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "5")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBWizTower = GUICtrlCreateLabel("Max. Wizard Tow. Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBWizTower = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8", "4")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBCannon = GUICtrlCreateLabel("Max. Cannon Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBCannon = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$x += 160
	$y = 160
	$lblWBArchTow = GUICtrlCreateLabel("Max. Archer Tow. Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBArchTow = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|10|11|12|13", "8")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBXBow = GUICtrlCreateLabel("Max. X-Bow Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBXbow = GUICtrlCreateCombo("", $x + 100, $y - 5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3|4", "0")
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=22
	$lblWBInferno = GUICtrlCreateLabel("Max. Inferno Lvl:", $x - 10, $y, -1, -1)
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$cmbWBInferno = GUICtrlCreateCombo("", $x + 100, $y -5, 35, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetTip(-1, $txtTip)
		GUICtrlSetData(-1, "0|1|2|3", "0")
		GUICtrlSetState(-1, $GUI_DISABLE)

#cs	Local $x = 30, $y = 230
		$chkBackToAllMode = GUICtrlCreateCheckbox("All Base after:", $x, $y, -1, -1)
			$txtTip = "Release Dead Base or Weak Base search and switch to All Base after No. of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkBackToAllMode")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$txtBackToAllMode = GUICtrlCreateInput("150", $x + 100, $y, 35, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "No. of searches to wait before activating."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblBackToAllMode = GUICtrlCreateLabel("search(es).", $x + 137, $y + 5, -1, -1)
#ce			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $x = 30, $y = 285
	$grpConditions = GUICtrlCreateGroup("Conditions", $x - 20, $y - 20, 220, 180)
		$y -= 5
		$chkMeetGxE = GUICtrlCreateRadio("Meet Gold and Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets BOTH the values set for Min. Gold, Elixir."
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetGorE = GUICtrlCreateRadio("Meet Gold or Elixir", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets ONE of the values set for Min. Gold, Elixir."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$y += 22
		$chkMeetDE = GUICtrlCreateCheckbox("Meet Dark Elixir", $x , $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Dark Elixir."
			GUICtrlSetOnEvent(-1, "chkMeetDE")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTrophy = GUICtrlCreateCheckbox("Meet Trophy Count", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Min. Trophies."
			GUICtrlSetOnEvent(-1, "chkMeetTrophy")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTH = GUICtrlCreateCheckbox("Meet Townhall Level", $x, $y, -1, -1)
			$txtTip = "Search for a base that meets the value set for Max. Townhall Level."
			GUICtrlSetOnEvent(-1, "chkMeetTH")
			GUICtrlSetTip(-1, $txtTip)
		$y += 22
		$chkMeetTHO = GUICtrlCreateCheckbox("Meet Townhall Outside", $x, $y, -1, -1)
			$txtTip = "Search for a base that has an exposed Townhall. (Outside of Walls)"
			GUICtrlSetTip(-1, $txtTip)
		$y += 27
		$chkMeetOne = GUICtrlCreateCheckbox("Meet One Then Attack", $x, $y, -1, -1)
			$txtTip = "Just meet only ONE of the above conditions, then Attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 465
	$grpAlert = GUICtrlCreateGroup("", $x - 20, $y - 20, 100, 40)
		$chkAlertSearch = GUICtrlCreateCheckbox("Alert me", $x, $y - 8, -1, -1, $BS_MULTILINE)
			GUICtrlSetTip(-1, "Check this if you want an Audio alarm & a Balloon Tip when a Base to attack is found.")
			GUICtrlSetState(-1, $GUI_CHECKED)
		$btnSearchMode = GUICtrlCreateButton("Search Mode", $x + 90, $y -10, 100, 25)
			GUICtrlSetOnEvent(-1, "btnSearchMode")
			GUICtrlSetTip(-1, "Does not attack. Searches for a Village that meets conditions.")

Local $x = 255, $y = 285
	$grpResources = GUICtrlCreateGroup("Values", $x - 20, $y - 20, 225, 130)
		$lblMinGold = GUICtrlCreateLabel("Minimum Gold: ", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Gold to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinGold = GUICtrlCreateInput("80000", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$y += 22
		$lblMinElixir = GUICtrlCreateLabel("Minimum Elixir:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinElixir = GUICtrlCreateInput("80000", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 6)
		$y += 22
		$lblMinDarkElixir = GUICtrlCreateLabel("Minimum Dark Elixir:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Dark Elixir to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinDarkElixir = GUICtrlCreateInput("0", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
			_GUICtrlEdit_SetReadOnly(-1, True)
		$y += 22
		$lblMinTrophy = GUICtrlCreateLabel("Minimum Trophy Count:", $x, $y, -1, -1)
			$txtTip = "Set the Min. amount of Trophies to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$txtMinTrophy = GUICtrlCreateInput("0", $x + 130, $y - 5, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlEdit_SetReadOnly(-1, True)
			GUICtrlSetLimit(-1, 2)
		$y += 22
		$lblMinTH = GUICtrlCreateLabel("Maximum Townhall Level:", $x, $y, -1, -1)
			$txtTip = "Set the Max. level of the Townhall to search for on a village to attack."
			GUICtrlSetTip(-1, $txtTip)
		$cmbTH = GUICtrlCreateCombo("", $x + 130, $y - 5, 61, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y = 420
	$grpSearchReduction = GUICtrlCreateGroup("Search Reduction", $x - 20, $y - 20, 225, 85)
		$y -= 5
		$chkSearchReduction = GUICtrlCreateCheckbox("Auto Reduce", $x , $y, -1, -1)
			$txtTip = "Check this if you want the search values to automatically be reduced after a certain amount of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetOnEvent(-1, "chkSearchReduction")
		$lblSearchReduceCount = GUICtrlCreateLabel("Search(es):", $x + 95, $y + 5, -1, 17)
		$txtSearchReduceCount = GUICtrlCreateInput("20", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Enter the No. of searches to wait before each reduction occures."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$y += 22
		$lblSearchReduceGold = GUICtrlCreateLabel("Gold:", $x + 30, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Gold by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceGold = GUICtrlCreateInput("2000", $x + 65, $y, 40, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$lblSearchReduceDark = GUICtrlCreateLabel("Dark:", $x + 115, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Dark Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceDark = GUICtrlCreateInput("100", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
		$y += 22
		$lblSearchReduceElixir = GUICtrlCreateLabel("Elixir:", $x + 30, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Elixir by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceElixir = GUICtrlCreateInput("2000", $x + 65, $y, 40, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 5)
		$lblSearchReduceTrophy = GUICtrlCreateLabel("Trophy:", $x + 115, $y + 5, -1, 17)
			$txtTip = "Reduce the Minimal Values for Trophies by this amount on each step."
			GUICtrlSetTip(-1, $txtTip)
		$txtSearchReduceTrophy = GUICtrlCreateInput("2", $x + 155, $y, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 1)



	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
; Attack Basics Tab
;~ -------------------------------------------------------------

$tabAttack = GUICtrlCreateTabItem("Attack Basics")
	Local $x = 30, $y = 155
	$grpDeploy = GUICtrlCreateGroup("Deploy", $x - 20, $y - 15, 450, 85)
		$lblDeploy = GUICtrlCreateLabel("Attack on:", $x, $y + 5, -1, -1)
		$cmbDeploy = GUICtrlCreateCombo("", $x + 60, $y, 250, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Attack on a single side, penetrates through base" & @CRLF & "Attack on two sides, penetrates through base" & @CRLF & "Attack on three sides, gets outer and some inside of base" & @CRLF & "Attack on all sides equally, gets most of outer base", "Select the No. of sides to attack on.")
			GUICtrlSetData(-1, "a single side, penetrates through base|two sides, penetrates through base|three sides, gets outer and some inside of base|all sides equally, gets most of outer base", "all sides equally, gets most of outer base")
		$y += 35
		$txtTip = "This delays the deployment of troops, 1 (fast) = like a Bot, 10 (slow) = Like a Human." & @CRLF & "Random will make bot more varied and closer to a person."
		$lblUnitDelay = GUICtrlCreateLabel("Unit Delay:", $x, $y + 5, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$cmbUnitDelay = GUICtrlCreateCombo("", $x + 60, $y, 40, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$lblWaveDelay = GUICtrlCreateLabel("Wave Delay:", $x + 120, $y + 5, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$cmbWaveDelay = GUICtrlCreateCombo("", $x + 190, $y, 40, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10", "5")
		$Randomspeedatk = GUICtrlCreateCheckbox("Random", $x + 250, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "Randomspeedatk")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 250
	$grpKing = GUICtrlCreateGroup("King", $x - 20, $y -20, 145, 85)
		$txtTip = "Use your King in this Attack Mode."
		GUICtrlCreatePic (@ScriptDir & "\Icons\King.jpg", $x - 10 , $y + 15 , 25, 25)
		$chkKingAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", $x + 20, $y - 2, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkKingAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", $x + 20, $y + 18, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkKingAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", $x + 20, $y + 38, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpQueen = GUICtrlCreateGroup("Queen", $x + 130, $y - 20, 150, 85)
		$txtTip = "Use your Queen in this Attack Mode."
		GUICtrlCreatePic (@ScriptDir & "\Icons\Queen.jpg", $x + 140, $y + 15, 25, 25)
		$chkQueenAttackDeadBases = GUICtrlCreateCheckbox("Atk Dead Bases", $x + 170, $y - 2, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
		$chkQueenAttackWeakBases = GUICtrlCreateCheckbox("Atk Weak Bases", $x + 170, $y + 18, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkQueenAttackAllBases = GUICtrlCreateCheckbox("Atk All Bases", $x + 170, $y + 38, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$grpClanCastle = GUICtrlCreateGroup("Clan Castle", $x + 285, $y - 20, 145, 85)
		GUICtrlCreatePic (@ScriptDir & "\Icons\ClanCastle.jpg", $x + 290, $y +15, 27, 27)
		$chkUseClanCastle = GUICtrlCreateCheckbox("Drop in Battle", $x + 325, $y + 17, -1, -1)
			GUICtrlSetTip(-1, "Drop your Clan Castle in battle if it contains troops.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
  Local $x = 30, $y = 340
	$grpRoyalAbilities = GUICtrlCreateGroup("Hero Abilities", $x - 20, $y -20, 450, 70)
		GUICtrlCreatePic (@ScriptDir & "\Icons\KingAbility.jpg", $x -10, $y - 8, 30, 47)
		GUICtrlCreatePic (@ScriptDir & "\Icons\QueenAbility.jpg", $x + 20, $y - 8, 30, 47)
		$x +=55
		$radManAbilities = GUICtrlCreateRadio("Timed activation of Hero Abilities after:", $x, $y - 2, -1, -1)
        $txtTip = "Activate the Ability on a timer." & @CRLF & "Both Heroes are activated at the same time."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$radAutoAbilities = GUICtrlCreateRadio("Auto activate Hero Abilities when they become weak (red zone).", $x, $y + 20, -1, -1)
		$txtTip = "Activate the Ability when the Hero becomes weak." & @CRLF & "King and Queen are checked and activated individually."
		GUICtrlSetTip(-1, $txtTip)
		$txtManAbilities = GUICtrlCreateInput("9", $x + 200, $y - 3, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "Set the time in seconds for Timed Activation of Hero Abilities."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 2)
		$lblRoyalAbilitiesSec = GUICtrlCreateLabel("sec.", $x + 235, $y + 2, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 415
	$grpBattleOptions = GUICtrlCreateGroup("Battle Options", $x - 20, $y - 20, 300, 90)
		;$chkTimeStopAtk = GUICtrlCreateCheckbox("End Battle, if no new loot raided within:", $x, $y, -1, -1)
		$lblTimeStopAtk = GUICtrlCreateLabel("End Battle, if no new loot raided within:", $x +15, $y+5, -1, -1)
			$txtTip = "End Battle if there is no extra loot raided within this No. of seconds." & @CRLF & "Countdown is started after all Troops and Royals are deployed in battle."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
		$txtTimeStopAtk = GUICtrlCreateInput("20", $x + 200, $y, 30, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 2)
		$lblTimeStopAtk = GUICtrlCreateLabel("sec.", $x + 235, $y + 5, -1, -1)
#cs
		$chkEndOneStar = GUICtrlCreateCheckbox("End Battle, when One Star is won", $x, $y + 20, -1, -1)
			$txtTip = "Will End the Battle if 1 star is won in battle"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkEndTwoStar = GUICtrlCreateCheckbox("End Battle, when Two Stars are won", $x, $y + 40, -1, -1)
			$txtTip = "Will End the Battle if 2 stars are won in battle"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x +=305
	$grpLootSnapshot = GUICtrlCreateGroup("Loot Snapshot", $x - 20, $y - 20, 145, 90)
		$chkTakeLootSS = GUICtrlCreateCheckbox("Take Loot Snapshot", $x, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this if you want to save a Loot snapshot of the Village that was attacked.")
			GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Attack Advanced Tab
;~ -------------------------------------------------------------
 $tabAttackAdv = GUICtrlCreateTabItem("Attack Adv.")
	Local $x = 30, $y = 160
	$grpAtkOptions = GUICtrlCreateGroup("Attack Options", $x - 20, $y - 20, 450, 120)
		$chkAttackTH = GUICtrlCreateCheckbox("Attack Townhall Outside", $x, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to Attack an exposed Townhall first. (Townhall outside of Walls)" & @CRLF & "TIP: Also tick 'Meet Townhall Outside' on the Search tab if you only want to search for bases with exposed Townhalls.")
		$y +=22
		$chkLightSpell = GUICtrlCreateCheckbox("Hit Dark Elixir storage with Lightning Spell", $x, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this if you want to use lightning spells to steal Dark Elixir when bot meet Minimum Dark Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=27
		$chkWithKing = GUICtrlCreateCheckbox("Attack their King", $x, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		$chkWithQueen = GUICtrlCreateCheckbox("Attack their Queen", $x, $y, -1, -1)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 285
	$grpAtkCombos = GUICtrlCreateGroup("Advanced Attack Combo's", $x - 20, $y - 20, 450, 125)
		$chkBullyMode = GUICtrlCreateCheckbox("TH Bully after:", $x, $y, -1, -1)
			$txtTip = "Adds the TH Bully combo to the current search settings. (Example: Deadbase OR TH Bully)" & @CRLF & _
				"TH Bully: Attacks a lower townhall level after the specified No. of searches."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkBullyMode")
		$txtATBullyMode = GUICtrlCreateInput("150", $x + 100, $y, 60, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			$txtTip = "TH Bully: No. of searches to wait before activating."
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblATBullyMode = GUICtrlCreateLabel("search(es).", $x + 165, $y + 5, -1, -1)
		$y +=22
		$lblATBullyMode = GUICtrlCreateLabel("Max TH lvl:", $x + 20, $y + 5, -1, -1, $SS_RIGHT)
		$cmbYourTH = GUICtrlCreateCombo("", $x + 100, $y, 60, -1, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			$txtTip = "TH Bully: Max. Townhall level to bully."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetData(-1, "4-6|7|8|9|10", "4-6")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y+=27
		$chkTrophyMode = GUICtrlCreateCheckbox("TH Snipe within:", $x, $y, -1, -1)
			$txtTip = "Adds the TH Snipe combination to the current search settings. (Example: Deadbase OR TH Snipe)"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSnipeMode")
		$lblTHaddtiles = GUICtrlCreateLabel( "tiles.", $x + 165, $y + 5, 90, 17)
		$txtTHaddtiles = GUICtrlCreateInput("1", $x + 100, $y, 60, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y+=22
		$lblAttackTHType = GUICtrlCreateLabel("Attack Type:", $x + 20 , $y + 5, -1, 17, $SS_RIGHT)
		$cmbAttackTHType = GUICtrlCreateCombo("",  $x + 100, $y, 120, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetData(-1, "Barch|Attack1:Normal|Attack2:eXtreme", "Attack1:Normal")
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Donate Tab
;~ -------------------------------------------------------------
$tabDonate = GUICtrlCreateTabItem("Donate")
	Local $x = 30, $y = 160
	$grpDonation = GUICtrlCreateGroup("Clan Castle", $x - 20, $y - 20, 450, 50)
		GUICtrlCreatePic (@ScriptDir & "\Icons\ClanCastle.jpg", $x - 14, $y - 5, 29, 29)
		$chkRequest = GUICtrlCreateCheckbox("Request for:", $x + 20, $y, -1, -1)
			GUICtrlSetOnEvent(-1, "chkRequest")
		$txtRequest = GUICtrlCreateInput("Anything please", $x + 105, $y, 315, -1)
			GUICtrlSetTip(-1, "This text is used on your request for troops in the Clan chat.")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y += 55
	$grpBarbarians = GUICtrlCreateGroup("Barbarians", $x - 20, $y - 20, 150, 290)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Barbarian_D.jpg", $x - 12, $y, 30, 40)
				$chkDonateBarbarians = GUICtrlCreateCheckbox("Donate Barbarians", $x + 20, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Barbarians if below keywords are found in the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateBarbarians")
		$chkDonateAllBarbarians = GUICtrlCreateCheckbox("Donate to All", $x + 20, $y + 20, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Barbarians to ALL Chat Requests.")
			GUICtrlSetOnEvent(-1, "chkDonateAllBarbarians")
		$txtDonateBarbarians = GUICtrlCreateEdit("", $x - 10, $y + 50, 130, 205, BitOR($ES_WANTRETURN, $ES_CENTER))
			GUICtrlSetData(-1, StringFormat("barbarians\r\nbarb"))
			GUICtrlSetTip(-1, "Keywords for donating Barbarians")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 155
	$grpArchers = GUICtrlCreateGroup("Archers", $x - 20, $y - 20, 145, 290)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Archer_D.jpg", $x - 12, $y, 30, 40)
		$chkDonateArchers = GUICtrlCreateCheckbox("Donate Archers", $x + 20, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Archers if below keywords are found in the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateArchers")
		$chkDonateAllArchers = GUICtrlCreateCheckbox("Donate to All", $x + 20, $y + 20, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Archers to ALL Chat Requests.")
			GUICtrlSetOnEvent(-1, "chkDonateAllArchers")
		$txtDonateArchers = GUICtrlCreateEdit("", $x - 10, $y + 50, 125, 205, BitOR($ES_WANTRETURN, $ES_CENTER))
			GUICtrlSetData(-1, StringFormat("archers\r\narch\r\nany\r\nreinforcement\r\ndef"))
			GUICtrlSetTip(-1, "Keywords for donating Archers")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 150
	$grpGiants = GUICtrlCreateGroup("Giants", $x - 20, $y - 20, 145, 290)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Giant_D.jpg", $x - 12, $y, 30, 40)
		$chkDonateGiants = GUICtrlCreateCheckbox("Donate Giants", $x + 20, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Giants if below keywords are found in the Chat Request.")
			GUICtrlSetOnEvent(-1, "chkDonateGiants")
		$chkDonateAllGiants = GUICtrlCreateCheckbox("Donate to All", $x + 20, $y + 20, -1, -1)
			GUICtrlSetTip(-1, "Check this to donate Giants to ALL Chat Requests.")
			GUICtrlSetOnEvent(-1, "chkDonateAllGiants")
		$txtDonateGiants = GUICtrlCreateEdit("", $x - 10, $y + 50, 125, 205, BitOR($ES_WANTRETURN, $ES_CENTER))
			GUICtrlSetData(-1, StringFormat("giants\r\ngiant\r\nany\r\nreinforcement"))
			GUICtrlSetTip(-1, "Keywords for donating Giants")
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Troops Tab
;~ -------------------------------------------------------------
$tabTroops = GUICtrlCreateTabItem("Troops")
	Local $x = 30, $y = 160
	$grpTroopComp = GUICtrlCreateGroup("Army Composition", $x - 20, $y - 20, 222, 55)
		$cmbTroopComp = GUICtrlCreateCombo("", $x, $y, 180, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			TrayTip("GameBot.org", "Stay Informed Of New Releases" & @CRLF & "http://gamebot.org/latest", 100)
			GUICtrlSetTip(-1, "Set the type of Army composition." & @CRLF & "'Use Barracks Mode' or 'Custom Army' is for manual compositions.")
			GUICtrlSetOnEvent(-1, "cmbTroopComp")
			GUICtrlSetData(-1, "Preset: Archers|Preset: Barbarians|Preset: Goblins|Preset: B.Arch|Preset: B.A.G.G.|Preset: B.A.Giant|Preset: B.A.Goblin|Preset: B.A.G.G.Wall|Use Barrack Mode|Custom Army", "Custom Army")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x += 227
	$grpBarrackMode = GUICtrlCreateGroup("Barrack Mode", $x - 20, $y -20, 223, 75)
		$lblBarrack1 = GUICtrlCreateLabel("1:", $x - 5, $y + 5, -1, -1)
		$cmbBarrack1 = GUICtrlCreateCombo("", $x + 10, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 1.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Barbarians") ; "Barbarians|Archers|Giants|Goblins"
		$y += 2
		$lblBarrack2 = GUICtrlCreateLabel("2:", $x - 5, $y + 26, -1, -1)
		$cmbBarrack2 = GUICtrlCreateCombo("", $x + 10, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 2.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Archers") ; "Barbarians|Archers|Giants|Goblins"
		$y -= 2
		$lblBarrack3 = GUICtrlCreateLabel("3:", $x + 100, $y + 5, -1, -1)
		$cmbBarrack3 = GUICtrlCreateCombo("", $x + 115, $y, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 3.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Archers") ; "Barbarians|Archers|Giants|Goblins"
		$y += 2
		$lblBarrack4 = GUICtrlCreateLabel("4:", $x + 100, $y + 26, -1, -1)
		$cmbBarrack4 = GUICtrlCreateCombo("", $x + 115, $y + 21, 75, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			GUICtrlSetTip(-1, "Set the Troops to make in Barrack 4.")
			GUICtrlSetData(-1, "Barbarians|Archers|Giants|Goblins", "Goblins") ; "Barbarians|Archers|Giants|Goblins"
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$y -= 2
	$y += 80
	$grpBoosterOptions = GUICtrlCreateGroup("Boost Options", $x-20, $y-20, 223, 85)
;        $chkFullTroop = GUICtrlCreateCheckbox("Atk only Full Army, not 95% (default)", $x, $y, -1, -1)
;        $txtTip = "Attack with full troop only"
;        GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreatePic (@ScriptDir & "\Icons\2Swords.jpg", $x, $y + 2, 18, 18)
	$lblFullTroop = GUICtrlCreateLabel("Raid when Troops reach:",$x + 25, $y + 5, -1, 17)
	$txtFullTroop = GUICtrlCreateInput("100",  $x + 150, $y, 35, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		GUICtrlSetTip(-1, "Enter percentage")
		GUICtrlSetLimit(-1, 3)
	$lblFullTroop = GUICtrlCreateLabel("%",$x + 188, $y + 5, -1, 17)

 	GUICtrlCreatePic (@ScriptDir & "\Icons\Gem.jpg", $x, $y + 27, 18, 18)
	$lblBoostBarracks = GUICtrlCreateLabel("Barracks Boosts left:", $x + 25, $y + 30, 100, 17)
		$txtTip = "Use this to boost your Barracks with GEMS! Use with caution!"
		GUICtrlSetTip(-1, $txtTip)
	$cmbBoostBarracks = GUICtrlCreateCombo("", $x + 150, $y + 25, 35, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
		GUICtrlSetData(-1, "0|1|2|3|4|5", "0")
		GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 220
	$grpTroops = GUICtrlCreateGroup("Troops", $x - 20, $y - 20, 222, 105)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Barbarian.jpg", $x, $y - 3, 22, 22)
		$lblBarbarians = GUICtrlCreateLabel("Barbarians:", $x + 25, $y, -1, -1)
		$txtBarbarians = GUICtrlCreateInput("30", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Barbarians to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblPercentBarbarians = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Archer.jpg", $x, $y - 3, 22, 22)
		$lblArchers = GUICtrlCreateLabel("Archers:", $x + 25, $y, -1, -1)
		$txtArchers = GUICtrlCreateInput("60", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Archers to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblPercentArchers = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Goblin.jpg", $x, $y - 3, 22, 22)
		$lblGoblins = GUICtrlCreateLabel("Goblins:", $x + 25, $y, -1, -1)
		$txtGoblins = GUICtrlCreateInput("10", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Set the % of Goblins to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "lblTotalCount")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblPercentGoblins = GUICtrlCreateLabel("%", $x + 188, $y, -1, -1)
		$y += 22
		$lblTotal = GUICtrlCreateLabel("Total:", $x + 95, $y - 5, -1, -1, $SS_RIGHT)
		$lblTotalCount = GUICtrlCreateLabel("100", $x + 130, $y - 5, 55, 15, $SS_CENTER)
			GUICtrlSetBkColor (-1, $COLOR_MONEYGREEN) ;lime, moneygreen
		$lblPercentTotal = GUICtrlCreateLabel("%", $x + 188, $y - 5, -1, -1)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 330
	$grpOtherTroops = GUICtrlCreateGroup("Add. Troops", $x - 20, $y - 20, 222, 175)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Giant.jpg", $x, $y - 3, 22, 22)
		$lblGiants = GUICtrlCreateLabel("No. of Giants:", $x + 25, $y, -1, -1)
		$txtNumGiants = GUICtrlCreateInput("4", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Giants to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\WallBreaker.jpg", $x, $y - 3, 22, 22)
		$lblWallBreakers = GUICtrlCreateLabel("No. of Wall Breakers:", $x + 25, $y, -1, -1)
		$txtNumWallbreakers = GUICtrlCreateInput("4", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Wall Breakers to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
#cs		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Balloon.jpg", $x, $y - 3, 20, 20)
		$lblBalloons = GUICtrlCreateLabel("No. of Balloons:", $x + 25, $y, -1, -1)
		$txtNumBalloons = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Balloons to make.")
			GUICtrlSetLimit(-1, 3)
#ce			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Wizard.jpg", $x, $y - 3, 22, 22)
		$lblWizards = GUICtrlCreateLabel("No. of Wizards:", $x + 25, $y, -1, -1)
		$txtNumWizards = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Wizards to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
#cs		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Healer.jpg", $x, $y - 3, 20, 20)
		$lblHealers = GUICtrlCreateLabel("No. of Healers:", $x + 25, $y, -1, -1)
		$txtNumHealers = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Healers to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Dragon.jpg", $x, $y - 3, 20, 20)
		$lblDragons = GUICtrlCreateLabel("No. of Dragons:", $x + 25, $y, -1, -1)
		$txtNumDragons = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Wizards to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Pekka.jpg", $x, $y - 3, 20, 20)
		$lblPekka = GUICtrlCreateLabel("No. of P.E.K.K.A.:", $x + 25, $y, -1, -1)
		$txtNumPekka = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of P.E.K.K.A. to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x +=  227
	$y = 330
	$grpDarkTroops = GUICtrlCreateGroup("Add. Dark Troops", $x - 20, $y - 20, 223, 175)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Minion.jpg", $x, $y - 3, 22, 22)
		$lblMinion = GUICtrlCreateLabel("No. of Minions:", $x + 25, $y, -1, -1)
		$txtNumMinions = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Minions to make.")
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\HogRider.jpg", $x, $y - 3, 22, 22)
		$lblHogRiders = GUICtrlCreateLabel("No. of Hog Riders:", $x + 25, $y, -1, -1)
		$txtNumHogs = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Hog Riders to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
#cs		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Valkyrie.jpg", $x, $y - 3, 20, 20)
		$lblValkyries = GUICtrlCreateLabel("No. of Valkyries:", $x + 25, $y, -1, -1)
		$txtNumValkyries = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Valkyries to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Golem.jpg", $x, $y - 3, 20, 20)
		$lblGolems = GUICtrlCreateLabel("No. of Golems:", $x + 25, $y, -1, -1)
		$txtNumGolems = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Golems to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\Witch.jpg", $x, $y - 3, 20, 20)
		$lblWitches = GUICtrlCreateLabel("No. of Witches:", $x + 25, $y, -1, -1)
		$txtNumWitches = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Hog Riders to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=22
		GUICtrlCreatePic (@ScriptDir & "\Icons\LavaHound.jpg", $x, $y - 3, 20, 20)
		$lblLavaHounds = GUICtrlCreateLabel("No. of Lava Hounds:", $x + 25, $y, -1, -1)
		$txtNumLavaHounds = GUICtrlCreateInput("0", $x + 130, $y - 5, 55, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
			GUICtrlSetTip(-1, "Enter the No. of Hog Riders to make.")
			GUICtrlSetLimit(-1, 2)
			GUICtrlSetState(-1, $GUI_DISABLE)
#ce
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
; Misc Tab
;~ -------------------------------------------------------------
$tabMisc = GUICtrlCreateTabItem("Misc")
Local $x = 30, $y = 160
	$grpWalls = GUICtrlCreateGroup("Walls", $x - 20, $y - 20, 450, 120)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Wall.jpg", $x - 10, $y, 22, 22)
		$chkWalls = GUICtrlCreateCheckbox("Auto Wall Upgrade", $x + 20, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to upgrade Walls if there are enough resources.")
			GUICtrlSetState(-1, $GUI_ENABLE)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetOnEvent(-1, "chkWalls")
			_ArrayConcatenate($G, $B)
		$UseGold = GUICtrlCreateRadio("Use Gold", $x + 35, $y + 25, -1, -1)
			GUICtrlSetTip(-1, "Use only Gold for Walls." & @CRLF & "Available at all Wall levels.")
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixir = GUICtrlCreateRadio("Use Elixir", $x + 35, $y + 45, -1, -1)
			GUICtrlSetTip(-1, "Use only Elixir for Walls." & @CRLF & "Available only at Wall levels upgradeable with Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$UseElixirGold = GUICtrlCreateRadio("Try Elixir first, Gold second", $x + 35, $y + 65, -1, -1)
			GUICtrlSetTip(-1, "Try to use Elixir first. If not enough Elixir try to use Gold second for Walls." & @CRLF & "Available only at Wall levels upgradeable with Elixir.")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblWalls = GUICtrlCreateLabel("Search for Walls level:", $x + 220, $y +5, -1, -1)
		$cmbWalls = GUICtrlCreateCombo("", $x + 330, $y, 61, 21, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL), $WS_EX_RIGHT)
			GUICtrlSetTip(-1, "Search for Walls of this level and try to upgrade them one by one.")
			GUICtrlSetData(-1, "4   |5   |6   |7   |8   |9   |10   ", "4   ")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbWalls")
			_ArrayConcatenate($G, $C)
		$lblTxtWallCost = GUICtrlCreateLabel("Next Wall level costs:", $x + 220,  $y + 25, -1, -1)
			GUICtrlSetTip(-1, "Use this value as an indicator." &@CRLF & "The value will update if you select an other wall level.")
		$lblWallCost = GUICtrlCreateLabel("30 000", $x + 330, $y + 25, 50, -1, $SS_RIGHT)
			GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x + 220, $y + 47, 17, 17)
		$WallMinGold = GUICtrlCreateLabel("Min. Gold to save:", $x + 240, $y + 50, -1, -1)
		$txtWallMinGold = GUICtrlCreateInput("250000", $x + 330, $y + 45, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Gold in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$y +=2
		GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x + 220, $y + 67, 17, 17)
		$WallMinElixir = GUICtrlCreateLabel("Min. Elixir to save:", $x + 240, $y + 70, -1, -1)
		$txtWallMinElixir = GUICtrlCreateInput("250000", $x + 330, $y + 65, 61, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetTip(-1, "Save at least this amount of Elixir in your Storages." & @CRLF & "Set this value higher if you want to upgrade other stuff.")
			GUICtrlSetLimit(-1, 7)
			GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 285
	$grpTraps = GUICtrlCreateGroup("Traps, X-bows && Inferno's", $x -20, $y - 20 , 222, 50)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trap.jpg", $x - 16, $y, 22, 22)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Xbows.jpg", $x + 7, $y, 22, 22)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Inferno.jpg", $x + 30, $y - 9, 22, 31)
		$chkTrap = GUICtrlCreateCheckbox("Auto Rearm && Reload", $x + 55, $y, -1, -1)
			GUICtrlSetTip(-1, "Check this to automatically Rearm Traps, Reload Xbows and Infernos (if any) in your Village.")
			GUICtrlSetOnEvent(-1, "chkTrap")
			_ArrayConcatenate($G, $D)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 345
	$grpCollect = GUICtrlCreateGroup("Collecting Resources", $x - 20, $y - 20 , 222, 50)
		GUICtrlCreatePic (@ScriptDir & "\Icons\GoldMine.jpg", $x - 16, $y, 22, 22)
		GUICtrlCreatePic (@ScriptDir & "\Icons\ElixirCollector.jpg", $x + 7, $y, 22, 22)
		GUICtrlCreatePic (@ScriptDir & "\Icons\DarkElixirDrill.jpg", $x + 30, $y, 22, 22)
		$chkCollect = GUICtrlCreateCheckbox("Auto Collect Resources", $x + 55, $y, -1, -1)
			$txtTip = "Check this to automatically collect the Village's Resources" & @CRLF & " from Gold Mines, Elixir Collectors and Dark Elixir Drills."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y =405
	$grpTimeWakeUp = GUICtrlCreateGroup("Remote Device", $x - 20, $y - 20 , 222, 45)
            $lblTimeWakeUp = GUICtrlCreateLabel("When 'Another Device' wait:", $x, $y, -1, -1)
			$txtTip = "Enter the time to wait (in seconds) before the Bot reconnects when another device took control."
			GUICtrlSetTip(-1, $txtTip)
		        $txtTimeWakeUp = GUICtrlCreateInput("120", $x + 138, $y - 5, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		        $lblTimeWakeUpSec = GUICtrlCreateLabel("sec.", $x + 175, $y, -1, -1)

      GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 3)
	          $lblTimeWakeUpSec = GUICtrlCreateLabel("sec.", $x + 175, $y, -1, -1)
      GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 30, $y = 455
	$grpVSDelay = GUICtrlCreateGroup(" Village Search Delay ", $x - 20, $y - 20, 220, 50)
		$txtTip = "Use this slider to change the time to wait between Next clicks when searching for a Village to Attack." & @CRLF & "This might compensate for Out of Sync errors on some PC's." & @CRLF & "NO GUARANTEES! This will not always have the same results!"
		$lblVSDelay = GUICtrlCreateLabel("1", $x, $y, 12, 15, $SS_RIGHT)
			GUICtrlSetTip(-1, $txtTip)
		$lbltxtVSDelay = GUICtrlCreateLabel("second", $x + 15, $y, 50, -1)
		$sldVSDelay = GUICtrlCreateSlider($x + 55, $y - 5, 130, 25, BITOR($TBS_TOOLTIPS, $TBS_AUTOTICKS)) ;,
			GUICtrlSetTip(-1, $txtTip)
			_GUICtrlSlider_SetTipSide(-1, $TBTS_BOTTOM)
			_GUICtrlSlider_SetTicFreq(-1, 1)
			GUICtrlSetLimit(-1, 10, 1) ; change max/min value
			GUICtrlSetData(-1, 1) ; default value 3
			GUICtrlSetOnEvent(-1, "sldVSDelay")
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 260, $y = 285
	$grpTrophy = GUICtrlCreateGroup("Trophy Settings", $x - 20, $y - 20, 220, 70)
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x + 20, $y + 5, 25, 25)
		$lblMaxTrophy = GUICtrlCreateLabel("Max:", $x+70, $y, -1, -1)
			$txtTip = "The Bot will drop trophies if your trophy count is greater than this."
			GUICtrlSetTip(-1, $txtTip)
		$txtMaxTrophy = GUICtrlCreateInput("3000", $x + 100, $y - 2, 61, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetTip(-1, $txtTip)
		$lbldropTrophy = GUICtrlCreateLabel("Min:", $x+70, $y + 22, -1, -1)
			$txtTip = "The Bot will drop trophies until below this."
			GUICtrlSetTip(-1, $txtTip)
		$txtdropTrophy = GUICtrlCreateInput("3000", $x + 100, $y + 20, 61, -1, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	Local $x = 245, $y = 375
	$grpLocateBuilidings = GUICtrlCreateGroup("Locate Manually", $x - 7, $y - 20, 222, 130)
		$btnLocateTownHall = GUICtrlCreateButton("Townhall", $x, $y, 100, 25)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "btnLocateTownHall")
		$btnLocateClanCastle = GUICtrlCreateButton("Clan Castle", $x + 105, $y, 100, 25) ; 50, 437, 180, 25
			GUICtrlSetOnEvent(-1, "btnLocateClanCastle")
		$btnLocateArmyCamp = GUICtrlCreateButton("Army Camp", $X, $y + 35, 100, 25)
			GUICtrlSetOnEvent(-1, "btnLocateArmyCamp")
		$btnLocateBarracks = GUICtrlCreateButton("Barrack", $x + 105, $y + 35, 100, 25)
			GUICtrlSetOnEvent(-1, "btnLocateBarracks")
	    $btnLocateSpellFactory = GUICtrlCreateButton("Spell Factory", $x +105, $y +70, 100, 25)
			GUICtrlSetOnEvent(-1, "btnLocateSpellfactory")
			_ArrayConcatenate($G, $T)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ This fake label is used in btnStart and btnStop to disable/enable all labels, text, buttons etc. on all tabs.
;~ -------------------------------------------------------------
Global $LastControlToHide = GUICtrlCreateLabel("", 1, 1, 1, 1)
	GUICtrlSetState(-1, $GUI_HIDE)
Global $iPrevState[$LastControlToHide + 1]
;~ -------------------------------------------------------------

;~ -------------------------------------------------------------
;~ Stats Tab
;~ -------------------------------------------------------------
$tabStatsCredits = GUICtrlCreateTabItem("Stats / Credits")
Local $x = 30, $y = 160
	$grpResourceOnStart = GUICtrlCreateGroup("Stats: Started with", $x - 20, $y - 20, 110, 105)
		$lblResultStatsTemp = GUICtrlCreateLabel("Report" & @CRLF & "will appear" & @CRLF & "here on" & @CRLF & "first run.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x + 60, $y, 15, 15)
		$lblResultGoldStart = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x + 60, $y, 15, 15)
		$lblResultElixirStart = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picResultDEStart = GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", $x + 60, $y, 15, 15)
		$lblResultDEStart = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x + 60, $y, 15, 15)
		$lblResultTrophyStart = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you had when the bot started."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 145
	$y = 160
	$grpLastAttack = GUICtrlCreateGroup("Stats: Last Attack", $x - 20, $y - 20, 110, 105)
		$lblLastAttackTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x + 60, $y, 15, 15)
		$lblGoldLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Gold you gained or lost since the last attack." & @CRLF & "Incl. any Division Bonus & Minus the Gold cost for Searching." & @CRLF & "(Not compensating for manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x + 60, $y, 15, 15)
		$lblElixirLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Elixir you gained or lost since the last attack." & @CRLF & "Incl. any Division Bonus & Minus the cost of your Troops"  & @CRLF & "(Not compensating for manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLastAttack = GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", $x + 60, $y, 15, 15)
		$lblDarkLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Dark Elixir you gained or lost since the last attack." & @CRLF & "Incl. any Division Bonus & Minus the cost of your Dark Troops" & @CRLF & "(Not compensating for manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x + 60, $y, 15, 15)
		$lblTrophyLastAttack = GUICtrlCreateLabel("", $x, $y + 2, 50, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost since the last attack."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 260
	$y = 160
    $grpTotalLoot = GUICtrlCreateGroup("Stats: Total Loot", $x - 20, $y - 20, 150, 105)
		$lblTotalLootTemp = GUICtrlCreateLabel("Report" & @CRLF & "will update" & @CRLF & "here after" & @CRLF & "each attack.", $x - 5, $y + 5, 100, 65, BITOR($SS_LEFT, $BS_MULTILINE))
		GUICtrlCreatePic (@ScriptDir & "\Icons\Gold.jpg", $x + 100, $y, 15, 15)
        $lblGoldLoot =  GUICtrlCreateLabel("", $x - 30, $y + 2, 120, 17, $SS_RIGHT)
			$txtTip = "The total amount of Gold you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Elixir.jpg", $x + 100, $y, 15, 15)
        $lblElixirLoot =  GUICtrlCreateLabel("", $x - 30, $y + 2, 120, 17, $SS_RIGHT)
			$txtTip = "The total amount of Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		$picDarkLoot = GUICtrlCreatePic (@ScriptDir & "\Icons\Dark.jpg", $x + 100, $y, 15, 15)
        $lblDarkLoot =  GUICtrlCreateLabel("", $x - 30, $y + 2, 120, 17, $SS_RIGHT)
			$txtTip = "The total amount of Dark Elixir you gained or lost while the Bot is running." & @CRLF & "(This includes manual spending of resources on upgrade of buildings)"
			GUICtrlSetTip(-1, $txtTip)
		$y +=20
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x + 100, $y, 15, 15)
		$lblTrophyLoot = GUICtrlCreateLabel("", $x - 30, $y + 2, 120, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies you gained or lost while the Bot is running."
			GUICtrlSetTip(-1, $txtTip)
    GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 400
	$y = 160
	$btnMoreStats = GUICtrlCreateButton ("More Stats", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)
	$y +=25
	$btnExportCSV = GUICtrlCreateButton ("Export CSV", $x, $y, 60,21)
		GUICtrlSetState(-1, $GUI_DISABLE)


	$x = 30
	$y = 270
	$grpStatsMisc = GUICtrlCreateGroup("Stats: Misc", $x - 20, $y - 20, 450, 60)
		$y -=2
		GUICtrlCreatePic (@ScriptDir & "\Icons\TH1.jpg", $x - 15, $y + 7, 20, 20)
    GUICtrlCreatePic (@ScriptDir & "\Icons\TH10.jpg", $x + 6, $y + 7, 20, 20)
        $lblvillagesattacked = GUICtrlCreateLabel("Attacked:", $x + 28, $y + 2, -1, 17)
        $lblresultvillagesattacked = GUICtrlCreateLabel("0", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were attacked by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
        $lblvillagesskipped = GUICtrlCreateLabel("Skipped:", $x + 28, $y + 2, -1, 17)
        $lblresultvillagesskipped = GUICtrlCreateLabel("0", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Villages that were skipped during search by the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$x = 180
		$y = 268
		GUICtrlCreatePic (@ScriptDir & "\Icons\Trophy.jpg", $x, $y, 15, 15)
        $lbltrophiesdropped = GUICtrlCreateLabel("Dropped:", $x + 20, $y + 2, -1, 17)
        $lblresulttrophiesdropped = GUICtrlCreateLabel("0", $x + 80, $y + 2, 30, 17, $SS_RIGHT)
			$txtTip = "The amount of Trophies dropped by the Bot due to Trophy Settings (on Misc Tab)."
			GUICtrlSetTip(-1, $txtTip)
        $y += 17
        GUICtrlCreatePic (@ScriptDir & "\Icons\Clock.jpg", $x, $y, 15, 15)
        $lblruntime = GUICtrlCreateLabel("Runtime:", $x + 20, $y + 2, -1, 17)
        $lblresultruntime = GUICtrlCreateLabel("00:00:00", $x + 50, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The total Running Time of the Bot."
			GUICtrlSetTip(-1, $txtTip)
		$x = 330
		$y = 268
		GUICtrlCreatePic (@ScriptDir & "\Icons\Wall.jpg", $x - 3, $y + 7, 20, 20)
        $lblwallbygold = GUICtrlCreateLabel("Upg. by Gold:", $x + 20, $y + 2, -1, 17)
		$lblWallgoldmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Gold."
			GUICtrlSetTip(-1, $txtTip)
		$y += 17
		$lblwallbyelixir = GUICtrlCreateLabel("Upg. by Elixir:", $x + 20, $y + 2, -1, 17)
		$lblWallelixirmake =  GUICtrlCreateLabel("0", $x + 55, $y + 2, 60, 17, $SS_RIGHT)
			$txtTip = "The No. of Walls upgraded by Elixir."
			GUICtrlSetTip(-1, $txtTip)
        ;$lbloutofsync = GUICtrlCreateLabel("Out Of Sync :", 260, 263, 100, 17) ; another stats next post
        ;$lblresultoutofsync = GUICtrlCreateLabel("0", 380, 263, 60, 17, $SS_RIGHT) ; another stats next post
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	$x = 30
	$y = 335
	$grpCredits = GUICtrlCreateGroup("Credits", $x - 20, $y - 20, 450, 170)
		$labelGameBotURL = GUICtrlCreateLabel("https://GameBot.org", $x - 5, $y + 5, 430, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
		$labelClashGameBotURL = GUICtrlCreateLabel("https://ClashGameBot.com", $x + 150, $y + 5, 430, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
		$lblCredits = GUICtrlCreateLabel("Credits go to the following coders:", $x - 5, $y + 25, 400, 20)
			GUICtrlSetFont(-1, 8.5, $FW_BOLD)
		$txtCredits =	"Antidote, AtoZ, Dinobot, DixonHill, DkEd, Envyus, GkevinOD, Hervidero, HungLe,"  & @CRLF & _
                        "Safar46, Saviart and others"  & @CRLF & _
						"" & @CRLF & _
						"And to all forum members contributing to this software!" & @CRLF & _
						"" & @CRLF & _
						"The latest release of the 'Clash Game Bot' can be found at:"
		$lbltxtCredits = GUICtrlCreateEdit($txtCredits, $x - 5, $y + 40, 400, 85, BITOR($WS_VISIBLE, $ES_AUTOVSCROLL, $ES_READONLY, $SS_LEFT),0)
		$labelForumURL = GUICtrlCreateLabel("https://GameBot.org/latest", $x - 5, $y + 125, 450, 20)
;~			GUICtrlSetFont(-1, 11, 100, 4)
			GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")

;~ -------------------------------------------------------------
;~ Bottom status bar
;~ -------------------------------------------------------------
$statLog = _GUICtrlStatusBar_Create($frmBot)
	_ArrayConcatenate($G, $Y)
	_GUICtrlStatusBar_SetSimple($statLog)
	_GUICtrlStatusBar_SetText($statLog, "Status : Idle")
$tiAbout = TrayCreateItem("About")
	TrayCreateItem("")
$tiExit = TrayCreateItem("Exit")

;~ -------------------------------------------------------------

GUISetState(@SW_SHOW)
