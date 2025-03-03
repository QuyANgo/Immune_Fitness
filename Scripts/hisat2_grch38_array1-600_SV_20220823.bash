#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 4
#SBATCH --mem 32G
#SBATCH --array [1-600]%75

module load UHTS/Aligner/hisat/2.2.1
module load UHTS/Analysis/samtools/1.8

here=/scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
ref=$here/References/grch38_tran/genome_tran
data=$here/fastq_trimmed
bam=$here/bam

mkdir -p $bam

cd $here
#cd $data; ls *P.fastq.gz | cut -d _ -f 1-3 | uniq > $here/Scripts/fastqTrimList.txt --> this should be generated before the job array is submitted
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p $here/Scripts/fastqTrimList.txt)

for read1 in $data/${id}_1P.fastq.gz
do
	read2=${read1%%1P.fastq.gz}2P.fastq.gz
	echo ----------process $id
	echo $read1
	echo $read2
	#done

	hisat2 -p 4 -t --dta --rna-strandness RF --fr --reorder \
	-x $ref -1 $read1 -2 $read2 \
	--novel-splicesite-outfile $bam/$id.novsplice \
	--summary-file $bam/$id.summary.txt \
	| samtools view -bSh - \
	| samtools sort -o $bam/$id.bam \
	-O bam -T $bam/$id.tmp -@ 4
	echo ******** $id is mapped and sorted
	
	samtools index $bam/$id.bam
	echo ________ $id is indexed and DONE

done

#jobID 4184495

# Job report for 600 fastq_trimmed pairs mapped with 4 cores
#Cores per node: 4
#CPU Utilized: 02:16:09
#CPU Efficiency: 91.91% of 02:28:08 core-walltime
#Job Wall-clock time: 00:37:02
#Memory Utilized: 9.11 GB
#Memory Efficiency: 28.48% of 32.00 GB

