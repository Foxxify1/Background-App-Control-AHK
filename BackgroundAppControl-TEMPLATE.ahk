/*
 | Background App Control - TEMPLATE
 | Send hotkeys to your background apps!
*/

#Requires AutoHotkey v2.0
#SingleInstance
#UseHook ;Will surpress non-modifiers from being seen by the in-focus application
#NoTrayIcon ;Script will not be visible in the system tray
A_MenuMaskKey := "vkE8" ;Surpresses the pressing of Ctrl when releasing Win or Alt (Presses key code instead)
SetKeyDelay -1, 1 ;Sets the delay for the ControlSend function. First param is milliseconds to start (-1 instant), second param is the # millliseconds held. (Needed for some windows to recognize hotkeys)
myExe := "your_exe_here.exe" ;Replace with your EXE
Global activeID := "" ;Checked/updated every time a hotkey gets pressed

/*
 | HOTKEYS SECTION
*/

;Trigger Hotkey: Ctrl + Shift + Alt + p
^+!p::{
    updateActiveID()
    sendToApp("{Space}") ;Alt + Spacebar - Swap with your app's hotkey. To get started: https://www.autohotkey.com/docs/v2/KeyList.htm
}

;Trigger Hotkey: Ctrl + Shift + Alt + r
^+!r::{
    updateActiveID()
    sendToApp("{Ctrl down}{Left}{Ctrl up}") ;Ctrl + Left Arrow - Modifiers here will be visible to the in-focus application unless down/up specified
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
sendToApp(myControl){
    local myHwnd := ControlGetHwnd(activeID)
    ControlFocus myHwnd ;Must focus on the window's control (Some programs will not recognize key presses without this)
    ControlSend myControl,  myHwnd ;Sends key to application
    Sleep(5)
}

/*
 | DEBUG PAST THIS POINT
*/

;KeyHistory ;Show keys pressed by this script

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
