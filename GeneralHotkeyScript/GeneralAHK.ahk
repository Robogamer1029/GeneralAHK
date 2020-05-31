#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force ; Forces a single instance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Screen

; Setup.
hotkey, +``, toggle
; hotkey, !^F8, toggle
NumHotkeys := False
SetScrollLockState, off ; Sroll Lock set to false for numpad Hotkeys
return

; deactivators
$Browser_Home:: sendinput, {Volume_Mute}
$Volume_Down:: return
$Volume_Up:: return

; Shyte hit the fan
end:: exitapp
home:: suspend

; Discord Shyte
^`:: hotkey +``, toggle
+`:: 
{ 
  sendinput, {F22}
  hotkey, ~$*Space, toggle
  discx := (A_ScreenWidth / 2)
  discy := (A_ScreenHeight / 2)
  mousemove, discx, discy
  return
}
numpaddiv:: sendinput, {F23}
numpadmult:: sendinput, {F24}

; special hotkeys^tm
!^F9:: run, "Disable Interwebs.bat", Minimize

!^f8:: ; Discord Spammer
{
   Loop
   {
     Random, sline, 1, 330
     FileReadLine, EpicLine, EpicLines.txt, %sline%
     ControlFocus,,ahk_exe Discord.exe
     ControlSend, ahk_parent, %EpicLine% {Enter}, ahk_exe Discord.exe
     Sleep, 61000
   }
return
}

; Game Specific stuffs
#If, WinActive("ahk_exe VALORANT-Win64-Shipping.exe") ; Valor Ant
*F4:: hotkey, $*space, toggle
~$*space::
{
   Loop
   {
     if not GetKeyState("space", "P") ; B-hopping
        break
      SendInput, {space}
     sleep, 50
   }
return
}
#if

#If, WinActive("ahk_exe javaw.exe") ; Minecraft
*Xbutton2::s
#If

#If, WinActive("ahk_exe csgo.exe") ; Counter-Srike: Globul Offensive
*WheelLeft:: SendInput, 6
*MButton:: SendInput, 7
*WheelRight:: SendInput, 8
*F4:: hotkey, $*space, toggle
~$*space::
{
   Loop
   {
     if not GetKeyState("space", "P") ; B-hopping
        break
      SendInput, {space}
     sleep, 50
   }
return
}
#If

; Numpad Commands (Toggled with Scroll Lock)
ScrollLock:: 
{
  NumHotkeys := !NumHotkeys
  SetScrollLockState % !GetKeyState("ScrollLock", "T")
  return
}

#If, NumHotkeys
Numpad1:: Run, "GeneralAHK.ahk", Minimize
Numpad2:: return
#If

; Spotify Shyte
*F2:: 
{
  sendinput, {Media_Play_Pause}
  goto, MoveMouseToCorner
  return
}

getSpotifyHwnd() 
{
	WinGet, spotifyHwnd, ID, ahk_exe spotify.exe
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	spotifyHwnd := DllCall("GetWindow", "uint", spotifyHwnd, "uint", 2)
	Return spotifyHwnd
}

spotifyKey(key) 
{
	spotifyHwnd := getSpotifyHwnd()
	ControlFocus, Chrome_RenderWidgetHostHWND1, ahk_id %spotifyHwnd%
	ControlSend, , %key%, ahk_id %spotifyHwnd%
	Return
}

+Up::
{
  spotifyKey("^{Up}")
  goto, MoveMouseToCorner
  return
}
+Down::
{
  spotifykey("^{Down}")
  goto, MoveMouseToCorner
  return
}
+Left::
{
  SendInput, {Media_Prev}
  goto, MoveMouseToCorner
  return
}
+Right::
{
  SendInput, {Media_Next}
  goto, MoveMouseToCorner
  return
}
MoveMouseToCorner:
{
  if WinActive("ahk_exe VALORANT-Win64-Shipping.exe")
  {
    mousemove, A_screenwidth, A_ScreenHeight
  }
  return
}
