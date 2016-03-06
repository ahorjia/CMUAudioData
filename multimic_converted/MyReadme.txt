There are three directories of data

15element Folder:

senn files are big endian and mono:
find . -type f -name "*senn*.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;

arr files are big endian with 15 channels (notice that the output is not mono)
find . -type f -name "*-arr*.adc" -exec ffmpeg -f s16be -ar 16000 -ac 15 -i {} {}.wav \;


8element Folder:

pzmS files are stereo, little endian (the converted file is mono)
find . -type f -name "*pzmS.adc" -exec ffmpeg -f s16le -ar 16000 -ac 2 -i {} {}.wav \;

senn files are mono and little endian:
find . -type f -name "*senn.adc" -exec ffmpeg -f s16le -ar 16000 -i {} {}.wav \;

arrA files have 8 channels and big endian (the converted file is mono)
find . -type f -name "*arrA.adc" -exec ffmpeg -f s16be -ar 16000 -ac 8 -i {} {}.wav \;


rutdata-good:

pzm files are mono, big endian
find . -type f -name "*pzm.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;

sen files are mono and big endian:
find . -type f -name "*sen.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;

arrA1m, arrA3m, arrB1m, and arrB3m files are mono and big endian
find . -type f -name "*arrA1m.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;
find . -type f -name "*arrA3m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
find . -type f -name "*arrB1m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;
find . -type f -name "*arrB3m.adc" -exec ffmpeg -f s16be -ar 16000 -i {} {}.wav \;

I used Audacity to figure out the format of the file (with a little of try and error)
It can import raw files with Audacity

########################
Extract Channels
########################
ffmpeg -i a8.wav -map_channel 0.0.0 a8_0.wav -map_channel 0.0.1 a8_1.wav -map_channel 0.0.2 a8_2.wav -map_channel 0.0.3 a8_3.wav -map_channel 0.0.4 a8_4.wav -map_channel 0.0.5 a8_5.wav -map_channel 0.0.6 a8_6.wav -map_channel 0.0.7 a8_7.wav


##############################################################################################################
#####Extra random notes
##############################################################################################################

Microphone Type:

15:
find . -type f -name "*senn*.adc" -exec ffmpeg -f s16be -ar 16000 -ac 1 -i {} {}.wav \;
find . -type f -name "*-arr*.adc" -exec ffmpeg -f s16be -ar 16000 -ac 15 -i {} {}.wav \;

8:
find . -type f -name "*pzmS.adc" -exec ffmpeg -f s16le -ar 16000 -ac 2 -i {} -ac 1 {}.wav \;
find . -type f -name "*senn.adc" -exec ffmpeg -f s16le -ar 16000 -ac 1 -i {} {}.wav \;
find . -type f -name "*arrA.adc" -exec ffmpeg -f s16be -ar 16000 -ac 8 -i {} -ac 1 {}.wav \;

find . -type f -name "*.adc" -exec ffmpeg -f s16be -ar 16000 -ac 8 -i {} {}.wav \;

ffmpeg -i an106-mahs-arrA.wav -ac 1 an106-mahs-arrA_1.wav

ffmpeg -f s16be -ar 16000 -ac 1 -i file3.adc file3.wav

https://trac.ffmpeg.org/wiki/audio%20types

find DIR_NAME -type f | wc -l

apt-get install libao-dev

wget http://www.vorbis.com/files/beta4/unix/pyao-0.0.2.tar.gz
tar xf pyao-0.0.2.tar.gz

http://stackoverflow.com/questions/956720/python-open-raw-audio-data-file


http://www.audacityteam.org/download/mac/

Linux: apt-get install python-pyao
https://www.howtoinstall.co/en/debian/wheezy/main/python-pyao/

import soundfile as sf
import sounddevice as sd

sig, fs = sf.read('myfile.adc', channels=2, samplerate=16000,
                  format='RAW', subtype='PCM_16')
sd.play(sig, fs)

ffmpeg -f s16be -ar 16000 -ac 1 -i file3.adc file3.wav

https://trac.ffmpeg.org/wiki/audio%20types

Signed 16 Bit PCM
Big-endian
1 Channel
16000


 DE yuv4mpegpipe    YUV4MPEG pipe

 DE yuv4mpegpipe YUV4MPEG pipe

ffmpeg -formats | tr -s ' ' | cut -d ' ' -f 3