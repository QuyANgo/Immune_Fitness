#!/bin/bash

#SBATCH --time 00-08:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 32G

module load UHTS/Quality_control/fastqc/0.11.9
module load UHTS/Analysis/MultiQC/1.8

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2

mkdir -p $here/MultiQC_subset

spl=("1GBY_HD_ODN" "1GBY_HD_UNS" )

for k in ${spl[@]}
do
        echo -----fastqc of $k
        echo $here/fastq_trimmed/${k}*P.fastq.gz
        #done

        fastqc -t 2 --extract $here/fastq_trimmed/${k}*P.fastq.gz --outdir=$here/MultiQC_subset
done

cd $here/MultiQC_subset
multiqc .

# jobID 4178629