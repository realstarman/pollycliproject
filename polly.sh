#!/bin/bash
# Script to make my Mac say stuff using Amazon Polly
# requires properly setup AWS CLI
# Go to https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
# for instructions on how to set this up

#instructions: 
# 1. Create or appoint a directory for you temp speech file and choose a name. Then put it into these variables
pollyfile="$HOME/polly/speech.mp3"
pollydir="$HOME/polly/"

# calculkate the hash value comment out, if yiou don#t want this feature
pfilename="$( echo -n $* | md5 )"
pollyfile=$pollydir$pfilename".mp3"
echo $pollyfile2

# 2. select a voice - only one!!!

# voice='Aditi
# voice='Amy
# voice='Astrid'
# voice='Bianca'
# voice='Brian'
# voice='Camila'
# voice='Carla'
# voice='Carmen'
# voice='Celine'
# voice='Chantal'
# voice='Conchita'
# voice='Cristiano' # only standard
# voice='Dora'
# voice='Emma'
# voice='Enrique' # only standard
# voice='Ewa'
# voice='Filiz'
# voice='Geraint'
# voice='Giorgio'
# voice='Gwyneth'
# voice='Hans' # only standard
# voice='Ines'
# voice='Ivy'
# voice='Jacek'
# voice='Jan'
# voice='Joanna'
# voice='Joey'
# voice='Justin'
# voice='Karl' # only standard
voice='Kendra'
# voice='Kimberly'
# voice='Lea'
# voice='Liv'
# voice='Lotte'
# voice='Lucia'
# voice='Lupe'
# voice='Mads'
# voice='Maja'
# voice='Marlene'
# voice='Mathieu'
# voice='Matthew'
# voice='Maxim'
# voice='Mia'
# voice='Miguel'
# voice='Mizuki'
# voice='Naja'
# voice='Nicole'
# voice='Penelope'
# voice='Raveena'
# voice='Ricardo'
# voice='Ruben'
# voice='Russell' # only standard
# voice='Salli'
# voice='Seoyeon'
# voice='Takumi'
# voice='Tatyana'
# voice='Vicki'
# voice='Vitoria'
# voice='Zeina'
# voice='Zhiyu'

engine="standard"
# engine="neural"

ttype="text"
# ttype="ssml" 

# Uncommen t the language you need
languagecode='de-DE' # German
# languagecode='en-AU' # Australian
# languagecode='en-GB' # British
# languagecode='en-GB-WLS' # Welsh
# languagecode='en-IN' # Indian
# languagecode='en-US' # US
# For more, look up https://docs.aws.amazon.com/cli/latest/reference/polly/synthesize-speech.html

helptext=$'
usage: polly <text>
      where text is a string that is parsed and then spoken
usage: polly [-i inputfile] [-t texttype] [-v voice] [-l language] [-L lexicon-names] [-k] [-d]
      where inputfile contains the text texttype (also --inputfile)
            texttype (text/ssml) specifies text (default) vs ssml (also --texttype)
            voice specifies the voice (also --voice)
            engine specifies the engine (standard/neural) (also --engine)
            lexicon-names sopecifies the lexicon names (also --lexi or --lexicon-names)
            language specifies the engine  (also --language)
                e.g. de-DE, en-US, en-GB or simplified en, de, in, au
            -k specifies to keep the speech file (also --keep)
            -d prodcues some debugging output (also --debug)'




# uncomment the next line to get debug output
# debug="true"

# Param check
if [ -z "$1" ]
then
    echo "$helptext"

    exit
fi


# Variables definition
while [[ "$#" -gt 0 ]]; do 
case $1 in
  -i|--input) inputfile="$2"; shift;;
  -t|--texttype) ttype="$2"; shift;;
  -v|--voice) voice="$2"; shift;;
  -L|--lexi|--lexicon-names) lexicons="$2"; shift;;
  -e|--engine) engine="$2"; shift;;
  -l|--language) languagecode="$2"; shift;;
  -k|--keep) keep="true";;
  -d|--debug) debug="true";;
  -h|--help) help="true";;
  *) text="$1";;
esac; shift
done

# Checks

# if help is set, just display the help text and exit

if [ $help ]
then
 echo "$helptext"
 exit
fi

# check if pollyfile exists and if not if it can be written

if [ -f "$pollyfile" ]
then
    if [ $debug ]
    then
        echo "$pollyfile exist"
    fi
else
    if touch $pollyfile
    then
        if [ $debug ]
        then
            echo "$pollyfile can be written"
            rm $pollyfile
        fi
    else
        echo "Error: $pollyfile cannot be written. Please check if the directory exists and can be written to!"
        exit 1
    fi
fi



# inputfile - check
if [ ! -z $inputfile ] 
then
    if [ -f "$inputfile" ] 
    then
            text=$(<$inputfile)
    else
        echo "Error: File not found: $inputfile"
        exit 1
    fi

fi

# text - check
if [ -z "$text" ]
then
    echo "Error: No text or inputfile specified!"
    exit 1
    
fi

# language check and processing - it's intended that other strings are passing through
# polly service will throw an error ifan invalid language paramater is used


case $languagecode in
  de|DE|De) languagecode='de-DE';;
  au|AU|Au) languagecode='en-AU';;
  us|US|Us|en|EN|En) languagecode='en-US';;
  gb|GB|Gb) languagecode='en-GB';;
  in|IN|In) languagecode='en-IN';;
esac
  
  

# finally dump everyting to the screen if debug output is specified

if [ $debug ]
then
    # Debugging output
    echo '*** Debug Info: ***'
    echo 'saying:' "$text" 
    echo 'voice:' "$voice"
    echo 'engine:' "$engine"
    echo 'text-type:' "$ttype"
    echo 'language:' "$languagecode"
    echo 'lexicons:' "$lexicons"
    echo 'file:' "$pollyfile"
fi

aws polly synthesize-speech --output-format mp3 --text "$text" --language-code $languagecode --lexicon-names $lexicons --voice-id $voice --engine $engine --text-type $ttype $pollyfile

# Check result

aws_return_code=$?

if [ $aws_return_code -eq 0 ]
then
    if [ $debug ]
    then
        echo Success: call to polly successful
    fi
else
    echo Error: call to polly failed
    exit $aws_return_code
fi

# Play soundfile

if [ -f $pollyfile ]
then 
    afplay $pollyfile
    if [ ! $keep ]
    then
        rm $pollyfile
    else
        echo Output: $pollyfile
    fi
fi

exit





# Backlog
# need to check inputs of engine, voice and ttype for validity
# Make pollyfile a hash of input paramaters - consider adding then date/time
# at the same time add a -c/--cleanup paramater that will remove all *mp3 files from the folder




