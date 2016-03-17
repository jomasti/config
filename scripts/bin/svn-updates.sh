#!/bin/sh

cd $1
server=`svn info -r HEAD | grep -i "Last Changed Rev"`
mine=`svn info | grep -i "Last Changed Rev"`
IFS=':'
read -r string serverN <<< "$server"
read -r string mineN <<< "$mine"
if [ "$serverN" -gt "$mineN" ]
then
    echo "T"
else
    echo "F"
fi
