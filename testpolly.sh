#!/bin/bash
# Testrun for polly.sh
#

# location of polly speech file
pollydir="$HOME/polly/"
pollyclear=$pollydir*
textfile="./pollytest.txt"
ssmlfile="./pollytest.ssml"


# clean pollydir
echo cleaning $pollydir:
rm -rfv $pollyclear

# create ssml inputfile
echo "<speak>three</speak>" > $ssmlfile

# create text inputfile 
echo "four" > $textfile

echo "************************"
echo "* Test polly.sh script *"
echo "************************"
echo "You should see and hear a count from 1 through 9 with a German acht (eight)"
echo "and a success message in the end"

# run with voice Matthew "one"
echo "one!"
polly.sh -v Matthew "one" >>/dev/null

# run with engine neural "two"
echo "two!"
polly.sh --voice Matthew "two" -e neural >>/dev/null

# run ssdml with inputfile "three"
echo "three!"
polly.sh -i $ssmlfile -t ssml -engine neural >>/dev/null

# run text with inputfile "four"
echo "four!"
polly.sh --input $textfile >>/dev/null

# run ssdml with cli string input "five"
echo "five!"
polly.sh -v Matthew "<speak>five</speak>" --texttype ssml -l en >>/dev/null

# run text with cli string input  and -k "six"
echo "six!"
polly.sh "six" -k >>/dev/null

# run with --keep option "seven"
echo "seven!"
polly.sh "seven" --keep >>/dev/null

# run with -l de option "acht"
echo "acht!"
polly.sh -v Hans --language de "acht" >>/dev/null

# check whether there is exactly 2 file in pollydir

numfiles=$(ls $pollydir/*.mp3 | wc -w)

if [ $numfiles = 2 ]
then
    echo "-k successful!"
else
    echo "Failure: Check -k option! There should be 2 mp3 file but there are " $numfiles
fi

echo "nine!"
polly.sh -v Matthew -c "nine" >>/dev/null

numfiles=$(ls $pollydir/*.mp3 2>/dev/null | wc -w)

if [ $numfiles = 0 ]
then
    echo "Success!"
else
    echo "Failure: Check -c option! There should be no mp3 file but there are " $numfiles
fi


# Cleanup
rm $textfile
rm $ssmlfile

# check, tested
# -v, --voice
# -i, --inputfile
# -e, --engine
# -t, --texttype
# -l, --language



