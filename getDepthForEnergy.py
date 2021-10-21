import sys
import numpy as np

energy = float(sys.argv[1])

energy = round(energy)

fileName = str(energy) + ".csv" 

dose = np.loadtxt(fileName)

# each term of the array is located at a depth in mm
# equal to its index

simPts = []

# maximum
dMax = np.argmax(dose)
simPts.append(dMax)

# assuming that the peak is normalised to unity...

# dose 60 entrance
d60l = np.argmax( dose > 0.6 )

simPts.append(d60l)

# dose 20 distal falloff
rDose = dose[dMax:]

d60r = dMax + np.argmax( rDose < 0.8 )

simPts.append(d60r)

# dose 80 distal falloff
d80 = dMax + np.argmax( rDose < 0.2 )

simPts.append(d80)

# entrance
metric = d80 - dMax

dEntr = metric*4

simPts.append(dEntr)

# print to stdout
s = ""

for pt in simPts :
	s = s + str(pt) + " "

print(s)

