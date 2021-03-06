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



function getDate () {
    num=$1
    min=0
    hour=0
    day=0
    if((num>59));then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi
    echo "$day"d "$hour"h "$min"m "$sec"s
}


getProcTime () {
 	tmp=$(cat /proc/uptime | awk '{print $1}')
	int=${tmp/.*}
	procTime=$( getDate  ${int}  )
	echo ${procTime}

}



echo $( getPps )
echo $( getProcTime )


