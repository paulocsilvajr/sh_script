#!/bin/bash

USER="kdepaulo"
DIR_BASE="/home/"$USER"/.mozilla/firefox/"
DIR_USER_FIREFOX=$(ls $DIR_BASE | grep '.default')
DIR_ORIGEM=$DIR_BASE$DIR_USER_FIREFOX"/bookmarkbackups"
DIR_BACKUP="/home/paulo/pc/bookmark_"$USER

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

cp -R $DIR_ORIGEM/* $DIR_BACKUP && echo "Data:" $(date +%Y%m%d_%H%M%S) >> $DIR_BACKUP/backup.log
