## This script will hum your current selection in an Editor window.
## For it to work you need:
## - to select the sound in the Objects window
## - to select a segment to be hummed in the Editor window

## Hint: This script can conveniently be run by a button: File > Add to fixed/dynamic menu

## Stores the type and name of the file selected in the objects window
sound$ = selected$()

## Opens the editor. This opens a new window.
Edit

## Passes commands to the editor, extracts selection, closes the window opened by previous command. 
editor: sound$
	Extract selected sound (preserve times)
Close

## Renames selection to something unique, extracts pitch, hums it
Rename: "temporarySound"
To Pitch... 0 75 600
Hum

## Cleanup:
## Removes pitch object, selects sound, removes that, selects original sound file (so that 
## the process can be repeated, for example).
Remove
selectObject: "Sound temporarySound"
Remove
selectObject: sound$