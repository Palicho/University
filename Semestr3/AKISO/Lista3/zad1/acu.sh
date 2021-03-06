#!/bin/bash 

tmp=$( cat "/sys/class/power_supply/BAT0/uevent" |  grep "POWER_SUPPLY_CAPACITY=")

echo ${tmp#POWER_SUPPLY_CAPACITY=}
