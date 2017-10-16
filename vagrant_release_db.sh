#!/usr/bin/env bash

#put this file to /home/vagrant
if [ "$1" = "de" ]
then
    echo "Release dump for Germany";
elif [ "$1" = "fr" ]
then
    echo "Release dump for France";
else
    echo "Cannot release dump for '$1'";
    exit 1;
fi

echo "Syncing date"
sudo sntp -s 24.56.178.140;

echo "Extracting archive"
tar xf /vagrant/data/$1-dump.sql.tar.gz -C /vagrant/data/;

echo "Deleting exited tables"
PGPASSWORD=$1-dev psql -h localhost -U $1-dev $1-dev -t -c "select 'drop table if exists \"' || tablename || '\" cascade;' from pg_tables  where schemaname = 'public';" | PGPASSWORD=$1-dev psql -h localhost -U $1-dev $1-dev

echo "Rolling out tables"
PGPASSWORD=$1-dev psql -h localhost -U $1-dev $1-dev < /vagrant/data/tmp/$1-dump.sql;

echo "Cleaning up dumps"
rm -f /vagrant/data/tmp/$1-dump.sql; rm -f /vagrant/data/$1-dump.sql.tar.gz
