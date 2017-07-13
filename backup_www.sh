#!/bin/bash

DIR_BACKUP="/home/paulo/www_backup"

ajuda(){
    echo "Script elaborado para efetuar backup de /var/www sem interferência humana através do cron."
    echo "Sintaxe: $0 [ -h | --help ]"
    echo "-h --help      ajuda"

exit
}

case $1 in
    "-h"|"--help")
        ajuda;;
esac


if [ ! -d "$DIR_BACKUP" ]; then
    mkdir "${DIR_BACKUP}" 
fi

cp -R /var/www/* $DIR_BACKUP && echo "Data:" $(date +%Y%m%d_%H%M%S) >> $DIR_BACKUP/backup.log
