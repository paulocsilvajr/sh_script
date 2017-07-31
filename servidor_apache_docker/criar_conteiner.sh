#!/bin/bash

nomeIMG="paulocsilvajr/servidor"
nomeCONTAINER="servidor_apache"

imagem=$(docker images | grep $nomeIMG)

if [ $(id -u) -eq 0 ]; then
    if [ -z "$imagem" ]; then
        docker build -t $nomeIMG . && \
        echo "Criado imagem [$nomeIMG]" && \
        docker images | grep $nomeIMG
    else
        echo "Imagem [$nomeIMG] já existe"
    fi
        
    docker run -d --name=$nomeCONTAINER $nomeIMG && \
    echo -e "\n\nCriado conteiner [$nomeCONTAINER] baseado na imagem [$nomeIMG]" && \
    docker ps -a | grep $nomeCONTAINER || \
    echo -e "\n\nProblema na criação do conteiner [$nomeCONTAINER]"

else
    echo "Execute como administrador"
fi
