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

if [[ ! -d ${FIRST_ARGUMENT} ]]; then
    echo "Nie ma takiego katalogu!"
	exit ${DIRECTORY_NOT_FOUND}
fi

FIRST_ARGUMENT_CONTENT=$(ls ${FIRST_ARGUMENT})
CURRENT_DATE=$(date --iso-8601)

for FILE in ${FIRST_ARGUMENT_CONTENT}; do

    if [[ -L ${FIRST_ARGUMENT}/${FILE} && ! -e ${FIRST_ARGUMENT}/${FILE} ]]; then
        rm ${FIRST_ARGUMENT}/${FILE}
        echo ${FILE} - ${CURRENT_DATE} >> ${SECOND_ARGUMENT}
    fi

done