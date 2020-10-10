#!/usr/bin/osascript


on run argv
  -- set unique_songs to paragraphs of (read POSIX file fileName)
  set output to ("Inside 'on run', argv: " & argv)
  do shell script "echo " & quoted form of output
  -- recursively hide file extensions in a selected folder, or on individually selected files in the Finder
  tell application "Finder"
    repeat with anItem in argv
      if kind of anItem is "Folder" then
	    set output to ("Iterating: " & anItem)
		do shell script "echo " & quoted form of output
        set theFiles to (every file in entire contents of folder anItem)
        repeat with afile in theFiles
          set output to ("Hiding extension: " & afile & "\n")
		  do shell script "echo " & quoted form of output
          set extension hidden of afile to true
        end repeat
      else
        set extension hidden of anItem to true
      end if
    end repeat
  end tell
end run