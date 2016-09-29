#!/bin/sh

cd $1
server=`svn info -r HEAD | grep -i "Last Changed Rev"`
mine=`svn info | grep -i "Last Changed Rev"`
IFS=':'
if [ "$serverN" -gt "$mineN" ]
then
    echo "T"
else
    echo "F"
fi
