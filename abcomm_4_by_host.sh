#!/bin/bash

[ $1 ] && [ -d sites_phase2/$1 ] || { echo "Uso: $0 <host_name>"; exit; }

for i in sites_phase2/$1/*.txt
do
	echo -n "bash -x check_ssl.sh $i ... "
	bash -x abcomm_3_ssl_scan.sh $i &> $i.log & 
    sleep 1
    echo "[running on background]."
    echo "check logs on file $i.log"
    echo ""
done

