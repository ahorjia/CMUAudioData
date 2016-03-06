#!/bin/bash
FILES="$(find . -name '*pzmS.adc.wav')"

echo $FILES
for f in $FILES
do
	comm="ffmpeg -i $f -map_channel "
	for i in {0..7}
	do
		echo $f\_$i.wav
		$comm 0.0.$i $f\_$i.wav
	done
done
