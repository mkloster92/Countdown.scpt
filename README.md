This is a catch-all countdown that is capable of returning 5 different outputs without modifying the code. 
I tried to make it as efficient as possible, but I also put some things in to combat my pet-peeves of other countdowns that may
use more processing than absolutely necessary, like displaying the sigular form of minute when there is 1 minute left. 
Also, I built this for my girlfriend who has no programing knowledge, so it has error handling such that you never have to open the script. 

	Output Parameters - Output style:
	Days - XX Days
	Minute - DAYS:HOURS:MINUTES
	MinuteW - XX Days, XX Hours, XX Minutes
	Second - DAYS:HOURS:MINUTES:SECONDS
	SecondW - XX Days, XX Hours, XX Minutes, XX Seconds

If using for geektool, create a shell with an approriate refresh rate and drop this in the Command Line (there is a copy-able version in the script):
osascript /[SCRIPT LOCATION]/countdown.scpt \"[output parameter]\" \"MM/DD/YYYY HH:MM:SS AM\"

You can include as much or as little as you want for the date.

Examples:
For a Days output for April, 29 2015:
osascript /Users/Geektool/countdown.scpt \"Days\" \"04/29/2015\"

For a MinuteW output for April, 29 2015 at 2:30 PM:
osascript /Users/Geektool/countdown.scpt \"Days\" \"04/29/2015 02:30:00 PM\"
