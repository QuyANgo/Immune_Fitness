#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 2
#SBATCH --mem 2G
#SBATCH --array [1-601]%150

module load UHTS/Quality_control/fastqc/0.11.9
#module load UHTS/Analysis/MultiQC/1.8

here=/scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
data=$here/fastq_trimmed

multiqc=$here/MultiQC_trim
mkdir -p $multiqc

cd $here
#cd $data; ls | cut -d _ -f 1-3 | uniq > $here/Scripts/fastqTrimList.txt --> this should be generated before the job array is submitted
#sed '1,600d' $here/Scripts/fastqTrimList.txt $here/Scripts/fastqTrimList601-1201.txt
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p $here/Scripts/fastqTrimList601-1201.txt)

fastqc -t 2 --extract $data/${id}*P.fastq.gz --outdir=$multiqc

#cd $multiqc
#multiqc . -n multiqcTrimmed_report.html -ip # This should only be done after all individual fastqc jobs in the array are finished!!!!


#jobID 4194882