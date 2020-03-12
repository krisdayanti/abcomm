#!/bin/bash

[ $1 ] && [ -f $1 ] || { echo "Uso: $0 <arquivo_URLs.txt>"; exit; }

while read SITE
do
    OUT_LOG=$(mktemp)
    OUT_FILE=$(mktemp)
    wget --timeout=10 --no-check-certificate -o $OUT_LOG --output-document=$OUT_FILE $SITE
    if [ $? -eq 0 ]
    then
        echo $SITE:OK
    else
        HOST=$(echo $SITE | sed 's/^.*\/\///')
        host $HOST &> $OUT_LOG
        if [ $? -eq 0 ]
        then
            echo $SITE:OK
        else
            echo $SITE:ERROR
        fi
    fi
    rm -f $OUT_LOG $OUT_FILE
done < $1
