#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 32G
#SBATCH --array [1-601]%10

module load UHTS/Quality_control/qualimap/2.2.1

here=/scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
ref=$here/References
bam=$here/bam
out=$here/qualimap

mkdir -p $out

#cd $bam; ls *.bam > $here/Scripts/bamList.txt # this is to be done BEFORE array job is submitted!
#sed '1,600d' $here/Scripts/bamList.txt > $here/Scripts/bamList601-1201.txt # do this BEFORE running array601-1201 job
id=$(sed -n ${SLURM_ARRAY_TASK_ID}p $here/Scripts/bamList601-1201.txt)

#System.setProperty("java.awt.headless", "true") # to disable display requirement for generating pdf report

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

#jobID 4192613 (error about X11), 4195720