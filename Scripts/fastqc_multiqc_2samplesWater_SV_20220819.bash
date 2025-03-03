#!/bin/bash

#SBATCH --time 00-02:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 32G

module load UHTS/Quality_control/fastqc/0.11.9
module load UHTS/Analysis/MultiQC/1.8

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2

mkdir -p $here/MultiQC_water

fastqc -t 2 --extract $here/fastq_water/water* --outdir=$here/MultiQC_water

cd $here/MultiQC_water
multiqc . -n multiqcWater_report.html -ip

# jobID 4178732