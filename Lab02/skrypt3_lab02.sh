#!/bin/bash -e

DIRECTORY=${1}

set -u

DIRECTORY_NOT_FOUND=100
WRONG_NUMBER_OF_ARGUMENTS=200

if [[ ! $# -eq 1 ]]; then
    echo "Niepoprawna liczba argumentow!"
	exit ${WRONG_NUMBER_OF_ARGUMENTS}
fi

if [[ ! -d ${DIRECTORY} ]]; then
    echo "Nie ma takiego katalogu!"
	exit ${DIRECTORY_NOT_FOUND}
fi

DIRECTORY_CONTENT=$(ls ${DIRECTORY})

for FILE in ${DIRECTORY_CONTENT}; do

    if [[ -f ${DIRECTORY}/${FILE} && ${FILE#*.} == "bak" ]]; then
        chmod uo-w ${DIRECTORY}/${FILE}
    fi

    if [[ -d ${DIRECTORY}/${FILE} && ${FILE#*.} == "bak" ]]; then
        chmod ug-x,o+x ${DIRECTORY}/${FILE}
    fi

    if [[ -d ${DIRECTORY}/${FILE} && ${FILE#*.} == "tmp" ]]; then
        chmod a+wx ${DIRECTORY}/${FILE}
    fi

    if [[ -e ${DIRECTORY}/${FILE} && ${FILE#*.} == "txt" ]]; then
        chmod u+r-wx,g+w-rx,o+x-rw ${DIRECTORY}/${FILE}
    fi

    if [[ -f ${DIRECTORY}/${FILE} && ${FILE#*.} == "exe" ]]; then
        sudo chmod a+x ${DIRECTORY}/${FILE}
    fi

done