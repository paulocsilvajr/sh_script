#!/bin/bash

if [ -z $1 ]; then
    echo "Informe um arquivo/pasta ou -h para ajuda"
elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
    echo "Sintaxe: $0 [ -f ] ARQUIVO"
    echo "         $0 [ -h | --help ]"
    echo "Renomeia arquivo/pasta no formato dataAtual_nomeArqOuPasta"
    echo 
    echo "-h --help:   Ajuda"
    echo "-f:          Data completa(full)"
else
    if [ $1 = "-f" ]; then
        data=$(date +%Y%m%d_%H%M%S_)
        arquivo=$2
    else
        data=$(date +%Y%m_)
        arquivo=$1
    fi

    # se arquivo existir, renomeia
    if [ -e $arquivo ]; then
        mv "${arquivo}" $data$arquivo
    else
        echo "Arquivo/pasta não existe($arquivo)"
    fi
fi
