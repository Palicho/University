#!/bin/bash

getPps () {

	pps="$1" 

	if [ $pps -gt 1000000 ]
	then
   		pps=$((pps/1000000))" MB"

	elif [ $pps -gt 1000 ] && [ $pps -lt 1000000 ] 
	then
    		pps=$((pps/1000))" KB"

	else
   		pps=$pps" B"	
	fi

	echo ${pps};
}


graph () {
	acu="$1"
	echo -ne '['
	
	for i in $( seq 1 "$acu")
	do 
		echo -ne '#'
	done

	for i in $( seq $(( 100 - "$acu" )) )
	do
		echo -ne '.'
	done

	echo -e ']'
}


n=0;



while : 
do 
	let n++
	time=$( ./time.sh & ) 
	acu=$( ./acu.sh & ) 
	pps=$( ./pps.sh & ) 
	obc=$( ./obc.sh & )

 	let "( avgPps= ( avgPps * ( n - 1 ) + pps ) / n )"
	echo "Aktualna predkosc przesylania danych: " $(getPps "$pps")	
	echo "Srednia predkosc przesyalania danych: " $(getPps "$avgPps")
	echo "Aktualna obciazenie systemu: $obc" 	
	echo "Aktualny stan baterii: $acu"
	echo "System dziala od: $time" 	
	graph $acu
		
	sleep 1 
	clear
done 
