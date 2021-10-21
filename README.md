scripts to launch a set of simulations in a cluster via slurm

edit main.sh and launch it

main.sh uses a Python script to determine relative positions along the Bragg curve automatically
to do so, it requires a file named [nominal energy].csv for each energy
if this is not desired, replace that line in main.sh with explicit values in mm
