#!/bin/bash

get_associados() {
    curl --location --request GET --insecure --output file.html --silent "https://abcomm.com.br/abcomm/Associados_1.php?p=$1&c=&e=&s="
    cat file.html | grep -Eoi '<a [^>]+>' | grep -Eo 'href="[^\"]+"' | grep -Eo '(http|https)://[^/"]+'
}

for i in `seq 0 287` 
do 
    get_associados $i
done

[ ! -f file.html ] || { rm -f file.html; }
