import sys

depthMM = float(sys.argv[1])
energyMEV = float(sys.argv[2])
target = float(sys.argv[3])

jobs = 50
simRateHour = 100000 #unused

ratio=100000000 #if no data

if 147 <= energyMEV <= 153 :
	if 20 <= depthMM <= 39 :	#32
		ratio=0.02755
	elif 141 <= depthMM <= 147:	#144
		ratio=0.00131
	elif 152 <= depthMM <= 156:	#155
		ratio=0.000818
	elif 157 <= depthMM <= 159:	#158
		ratio=0.0004939
	elif 160 <= depthMM <= 166:	#163
		ratio=0.000066
#elif

required = target / ratio / jobs

print( round(required) )
