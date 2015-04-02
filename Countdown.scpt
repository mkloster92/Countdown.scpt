(*
Here is a copy-able shell text:
osascript /[SCRIPT LOCATION]/countdown.scpt "[output parameter]" "MM/DD/YYYY HH:MM:SS AM"
*)

on run argv
	-- Lists for Parameters	
	set ParamList to {"Days", "Minute", "MinuteW", "Second", "SecondW"}
	set ParamList2 to {"Minute", "MinuteW", "Second", "SecondW"}
	set ParamList3 to {"Second", "Secondw"}
	
	-- Error handling for incorrect date formatting	
	try
		set dDate to date (item 2 of argv)
	on error error_message number error_number
		if error_number = -30720 then
			return "Error in date entry. Be sure you are using the correct format:
 osascript /[SCRIPT LOCATION]/countdown.scpt \"[output type]\" \"MM/DD/YYYY HH:MM:SS AM\""
		end if
	end try
	
	-- Error handling and help text for incorrect No. of arguments, invalid parameters, help logic, and hard-coding option 	
	if ((count of argv) is 0) or ((count of argv) is 1) or (item 1 of argv is "help") then
		set helpmeFull to "This is a catch-all countdown that is capable of returning 5 different outputs without modifying the code. 
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
osascript /Users/Geektool/countdown.scpt \"Days\" \"04/29/2015 02:30:00 PM\""
		return helpmeFull
		
		
		(*
		For hard-coded date and parameter:
			Comment out the error return above by adding "--" before it
			Un-Comment out the 2 lines below by removing the "--" before them
		*)
		--set param to "SecondW"
		--set dDate to date ("04/29/2015 02:30:00 PM" as string)
		
		
	else if ParamList does not contain (item 1 of argv) then
		set helpme to "Error in Parameter Entry.
	
	Output Parameters - Output style:
	Days - XX Days
	Minute - DAYS:HOURS:MINUTES
	MinuteW - XX Days, XX Hours, XX Minutes
	Second - DAYS:HOURS:MINUTES:SECONDS
	SecondW - XX Days, XX Hours, XX Minutes, XX Seconds"
		return helpme
	else
		set param to item 1 of argv
		set dDate to date (item 2 of argv)
	end if
	
	-- Beginning of caluculations	
	set todaydate to current date
	set dateDiff to (dDate - todaydate)
	set daysleft to (dateDiff) / (60 * 60 * 24)
	-- Calculations for Days	
	if param is "Days" then
		set rdaysu to round (daysleft) rounding up
		
		if rdaysu = 1 then
			set day1 to " Day"
		else
			set day1 to " Days"
		end if
		
		set TimeLeftd to "" & rdaysu & day1
		return TimeLeftd
	end if
	
	-- Calculations for Minutes, MinutesW, Seconds, SecondsW 	
	if ParamList2 contains param then
		set rdays to round (daysleft) rounding down
		set hoursleft to (dateDiff - (rdays * 60 * 60 * 24)) / (60 * 60)
		set rhours to round (hoursleft) rounding down
		set minsleft to (dateDiff - (rdays * 60 * 60 * 24) - (rhours * 60 * 60)) / (60)
		set rmins to round (minsleft) rounding down
		set rminsu to round (minsleft) rounding up
		
		-- Logic for sigular unit form
		if rdays = 1 then
			set day1 to " Day, "
		else
			set day1 to " Days, "
		end if
		if rhours = 1 then
			set hour1 to " Hour, "
		else
			set hour1 to " Hours, "
		end if
		if rminsu = 1 then
			set min1 to " Minute"
		else
			set min1 to " Minutes"
		end if
		
		-- Return for Minute and MinuteW
		if param is "Minute" then
			set TimeLeft to "" & Zeros(rdays) & ":" & Zeros(rhours) & ":" & Zeros(rminsu)
			return TimeLeft
			
		else if param is "MinuteW" then
			set TimeLeftW to "" & rdays & day1 & rhours & hour1 & rminsu & min1
			return TimeLeftW
			
		else if ParamList3 contains param then
			
			-- Additional calculations for Seconds and SecondsW	
			set secsleft to (dateDiff - (rdays * 60 * 60 * 24) - (rhours * 60 * 60) - (rmins * 60))
			set rsecs to round (secsleft) rounding up
			
			if rsecs = 1 then
				set sec1 to " Second"
			else
				set sec1 to " Seconds"
			end if
			
			-- Returns for Seconds and SecondsW
			if param is "Second" then
				set TimeLefts to "" & Zeros(rdays) & ":" & Zeros(rhours) & ":" & Zeros(rmins) & ":" & Zeros(rsecs)
				return TimeLefts
				
			else if param is "SecondW" then
				set TimeLeftsW to "" & rdays & day1 & rhours & hour1 & rminsu & min1 & ", " & rsecs & sec1
				return TimeLeftsW
			end if
		end if
	end if
end run
-- Function to add zeros to the display for single-digit numbers
on Zeros(n)
	if length of (n as string) is not equal to 2 then set n to ("0" & n) as string
	return n as string
end Zeros


