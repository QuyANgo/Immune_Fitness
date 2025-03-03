#!/bin/bash

#SBATCH --job-name SV_cp   # Job name
#SBATCH --mail-type ALL         # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user quy-ai.ngo@chuv.ch # Where to send mail	
#SBATCH --nodes 1                   # Use one node
#SBATCH --ntasks 1                  # Run a single task
#SBATCH --mem-per-cpu 2G           # Memory per processor
#SBATCH --time 04:10:00             # Time limit hrs:min:sec

pwd; hostname; date

source=/scratch/beegfs/PRTNR/CHUV/ONCO/svigano/immune_fitness
dest=/archive/PRTNR/CHUV/ONCO/svigano/immune_fitness/fastq

for i in $source/*A00485*
do
	echo copy fastq in $i to $dest
	#done
	cp -r $i $dest
	echo done copy for $i
	date
done
