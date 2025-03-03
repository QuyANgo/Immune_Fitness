#!/bin/bash

#SBATCH --time 01-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 16G

module load UHTS/Quality_control/fastqc/0.11.9
module load UHTS/Analysis/MultiQC/1.8

here=/data/PRTNR/CHUV/ONCO/svigano/immune_fitness/qngo2

mkdir -p $here/MultiQC_subset

spl=("1GG4_End_treatment_3_28" "1GB8_3Months_cADO" "1GUD_HD_cADO" "1GQP_On_treatment_cADO" "1GEJ_HD_cADO" "1GS8_HD_cADO" "1G9W_HD_cADO" "1GGN_On_treatment_cADO" "1GQP_End_treatment_cADO")

for k in ${spl[@]}
do
	echo fastqc of $k
	echo $here/fastq/${k}*
	#done

	fastqc --extract $here/fastq/${k}* --outdir=$here/MultiQC_subset
done

cd $here/MultiQC_subset
multiqc .


# jobID 
