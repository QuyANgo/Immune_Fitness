#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 24
#SBATCH --mem 64G

module load UHTS/Analysis/trimmomatic/0.36
module load UHTS/Quality_control/fastqc/0.11.9
module load UHTS/Analysis/MultiQC/1.8

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
data=$here/fastq_merged
adapter=$here/References/adapters.fa
out=$here/fastq_trimmed

# 1) trim
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

	trimmomatic PE -trimlog logfile \
	$read1 $read2 \
	-baseout $sample.fastq.gz \
	ILLUMINACLIP:$adapters:1:30:10:5:true LEADING:5 TRAILING:5 SLIDINGWINDOW:4:20 AVGQUAL:20 MINLEN:35

done

# 2) fastqc & multiqc
multiqc=$here/MultiQC_trim
mkdir -p $multiqc

fastqc --extract $out/*P.fastq.gz --outdir=$multiqc

cd $multiqc
multiqc . -n multiqc_trim_report.html -ip


#jobID 4151451, 4152097