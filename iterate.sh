#!/bin/bash
# iterates through polly voices

# specify file to used for test input
inputfilename=$HOME/scripts/pollytexts/gentlemen.ssml


for voice in 'Brian' 'Aditi' 'Cristiano' 'Enrique' 'Giorgio' 'Hans' 'Jacek' 'Joey' 'Justin' 'Karl' 'Mathieu' 'Matthew' 'Maxim' 'Miguel' 'Ricardo' 'Ruben' 'Russell' 'Takumi';
do
    echo $voice
    polly.sh -i "$inputfilename" -t ssml -v $voice 
done

exit