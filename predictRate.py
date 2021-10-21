import sys

normal = True

depthMM = float(sys.argv[1])
energyMEV = float(sys.argv[2])
target = float(sys.argv[3])

drop=1.87 * energyMEV -113 -(energyMEV /20)

A = 66 * energyMEV- 4400

if depthMM < drop :
	B =  0.000012 * energyMEV -0.0023
else :
	B = 0.000024 * energyMEV -0.0048

ratio = A /pow(depthMM, 3) + B

required = target / ratio

if required < 0 :
	required = -required
	if required > 500000 :
		required = 500000

if normal :
	print( int(required) )

else :
	simRateHour = 100000
	jobs = 10
	print( round(required/simRateHour/jobs/24) )

# worst case scenario with 10 jobs:
# 1 day required for a 1000 sample spectrum, 1 week for 10000
