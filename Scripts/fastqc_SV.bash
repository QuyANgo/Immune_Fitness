#!/bin/bash

#SBATCH --time 00-12:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 16G
#SBATCH --mail-type ALL
#SBATCH --mail-user quy-ai.ngo@chuv.ch

module load UHTS/Quality_control/fastqc/0.11.9
module load UHTS/Analysis/MultiQC/1.8

here=/data/PRTNR/CHUV/ONCO/svigano/immune_fitness/qngo2

mkdir $here/MultiQC

fastqc --extract $here/fastq/* --outdir=$here/MultiQC

multiqc $here/MultiQC .


 





