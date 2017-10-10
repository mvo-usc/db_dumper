#!/usr/bin/env bash

# put this file to remote host
DB_HOST=''
DB_USER=''
DB_NAME=''

if [ "$1" = "de" ]
then
    echo "Getting dump for Germany";
elif [ "$1" = "fr" ]
then
    echo "Getting dump for France";
else
    echo "Cannot get dump for '$1'";
    exit 1;
fi

#todo: add checking existed class

echo "Dump database"
sudo pg_dump -O -v -h $DB_HOST -U $DB_USER $DB_NAME > /tmp/$1-dump.sql

echo "Archive database"
tar -czvf /tmp/$1-dump.sql.tar.gz /tmp/$1-dump.sql

echo "Remove raw dump"
rm -f /tmp/$1-dump.sql
