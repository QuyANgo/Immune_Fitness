#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 12
#SBATCH --mem 32G
#SBATCH --array [1-91]%24

module load UHTS/Analysis/trimmomatic/0.36

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
data=$here/fastq_merged_remain
adapter=$here/References/adapters.fa
out=$here/fastq_trimmed

mkdir -p $out

#cd $data; ls | cut -d _ -f 1-3 | uniq > $here/Scripts/fastqRemainList2.txt --> this should be generated before the job array is submitted
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p $here/Scripts/fastqRemainList2.txt)

cd $out
for read1 in $data/${id}*R1.fastq.gz
do
	read2=${read1%%R1.fastq.gz}R2.fastq.gz
	sample=$(basename $read1 _R1.fastq.gz)
	echo $read1
	echo $read2
	echo ----------trim $sample
	#done	

	trimmomatic PE -threads 12 -trimlog logfile \
	$read1 $read2 \
	-baseout $sample.fastq.gz \
	ILLUMINACLIP:$adapters:1:30:10:5:true LEADING:5 TRAILING:5 SLIDINGWINDOW:4:20 AVGQUAL:20 MINLEN:35

done

#mv $data/* $here/fastq_merged

#jobID 
