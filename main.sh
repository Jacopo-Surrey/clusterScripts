#!/bin/bash

## variables to set for child (slurm.sh):
## detectorWidthUM , detectorThicknessUM , detectorDepthMM

## assumes that both this and slurm.sh are in the same folder

## creates a folder for each set of parameters, and executes slurm.sh from there
## << IMPORTANT >> make sure that if you set a relative path for $buildPath in slurm.sh, such path accounts for this folder

module load Python
module load geant4

for detectorWidthUM in 300
do
	for detectorThicknessUM in 1 5 25 100
	do
		for beamEnergyMEV in 58 150 250
		do
			for detectorDepthMM in $(python3 getDepthForEnergy.py $beamEnergyMEV)
			do
				directoryName=wide$detectorWidthUM.thick$detectorThicknessUM.deep$detectorDepthMM.ene$beamEnergyMEV
				
				mkdir $directoryName			
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
				
				export beamEnergyMEV
				echo beam energy $beamEnergyMEV MeV >> $logFile
				
				jobName=g4.$detectorWidthUM.$detectorThicknessUM.$detectorDepthMM.$beamEnergyMEV
				cp ../*.sh ../*.py ../*.csv .
				echo launching slurm script... >> $logFile
				sbatch --job-name="$jobName" slurm.sh >> $logFile
				
				cd ..
				
			done
		done
	done
done
