#!/bin/bash -eu

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-lab_uno/2remove}
TARGET_DIR=${3:-bakap} 

if [[ ! -d ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi

RM_LIST_CONTENT=$(cat ${RM_LIST})

for ITEM in ${RM_LIST_CONTENT}; do
    if [[ -e ${SOURCE_DIR}/${ITEM} ]]; then
        rm -r ${SOURCE_DIR}/${ITEM}
    fi
done

SOURCE_DIR_CONTENT=$(ls ${SOURCE_DIR})
for ITEM in ${SOURCE_DIR_CONTENT}; do
    if [[ -f ${SOURCE_DIR}/${ITEM} ]]; then
        mv ${SOURCE_DIR}/${ITEM} ${TARGET_DIR}
    fi

    if [[ -d ${SOURCE_DIR}/${ITEM} ]]; then
        cp -r ${SOURCE_DIR}/${ITEM} ${TARGET_DIR}
    fi
done

NUMBER_OF_FILES_LEFT=$(ls ${SOURCE_DIR} | wc -w)

if [[ ${NUMBER_OF_FILES_LEFT} -gt 0 ]]; then
    echo "Jeszcze coś zostało!"

    if [[ ${NUMBER_OF_FILES_LEFT} -ge 2 ]]; then
        echo "Zostały conajmniej 2 pliki!"
    fi

    if [[ ${NUMBER_OF_FILES_LEFT} -gt 4 ]]; then    
        echo "Zostało więcej niż 4 pliki!"
    fi

    if [[ ${NUMBER_OF_FILES_LEFT} -ge 2 && ${NUMBER_OF_FILES_LEFT} -le 4 ]]; then
        echo "Zostały przynajmniej 2 pliki, ale co najwyżej 4!"
    fi

else
    echo "Kononowicz tu był :(" 
fi

TARGET_DIR_CONTENT=$(ls ${TARGET_DIR})
for ITEM in ${TARGET_DIR_CONTENT}; do
    chmod -R -w ${TARGET_DIR}/${ITEM}
done

zip -r bakap_$(date +'%Y-%m-%d').zip ${TARGET_DIR}