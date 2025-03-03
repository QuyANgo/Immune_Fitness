#!/bin/bash

#SBATCH --time 01-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 64G

module load UHTS/Analysis/MultiQC/1.8

cd /scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2/MultiQC_trim
multiqc . -n multiqcTrimmed_report.html -ip

#job ID 4196251, 4196311 (canceled due to 1h time limit), 4196807
