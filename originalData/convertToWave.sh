#!/bin/bash

find ./multimic -name "*.wav" | xargs rm

convertFiles() {
	# $1 File Names
	# $2 Channel Count - 1
	# $3 Root Dir

	findExp="find $3 -name *$1.adc.wav"
	FILES="$($findExp)"

	# http://www.cyberciti.biz/faq/bash-loop-over-file/
	for f in $FILES
	do
		comm="ffmpeg -i $f -map_channel "
		# http://codewiki.wikidot.com/shell-script:if-else
		if [ $2 = 0 ]
		then
			echo $f\_0.wav
			$comm 0.0.0 $f\_0.wav
		else
			# http://unix.stackexchange.com/questions/55392/in-bash-is-it-possible-to-use-an-integer-variable-in-the-loop-control-of-a-for
			for ((i=0; i<=$2; i++)); do
				echo $f\_$i.wav
				$comm 0.0.$i $f\_$i.wav
			done
		fi
	done
}

# 15element Folder:
rootDir=./multimic/15element/

find $rootDir -type f -name "*senn*.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
convertFiles "senn*" 0 $rootDir 

find $rootDir -type f -name "*-arr*.adc" -exec ffmpeg -f s16be -ar 16000 -ac 15 -i {} {}.wav \;
convertFiles "-arr*" 14 $rootDir 


# 8element Folder:
rootDir=./multimic/8element/

# pzmS files are stereo, little endian (the converted file is mono)
find $rootDir -type f -name "*pzmS.adc" -exec ffmpeg -f s16le -ar 16000 -ac 2 -i {} {}.wav \;
convertFiles "pzmS" 1 $rootDir 

# senn files are mono and little endian:
find $rootDir -type f -name "*senn.adc" -exec ffmpeg -f s16le -ar 16000 -i {} {}.wav \;
convertFiles "senn" 0 $rootDir 

# arrA files have 8 channels and big endian (the converted file is mono)
find $rootDir -type f -name "*arrA.adc" -exec ffmpeg -f s16be -ar 16000 -ac 8 -i {} {}.wav \;
convertFiles "arrA" 7 $rootDir 


# rutdata
rootDir=./multimic/rutdata/

# pzm files are mono, big endian
find $rootDir -type f -name "*pzm.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;
convertFiles "pzm" 0 $rootDir 

# sen files are mono and big endian:
find $rootDir -type f -name "*sen.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;
convertFiles "sen" 0 $rootDir 

# arrA1m, arrA3m, arrB1m, and arrB3m files are mono and big endian
find $rootDir -type f -name "*arrA1m.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;
convertFiles "arrA1m" 0 $rootDir 
find $rootDir -type f -name "*arrA3m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
convertFiles "arrA3m" 0 $rootDir 
find $rootDir -type f -name "*arrB1m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
convertFiles "arrB1m" 0 $rootDir 
find $rootDir -type f -name "*arrB3m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
convertFiles "arrB3m" 0 $rootDir 
 


