#!/bin/bash

# instalar speedtest-cli pelo pip2
# pip2 install speedtest-cli

nomeArquivo=$(date +%Y%m%d_%H%M_)teste.ping;
T=100
END="8.8.8.8"

echo "PING $END ..." > $nomeArquivo;
echo "" >> $nomeArquivo;
ping -c $T -q "$END" >> $nomeArquivo;
echo "" >> $nomeArquivo;

echo "SPEEDTEST-CLI ..." >> $nomeArquivo;
echo "" >> $nomeArquivo;
speedtest-cli >> $nomeArquivo;

if [ "$1" == "-s"  ]; then
    cat $nomeArquivo
fi
