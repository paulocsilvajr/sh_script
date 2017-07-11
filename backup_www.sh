#!/bin/bash

DIR_BACKUP="/home/paulo/www_backup"

if [ ! -d "$DIR_BACKUP" ]; then
    mkdir "${DIR_BACKUP}" 
fi

cp -R /var/www/* $DIR_BACKUP && echo "Data:" $(date +%Y%m%d_%H%M%S) >> $DIR_BACKUP/backup.log
