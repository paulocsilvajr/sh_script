#!/bin/bash

# instalar speedtest-cli pelo pip2
# pip2 install speedtest-cli

nome_arquivo=$(date +%Y%m%d_%H%M_)teste.ping;
T=10
END="8.8.8.8"
DIR="teste/"

arquivo=${DIR}${nome_arquivo}

echo "PING $END ..." > $arquivo;
echo "" >> $arquivo;
ping -c $T -q "$END" >> $arquivo;
echo "" >> $arquivo;

echo "SPEEDTEST-CLI ..." >> $arquivo;
echo "" >> $arquivo;
speedtest-cli >> $arquivo;

if [ "$1" == "-s"  ]; then
    cat $arquivo
fi
