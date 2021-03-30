#!/bin/bash

## variables to set for child (slurm.sh):
## detectorWidthUM , detectorThicknessUM , detectorDepthMM

## assumes that both this and slurm.sh are in the same folder

## creates a folder for each set of parameters, and executes slurm.sh from there
## << IMPORTANT >> make sure that if you set a relative path for $buildPath in slurm.sh, such path accounts for this folder

for detectorWidthUM in 300
do
	for detectorThicknessUM in 1 5 25 100
	do
		for detectorDepthMM in 10 80 170 200 250
		do		
			
			directoryName=wide$detectorWidthUM.thick$detectorThicknessUM.deep$detectorDepthMM
			
			cd $directoryName
			
			logFile=simulation.log
			
			pwd >> $logFile
			date >> $logFile
			
			echo MicroDiamond detector in water phantom >> $logFile
			
			export detectorWidthUM
			echo detector width $detectorWidthUM um >> $logFile
			
			export detectorThicknessUM
			echo detector thickness $detectorThicknessUM um >> $logFile
			
			export detectorDepthMM
			echo depth in water $detectorDepthMM mm >> $logFile
			
			echo launching slurm script... >> $logFile
			../slurm.sh >> $logFile
		
		done
	done
done