/*
 | Background App Control - Spotify Example
 | Send hotkeys to your background apps!
*/
#SingleInstance
#NoTrayIcon ;Script will not be visible in the system tray
#Requires AutoHotkey v2.0
SetKeyDelay -1, 1 ;Sets the delay for the ControlSend function. First param is milliseconds to start (-1 instant), second param is the # millliseconds held. (Needed for some windows to recognize hotkeys)
myExe := "Spotify.exe" ;Replace with your EXE
Global activeID := "" ;Checked/updated every time a hotkey gets pressed

/*
 | HOTKEYS SECTION
*/

;Ctrl + Shift + Alt + p / Rebound and hidden from the in-focus application
;Play/Pause
^+!p::{ 
    updateActiveID()
    sendControl("{Space}") ;Spacebar
}

;You can copy the whole hotkey to add more hotkeys

;Ctrl + Shift + Alt + r
;Previous Track
^+!r::{
    updateActiveID()
    sendControl("^{Left}") ;Ctrl + Left Arrow
}

;Ctrl + Shift + Alt + n
;Next Track
^+!n::{
    updateActiveID()
    sendControl("^{Right}") ;Ctrl + Right Arrow
}

;TV Mode (for spicetify TV Mode)
^+!t::{
    updateActiveID()
    sendControl("t") ;'t'
}

/*
 | FUNCTION SECTION
*/

;Checks if the EXE window exists and updates activeID. If the EXE window is not found, the hotkey ends.
updateActiveID(){
    if (WinExist("ahk_exe" myExe)){
        Global activeID := WinGetID("ahk_exe" myExe) ;Get ID of a background window
    } else {
    MsgBox("Is " myExe " open?") ;Debug
    Exit ;Ends the currently running hotkey (will not proceed)
    }
}

;Passes the control to the EXE window
sendControl(myControl){
    myHwnd := ControlGetHwnd(activeID)
    ControlFocus myHwnd ;Must focus on the window's control (Some programs will not recognize key presses without this)
    ControlSend myControl,  myHwnd ;Sends key to application
}

/*
 | DEBUG PAST THIS POINT
*/

;MsgBox(getControls()) ;List all controls of the window

;Returns a string of all the window controls of an EXE (ahk_exe)
getControls(){
    myControls := ""
    myControls := arrayToString(WinGetControls("ahk_exe" myExe))
    return myControls
}

;Returns a human-readable String from an Array
arrayToString(arr){
    str := ""
    For i, val in arr
        str .= val ", "
    str := SubStr(str, 1, -2)
    return Str
}
