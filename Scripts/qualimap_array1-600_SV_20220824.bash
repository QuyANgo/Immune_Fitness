#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 32G
#SBATCH --array [1-600]%300

module load UHTS/Quality_control/qualimap/2.2.1

here=/scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
ref=$here/References
bam=$here/bam
out=$here/qualimap

mkdir -p $out

#cd $bam; ls *.bam > $here/Scripts/bamList.txt # this is to be done BEFORE array job is submitted!
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p $here/Scripts/bamList.txt)

cd $bam
#for sample in $bam/$id.bam
#do
	echo ----------qualimap of $id
	qualimap rnaseq \
	-a proportional \
	-bam $id \
	-gtf $ref/Homo_sapiens.GRCh38.107.gtf \
	-outdir $out \
	-outfile ${id}_NonUniq.rnaqc.s.gtf107 \
	-outformat pdf \
	-p strand-specific-reverse \
	-s --java-mem-size=32G \
	java_options="-Djava.awt.headless=true"
#done

#jobID 4189167