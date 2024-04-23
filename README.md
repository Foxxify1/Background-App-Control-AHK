# Background-App-Control-AHK
Send key combos to background applications

Doesn't focus on the application, and works even if it's focused

Currently supports one application per script

NOT TESTED WITH MULTI-WINDOW APPS, could break stuff, I'm not sure

INSTRUCTIONS:
- Replace your_exe_here.exe with the application name of your choice
  (Same as the ahk_exe in Window Spy)
- Change the trigger hotkey to your combo of choice
- Change the hotkey(s) sent to the background app to whatever you need

Todo: 
- Support multiple programs in one script
- Test multi-window applications (Not a priority)

Known Issues: (I've spent hours trying to debug these)
- Modifier keys in the hotkey definition will still be passed to the in-focus application (Ctrl, Shift, Alt)
- Sometimes modifier keys in the hotkey definition will be held down (Inherent AHK issue) (Added a Sleep command to mitigate, but not fully tested)
