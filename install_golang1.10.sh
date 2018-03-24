#!/bin/bash

ARQUIVO='go1.10.linux-amd64.tar.gz'
LINK_DOWNLOAD="https://dl.google.com/go/$ARQUIVO"

DIR_INSTALACAO='/usr/local'
PROFILE="$HOME/.profile"

echo "Baixando GO(golang) pelo link: $LINK_DOWNLOAD"
wget $LINK_DOWNLOAD

echo "Descompactando $ARQUIVO e instalando em $DIR_INSTALACAO"
sudo tar -C $DIR_INSTALACAO -xzf $ARQUIVO

echo "Criando diretórios do go na pasta $HOME"
mkdir $HOME/go
mkdir $HOME/go/bin
mkdir $HOME/go/pkg
mkdir $HOME/go/src

echo "Adicionando ao PATH do sistema e criando variável $GOPATH"
echo 'export PATH=$PATH:/usr/local/go/bin' >> $PROFILE
echo 'export GOPATH=$HOME/go' >> $PROFILE
echo 'export PATH=$PATH:$GOPATH/bin' >> $PROFILE

echo -e "Remover o arquivo baixado $ARQUIVO[s/N]: "
read CONFIRM_REMOVE
if [ ${CONFIRM_REMOVE^^} == 'S' ]; then
    rm -v $ARQUIVO
else
    echo "Mantido arquivo $ARQUIVO"
fi
