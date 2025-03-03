#!/bin/bash

#SBATCH --time 00-12:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 16G

here=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
data=$here/fastq_1st_analysis
out=$here/fastq_merged

mkdir -p $out

cd $data
ls *R1* | cut -d _ -f 1-3 | sort | uniq | \
	while read id
	do
	name=$(basename $id)
	echo $name
	echo $name*R1*.fastq.gz
	#done
	cat $name*R1*.fastq.gz > $out/${name}_R1.fastq.gz
	cat $name*R2*.fastq.gz > $out/${name}_R2.fastq.gz
	echo -----merge for $name is finished
	done

#jobID 4149532
