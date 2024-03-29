; -------------------- HOTSTRINGS -------------------

:*:e\\::justinmklam@gmail.com		; primary email
:*:en\\::justinmklam{+}newsletters@gmail.com
:*:es\\::justinlam@live.ca			; secondary email
:*:ew\\::justin@mistywest.com

:*:pc\\::V6S 2C5			; Dunbar postal code

:*:up\\::$('[title=like]').not('.pushed').click();{Return}		; imgur upvotes

:*:hk\\::from haikuza_main import *
:*:;\\::\n");

:*:\degc::{Backspace}°C
:*:\del::Δ

; -------------------- HOTKEYS ----------------------
; ************************
;     Time-date stamps    
; ************************
; Hotkey to enter revision date stamp (ex. 2014-01-07 )
#F1::TimeDateStamp("yyyy-MM-dd ")

; Hotkey to enter revision date time stamp (ex. 2014-01-07_13-20 )
#F2::TimeDateStamp("yyyy-MM-dd_HH-mm")

; Hotkey to enter date stamp (ex. January 7, 2014)
#F3::TimeDateStamp("MMMM d, yyyy")

; Hotkey to enter date stamp (ex. Thu, 7 Jan 2015)
#F4::TimeDateStamp("ddd, d MMM yyy")

; ***************
;     General    
; ***************
;WheelRight::
;	Send, {Browser_Forward}
;	Sleep, 250
;	Return
;
;WheelLeft::
;	Send, {Browser_Back}
;	Sleep, 250
;	Return

; Remap WASD to arrow keys
CapsLock & a::Send, {Left}
CapsLock & d::Send, {Right}
CapsLock & w::Send, {Up}
CapsLock & s::Send, {Down}

; Switch between windows workspaces
+#h::Send ^#{Left}
+#l::Send ^#{Right}

; Highlight entire line
;+^H::SendInput {End}{ShiftDown}{Home}	
;Return

; Insert link easily
+^k::SendInput {Left}{CtrlDown}k
Return

; Delete entire line
+^!H::SendInput {End}{ShiftDown}{Home}{Delete}{Backspace}
Return

; New line above current
+^Enter::SendInput {Home}{Return}{Up}
Return

; Remap home
^!Left::SendInput {Home}
Return

; Remap end
^!Right::SendInput {End}
Return

; Highlight from cursor to home
;+!Left::SendInput {ShiftDown}{Home}
;Return

; Highlight from cursor to end
;+!Right::SendInput {ShiftDown}{End}
;Return

; Switch virtual desktops
RAlt & Space::SwitchVirtualDesktop()

; Toggles current window to be always on top
+#a::Winset, AlwaysOnTop, Toggle, A	
Return

; Add browser forward to mouse with only browser back button
+XButton1::Browser_Forward

; Hotkey to lock PC and turn screen off
+Pause::LockPC()

; *** Window Management ***
; Maximize window
;^!w::Send #{Up}
;Return

; Maximize window
;^!s::WinMaximize, A
;Return

; Place window left
;^!a::Send #{Left}
;Return

; Place window right
;^!d::Send #{Right}
;Return

; Move window to other monitor
+^!s::Send +#{Left}
Return

; Move window down
;^!x::Send #{Down}
;Return

; Minimize window
;+^!x::WinMinimize, A
;Return

; Set more media keys for surface keyboard and logitech mouse
+!=::Volume_Up
+!-::Volume_Down
#+-::Media_Play_Pause
!F10::Media_Next
!F9::Media_Prev

; -------------------- PROGRAM SPECIFIC  ----------------------

#MaxHotkeysPerInterval 500

; Browser tab scroll
#IfWinActive ahk_exe chrome.exe
	~WheelDown::ScrollTab("left")
	~WheelUp::ScrollTab("right")
	
; Browser tab scroll
#IfWinActive ahk_exe firefox.exe
	~WheelDown::ScrollTab("left")
	~WheelUp::ScrollTab("right")

; Microsoft Excel 
#IfWinActive ahk_exe EXCEL.EXE
	;Switch between sheets with ALT+SCROLL
	~Alt & WheelDown::SendInput ^{PgDn}
	~Alt & WheelUp::SendInput ^{PgUp}

	;Horizontal scroll with SHIFT+SCROLL
	+WheelDown::ComObjActive("Excel.Application").ActiveWindow.SmallScroll(0,0,3,0)
	+WheelUp::ComObjActive("Excel.Application").ActiveWindow.SmallScroll(0,0,0,3)

#IfWinActive ahk_exe ONENOTE.EXE
	;Switch between sheets with ALT+SCROLL
	~Alt & WheelDown::SendInput ^{PgDn}
	~Alt & WheelUp::SendInput ^{PgUp}

	;Horizontal scroll with SHIFT+SCROLL
	+WheelUp::		; scroll left
		ControlGetFocus, fcontrol, A
		Loop 5  ; <-- Increase or decrease this value to scroll faster or slower.
			SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINERIGHT.
		return

	+WheelDown::	; scroll right
		ControlGetFocus, fcontrol, A
		Loop 5  ; <-- Increase or decrease this value to scroll faster or slower.
			SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINELEFT.
		return
;#IfWinActive
;
;SetTimer Click, 100
;
;F8::Toggle := !Toggle
;
;Click:
;    If (!Toggle)
;        Return
;    Click
;    Send a
;return

; -------------------- FUNCTIONS --------------------

; Toggle between left and right virtual desktops
SwitchVirtualDesktop()
{
	global k
	if ( k == 0 )
	{
		Send ^#{Left}
		k = k + 1
		Return
	}
	else
	{
		Send ^#{Right}
		k = 0
		Return
	}
}

; Enter time-date stamp according to desired format
TimeDateStamp(format)
{
	FormatTime, Date, ,%format%
	SendInput, %Date%
	Return 
}

; Switch browser tabs with mouse scroll wheel
ScrollTab(direction)
{
	MouseGetPos X, Y
	if ( Y < 33 )
	{
		if (direction == "left")
			SendInput ^{Tab}
		if (direction == "right")
			SendInput ^+{Tab}
		Return
	}	
}

IncreaseScroll(direction)
{
	Loop 10
	if (direction == "up")
		send {WheelUp}
	else
		send {WheelDown}	
	return
}

; Lock PC and turn screen off
LockPC()
{
	Run rundll32.exe user32.dll`,LockWorkStation
	Sleep 500
	SendMessage 0x112, 0xF170, 2,,Program Manager
	Return
}