#!/bin/bash


getPps () {

	pps=$(grep 'wlp2s0:' /proc/net/dev |  awk '{print $10}') 
   
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

echo $(grep 'wlp2s0:' /proc/net/dev |  awk '{print $10}')  
