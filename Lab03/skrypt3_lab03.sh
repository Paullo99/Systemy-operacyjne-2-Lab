#!/bin/bash -eu

GROOVIES_CONTENT=$(ls ./samples/groovies)
for FILE in ${GROOVIES_CONTENT}; do
    # We wszystkich plikach w katalogu ‘groovies’ zamień $HEADER$ na /temat/
    cat ./samples/groovies/${FILE} | sed -ri 's/\$HEADER\$/\/temat\//g' ./samples/groovies/${FILE}

    # We wszystkich plikach w katalogu ‘groovies’ po każdej linijce z 'class' dodać ' String marker = '/!@$%/''
    cat ./samples/groovies/${FILE} | sed -ri '/class/a String marker = "\/!@\$%\/"' ./samples/groovies/${FILE}

    # We wszystkich plikach w katalogu ‘groovies’ usuń linijki zawierające frazę 'Help docs:'
    cat ./samples/groovies/${FILE} | sed -ri '/docs:/d' ./samples/groovies/${FILE}
done