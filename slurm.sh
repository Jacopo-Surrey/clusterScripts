#!/bin/bash

#SBATCH --partition=shared
#SBATCH --time=7-00:00

##SBATCH --job-name="geant4"
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --array=0-4
#SBATCH --output=%x_%a_std.out

## ---------------------------------------

## parameters to be costumised:
runName=geant4	## any name to give to the current run
buildPath=/users/jm01955/simulations/build	## path to executable build directory
executableName=myProgram	## name of the G4 executable
mainMacroName=run	## name of the main macro to be run (w/o .mac)
detectorMacroName=detector ## detector properties macro
gpsMacroName=gps_beam ## general particle source macro
physicsMacroName=phys ## cuts and physics macro
outputExtension=csv	## usually either csv or root

## ---------------------------------------

date

## create a new folder for this task, and copy the G4 executable there
folderName=run_$runName\_$SLURM_ARRAY_TASK_ID
	## the \ is required to specify that _ is to be treated as a character
mkdir $folderName
cp -r $buildPath/* ./$folderName
cd $folderName

## modify the seed to be different for each run/task
sed -i "s|#/random/setSeeds 1 1|/random/setSeeds $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID|" $mainMacroName.mac

echo using seeds: $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID

## modify the commands in the detector macro
## the following paramenters MUST be set in the PARENT script (main.sh):
## detectorWidthUM , detectorThicknessUM , detectorDepthMM, beamEnergyMEV, rangeCutUM

sed -i "s|/geometrySetup/detectorDimension/setWidth 100 um|/geometrySetup/detectorDimension/setWidth $detectorWidthUM um|" $detectorMacroName.mac
sed -i "s|/geometrySetup/detectorDimension/setThickness 8 um|/geometrySetup/detectorDimension/setThickness $detectorThicknessUM um|" $detectorMacroName.mac

sed -i "s|/geometrySetup/detectorPosition/setDepth 10 mm|/geometrySetup/detectorPosition/setDepth $detectorDepthMM mm|" $detectorMacroName.mac

sed -i "s|/gps/ene/mono 150.0 MeV|/gps/ene/mono $beamEnergyMEV MeV|" $gpsMacroName.mac

sed -i "s|/cuts/custom/setCutsAroundSV 1 um|/cuts/custom/setCutsAroundSV $rangeCutUM um|" $physicsMacroName.mac

## run the program
##module load geant4 # not needed if loaded in main.sh
./$executableName $mainMacroName.mac

## OPTIONAL
## copy the output files to the parent folder
for output in *.$outputExtension
do
	newName=out_$runName\_$SLURM_ARRAY_TASK_ID\_$output
	cp $output ../$newName
done

## ... and delete the task directory
cd .. && rm -r $folderName

date
