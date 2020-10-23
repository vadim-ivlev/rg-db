#!/bin/bash

st=36
#N0=0
while true
do

	echo
	echo "Counting..."
	echo

	start=`date +%s`
	#N=`docker exec -it rgdb-postgres psql rgdb -c 'COPY (SELECT count(obj_id) FROM  articles WHERE process_status IS  NULL) TO STDOUT'`
	docker exec -it rgdb-postgres psql rgdb -c "COPY (SELECT count(1) FROM  articles WHERE process_status = 'success') TO STDOUT"
	end=`date +%s`
	dur=$((end-start))

	echo "Counting took $dur seconds."
	date +"%T"
	#dif=$((N-N0))
	#echo "Difference =  $dif records."
	#N0=$N
	
	echo
	echo "Waiting $st seconds ..."
	sleep $st

done

