#!/bin/bash -e

FIRST_ARGUMENT=${1}
SECOND_ARGUMENT=${2}

set -u

DIRECTORY_NOT_FOUND=100
WRONG_NUMBER_OF_ARGUMENTS=200

if [[ ! $# -eq 2 ]]; then
    echo "Niepoprawna liczba argumentow!"
	exit ${WRONG_NUMBER_OF_ARGUMENTS}
fi

if [[ ! -d ${FIRST_ARGUMENT} || ! -d ${SECOND_ARGUMENT} ]]; then
    echo "Nie ma takiego katalogu!"
	exit ${DIRECTORY_NOT_FOUND}
fi

FIRST_ARGUMENT_CONTENT=$(ls ${FIRST_ARGUMENT})

for FILE in ${FIRST_ARGUMENT_CONTENT}; do
    UPPER_CASE=${FILE^^}
    NO_EXTENSION=${UPPER_CASE%.*}

    if [[ -f ${FIRST_ARGUMENT}/${FILE} ]]; then
	    echo "${FILE} to plik regularny."

        if [[ ${UPPER_CASE} == ${NO_EXTENSION} ]]; then
            ln -s ../${FIRST_ARGUMENT}/${FILE} ${SECOND_ARGUMENT}/${NO_EXTENSION}_ln
        else
            ln -s ../${FIRST_ARGUMENT}/${FILE} ${SECOND_ARGUMENT}/${NO_EXTENSION}_ln.${FILE#*.}
        fi
	fi

    if [[ -d ${FIRST_ARGUMENT}/${FILE} ]]; then
        ln -s ../${FIRST_ARGUMENT}/${FILE} ${SECOND_ARGUMENT}/${UPPER_CASE}_ln
	    echo "${FILE} to katalog."
	fi

    if [[ -L ${FIRST_ARGUMENT}/${FILE} ]]; then
	    echo "${FILE} to dowiazanie symboliczne."
	fi

done