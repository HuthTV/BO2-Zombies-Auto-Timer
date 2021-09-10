# Description
Livesplit ASL script for BO2 zombies. Automatically starts, resets, and syncs timer with game time. Should be accurate to ± 100ms.
Compatible with [Redacted](https://redacted.se) and [Plutonium](https://plutonium.pw).

# Setup
### Downloads
* If you haven't already, download [livesplit](https://livesplit.org/downloads).
* Download [BO2timer.asl](https://github.com/HuthTV/BO2-ZM-Synchronized-Livesplit/releases/download/1/BO2timer.asl) script 

### Configure
* Open LiveSplit.exe and right click timer
* Select ```Edit Layout -> Add Component (plus sign) -> Control -> Scriptable Auto Splitter```
* In Layout Editor, open Layout Settings. Under Scriptable Auto Splitter tab, point ```Script Path:``` at BO2timer.asl
* Make sure any timer and split components in your layout have the setting ```Timing Method: Game Time```

The timer should now work with BO2 Plutonium or Redacted :smile:

## Known issues
The timer starts when round 1 begins. On MotD, round 1 won't start until several seconds after leaving afterlife. Thus the timer will be approximately 10 seconds slow depending on how long one remains in afterlife.
