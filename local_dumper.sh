#!/usr/bin/env bash

# path to project on your local environment
PROJECT_PATH=''
#remote host
REMOTE_HOST=''

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

ssh $REMOTE_HOST "sh remote_dump.sh $1"
cd $PROJECT_PATH;
scp $REMOTE_HOST:/tmp/$1-dump.sql.tar.gz data/
vagrant ssh -- -t "sh /home/vagrant/vagrant_release_db.sh $1"
