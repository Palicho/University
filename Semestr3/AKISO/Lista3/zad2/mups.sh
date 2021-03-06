#!/bin/bash

exec 2>/dev/null
pids=$( ls '/proc' | grep -E '[0-9]' )

echo "pid "

for pid in $pids; do
	#tmp=$( cat "/proc/${proc}/status" )	
	echo "Pid: ${pid} " 
	echo -e "\t $(  grep 'PPid' "/proc/${pid}/status" )"	
	echo -e "\t $(  grep 'Name' "/proc/${pid}/status" )"
	echo -e "\t $(  grep 'State' "/proc/${pid}/status" )"
	echo -e "\t Number of files:  $( ls "/proc/${pid}/fd"  | wc -l )"
done
