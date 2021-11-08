#!/bin/bash

depthMM="$1" 
energyMEV="$2"
target="$3"

jobs=50
simRateHour=100000 #unused

ratio=100000000 #if no data

if [[ $energyMEV -eq 150 ]]
then
	case $depthMM in
		2[0-9]|3[0-9])	#32
			ratio=0.02755
		;;
		14[1-7])	#144
			ratio=0.00131
		;;
		15[2-6])	#155
			ratio=0.000818
		;;
		15[7-9])	#158
			ratio=0.0004939
		;;
		16[0-6])	#163
			ratio=0.000066
		;;
	esac
fi
#elif

required=$(expr $target/$ratio/$jobs | bc)

echo $required
