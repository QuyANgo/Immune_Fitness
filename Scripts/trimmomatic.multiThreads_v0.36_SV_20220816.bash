#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 24
#SBATCH --mem 32G

module load UHTS/Analysis/trimmomatic/0.36

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
data=$here/fastq_merged3
adapter=$here/References/adapters.fa
out=$here/fastq_trimmed

mkdir -p $out

cd $out
for read1 in $data/*R1.fastq.gz
do
	read2=${read1%%R1.fastq.gz}R2.fastq.gz
	sample=$(basename $read1 _R1.fastq.gz)
	echo $read1
	echo $read2
	echo ----------trim $sample
	#done	

	trimmomatic PE -threads 24 -trimlog logfile \
	$read1 $read2 \
	-baseout $sample.fastq.gz \
	ILLUMINACLIP:$adapters:1:30:10:5:true LEADING:5 TRAILING:5 SLIDINGWINDOW:4:20 AVGQUAL:20 MINLEN:35

done

#mv $data/* $here/fastq_merged

#jobID 4153534, 4153537