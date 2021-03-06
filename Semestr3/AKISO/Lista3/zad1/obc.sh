#!/bin/bash

obc=$(cat "/proc/loadavg" | awk '{print $1}')
echo ${obc}
