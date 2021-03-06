#!/bin/bash


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

abc () {
  num=$1
  echo ${num}
}

getProcTime () {
 	tmp=$(cat /proc/uptime | awk '{print $1}')
	int=${tmp/.*}
	procTime=$( getDate  ${int}  )
	echo ${procTime}

}




echo $( getProcTime )


