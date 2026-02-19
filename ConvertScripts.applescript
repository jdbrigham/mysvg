set text_ext to ".applescript" -- or ".txt" if preferred
set targetFolder to choose folder with prompt "Choose a folder of scripts to convert:"

tell application "Finder"
    set scriptFiles to (every file of targetFolder whose name extension is "scpt" or name extension is "scptd") as alias list
end tell

repeat with aFile in scriptFiles
    set filePath to POSIX path of aFile
    set textPath to text 1 thru -6 of filePath & text_ext -- Change extension

    -- Use osadecompile shell command to convert the file content
    do shell script "osadecompile " & quoted form of filePath & " > " & quoted form of textPath

    -- Optional: move the original compiled script to the trash
    tell application "Finder" to move aFile to the trash
end repeat

display dialog "Conversion complete for " & (count scriptFiles) & " files."
