form Where do you want to save the files?
comment Folder:
text folder /home/zined/test-wavs/
sentence save_sound_to_subfolder
sentence save_TextGrid_to_subfolder

positive labeltier 2
positive wordtier 3 
endform


exps$[1]="pragmatics"
exps$[2]="regular-focus"
exps$[3]="ec-focus"
exps$[4]="exp1a"
exps$[5]="exp1c"
exps$[6]="perception-ch1"
exps$[7]="practice-ch1"
exps$[8]="perception2-ch1"
m=8

for k from 1 to m
experiment$=exps$[k]
if k<4
	subject$="de"
	date$="20170316"
endif
if k>3
	subject$="ikb"
	date$="20170122"
endif
if k=6
	subject$="do"
	date$="20170531"
endif
if k=7
	subject$="do"
	date$="20170601"
endif
if k=8
	subject$="do"
	date$="20170602"
endif

# from the pragmatics subexperiment
#if experiment$="pragmatics"
	labelToSave$[19]="limon-assert-1"
	labelToSave$[20]="limon-maybe-3"
	labelToSave$[21]="yalova-assert-1"
	labelToSave$[22]="yalova-maybe-1"
	labelToSave$[23]="anamur-assert-3"
	labelToSave$[24]="anamur-maybe-2"
#	n=6
#endif

#if experiment$="regular-focus"
	labelToSave$[25]="ereglililer-prf-1"
	labelToSave$[27]="anamurlular-pmf-1"
	labelToSave$[29]="alanyalilar-vf-1"
#	n=3
#endif
#if experiment$="ec-focus"
	labelToSave$[31]="alara-s-bil-2"
	labelToSave$[33]="manolya-s-bil-1"
#	n=2
#endif
#if experiment$="exp1c"
	#test items:
	labelToSave$[13]="4-k-mv-a"
	labelToSave$[14]="4-k-ev-b"
	labelToSave$[15]="2-k-mv-a"
	labelToSave$[16]="2-k-ev-a"
	labelToSave$[17]="3-k-mv-a"
	labelToSave$[18]="3-k-ev-a"
	# fillers:
	labelToSave$[32]="8-k-do-b"
	labelToSave$[34]="9-k-do-b"
#	n=8
#endif
#if experiment$="exp1a"
	# fillers
	labelToSave$[26]="5-w-pr-a"
	labelToSave$[28]="7-w-pm-a"
	labelToSave$[30]="3-w-v-a"
#	n=3
#endif
#if experiment$="practice-ch1"
	labelToSave$[35]="uzaylilar-2"
	labelToSave$[36]="cuceler-2"
	labelToSave$[37]="legolas-2"
	labelToSave$[38]="kahve-1"
#endif

# if experiment$=perception-ch1
	#neg-raise
	labelToSave$[39]="ayse-2"
	labelToSave$[40]="bolumbaskan-2"
#	n=18
#endif
#if experiment$="perception2-ch1"
	# experimental
	labelToSave$[1]="ereglili-mv-2"
	labelToSave$[2]="ereglili-ev-1"
	labelToSave$[3]="emelhanim-mv-2"
	labelToSave$[4]="emelhanim-ev-2"
	labelToSave$[5]="angolali-mv-2"
	labelToSave$[6]="angolali-ev-2"
	labelToSave$[7]="cezeryeci-mv-2"
	labelToSave$[8]="cezeryeci-ev-2"
	labelToSave$[9]="canerabi-mv-2"
	labelToSave$[10]="canerabi-ev-2"
	labelToSave$[11]="ebruyenge-mv-2"
	labelToSave$[12]="ebruyenge-ev-1"
	#comprehension
	labelToSave$[41]="merve-mv-2"
	labelToSave$[42]="merve-ev-2"
	labelToSave$[43]="recep-mv-2"
	labelToSave$[44]="recep-ev-3"
#endif
n=44

#appendInfoLine: exps$[k]

filename$=date$+"-"+subject$+"-"+experiment$
selectObject: "TextGrid 'filename$'"
tgpartname$=filename$+"_part"

numberOfIntervals=Get number of intervals... labeltier
for label from 1 to numberOfIntervals
	labelsToSave$=Get label of interval... labeltier label
	for i from 1 to n
	if i>0 and i<25
		stimcat$="e"
	endif
	if i>24 and i<35
		stimcat$="f"
	endif
	if i>34 and i<39
		stimcat$="p"
	endif
	if i>38 and i<41
		stimcat$="n"
	endif
	if i>40 and i<45
		stimcat$="c"
	endif
	if labelsToSave$=labelToSave$[i]
		#appendInfoLine: labelToSave$[i]
		intervalStart=Get starting point... labeltier label
		intervalEnd=Get end point... labeltier label
		Extract part... intervalStart intervalEnd Yes
		allWords=Get number of intervals... wordtier
		for word from 1 to allWords
			smaller$=Get label of interval... wordtier word 
			if smaller$="bil\i'yo" or smaller$="yol\u'yor" or smaller$="al\i'yor" or smaller$="ar\i'yor" or smaller$="indird\i'" or smaller$="devirdi" or smaller$="doyurd\u'" or smaller$="baris" or smaller$="arayacakmis" or smaller$="mi" or smaller$="kahveleri"
				# SETTING THE smallerEnd variable: This sets the right edge of the segment to truncate. If it is set to intervalEnd, defined above
				# the interval won't be truncated. If you set it to something smaller, it will. Here, the next line will remove the final word. The second next line
				# won't do anything.
				#smallerEnd=Get starting point... wordtier word
				smallerEnd=intervalEnd
				#selectObject: "LongSound 'filename$'"
				selectObject: "Sound 'filename$'"
				soundpath$ = folder$ + save_sound_to_subfolder$ + "/" + string$(i)+"-"+stimcat$+"-"+subject$+".wav" 
				#+experiment$+"-" + labelToSave$[i] + ".wav"
				Extract part... intervalStart smallerEnd rectangular 1 No
				Write to WAV file... 'soundpath$'
				Remove
				selectObject: "TextGrid 'tgpartname$'"
			endif
		endfor
		Remove
		selectObject: "TextGrid 'filename$'"
	endif
	endfor
endfor
endfor

