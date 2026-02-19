set timeCells to {"B2", "B3", "B4", "B5", "B6", "B7", "B8", "B9", "B10", "B11", "B12", "B13", "B14", "B15", "B16", "B17", "B18"}

set time_options to {"9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM"}
-- set chosen_time to choose from list time_options with prompt "Select a time:" with title "Time Selection"


set tomorrowDate to (current date) + (1 * days)
-- display dialog "Tomorrow's date is: " & short date string of tomorrowDate

-- Get the content of the clipboard
set clipboardContent to the clipboard as text


set theResponse to display dialog "Schedule for what date?:" default answer (short date string of tomorrowDate) with icon note buttons {"Cancel", "Continue"} default button "Continue"

set theDate to text returned of theResponse

-- Ask the user to choose
set sel to choose from list time_options with prompt "Pick a time:" default items {""} without multiple selections allowed

set theMeeting to display dialog "What is the meeting?:" default answer {clipboardContent} with icon note buttons {"Cancel", "Continue"} default button "Continue"

set theDuration to display dialog "And how long is it?:" buttons {"Half hour", "One hour", "Two hours"} default button "Half hour"
set theDuration to button returned of theDuration
-- return theDuration

set theMeeting to text returned of theMeeting

-- User pressed Cancel?
if sel is false then
	return -- or: error number -128
end if

set chosenItem to item 1 of sel

-- Find 1-based index in the list
set idx1 to my positionOf(chosenItem, time_options)

set theCell to item idx1 of timeCells
set adjacentCell to item (idx1 + 1) of timeCells
set mergeRange to theCell & ":" & adjacentCell
-- return mergeRange


-- Helper: return the 1-based position of v in list L, or 0 if not found
on positionOf(v, L)
	repeat with i from 1 to (count L)
		if item i of L is v then return i
	end repeat
	return 0
end positionOf



tell application "Numbers"
	tell document 1 -- Or specify the document by name: "My Spreadsheet"
		tell sheet 1 -- Or specify the sheet by name: "Sheet 1"
			tell table 1 -- Or specify the table by name: "Table 1"
				
				set value of cell theCell to theMeeting
				if theDuration is "One hour" then
					merge range mergeRange
				end if
			end tell
		end tell
	end tell
end tell
