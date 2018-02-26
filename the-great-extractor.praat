## The intention of this script is to take big sound files (say, a full elicitation session) and extract
## specific segments from them (say, all items in one experimental condition).
## The big sound files should be loaded up in praat, but not necessarily selected. 
## They need to be coupled with a textgrid, that minimally has one label tier that identifies the 
## segments to be extracted.

## This is where the user sets up some initial parameters.
form 
	## Setting the directory where the extracted files are saved.
	comment Where do you want to save the extracted files?
	text folder /home/zined/Desktop/wavs/gp-two-exp1/ootb-attitudes

	## Should only partial wav files be saved, or should the corresponding textgrids be saved along
	## with them? By default, only wavs.
	comment Check whether you want to save sound files and/or corresponding textgrids:
	boolean save_Wav 1
	boolean save_Textgrid

	## There should be a tier in the textgrid associated with each big sound file that specifies the labels
	## of the segments to be extracted. The tier number should be the same across textgrids.
	## That number is specified here.
	comment Which tier includes the labels to extract
	positive labeltier 1
endform

## Specifying the names of the files
## My filenames are in the format date-subjectid-experimentname 
## And I'll want to loop over multiple files, though this isn't necessary.
## So I specify those variables individually.

## Here, I fix the experiment name:
experiment$="exp1a"

## The subject name and the date change, because I've elicited stuff from different people on
## different days.

## I define a variable k, that will be fixed to a subject name and date. This information will be used to
## define a filename. But, you can do things otherways.
for k from 1 to 2
	if k=1
		subject$="mtk"
		date$="20170120"
	endif
	if k=2
		subject$="ikb"
		date$="20170122"
	endif

	filename$=date$+"-"+subject$+"-"+experiment$
	selectObject: "TextGrid 'filename$'"

	searchKey1$="nargile"
	searchKey2$="zelzele"
	searchKey3$="9-"
	searchKey4$="10-"

	# Gets the number intervals in current sound file
	numberOfIntervals=Get number of intervals... labeltier

	# Cycles through the interval numbers
	for labelNumber from 1 to numberOfIntervals

		# Gets the label of the current interval number
		labelName$=Get label of interval... labeltier labelNumber

		if index(labelName$, searchKey1$)>0 or index(labelName$,searchKey2$)>0 or index(labelName$,searchKey3$)>0 or index(labelName$,searchKey4$)>0
			intervalStart=Get starting point... labeltier labelNumber
			intervalEnd=Get end point... labeltier labelNumber
			# appendInfoLine: labelName$, " ", labelNumber, " ", intervalStart, " ", intervalEnd
			savePath$=folder$ + "/" +labelName$+"-"+subject$

			# This part extracts the textgrid. It's useful if you want to save it as well. Or manipulate it.
			if save_Textgrid=1
				Extract part... intervalStart intervalEnd Yes
				Save as text file... 'savePath$'.TextGrid
				Remove
			endif

			# Selects the soundfile and extracts the part corresponding to the label.
			if save_Wav=1
				selectObject: "Sound 'filename$'"
				Extract part... intervalStart intervalEnd rectangular 1 No
				Write to WAV file... 'savePath$'.wav
				Remove
			endif
		endif
		
		# We need to select the master textgrid back:
		selectObject: "TextGrid 'filename$'"
	endfor
endfor

