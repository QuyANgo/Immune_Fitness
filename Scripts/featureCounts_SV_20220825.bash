#!/bin/bash

#SBATCH --time 03-00:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 4
#SBATCH --mem 256G

module load UHTS/Analysis/subread/2.0.1

here=/scratch/beegfs/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2
ref=$here/References
bam=$here/bam
dirout=$here/featureCounts

expname=tx2gene
genemx=$expname.wB.OMf.featureCounts
out=$dirout/${expname}_107
sample=`ls $bam/*.bam`

mkdir -p $dirout
mkdir -p $out

featureCounts -T 12 -s 2 -p -B -O -M --fraction \
	-a $ref/Homo_sapiens.GRCh38.107.gtf \
	-G $ref/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -J \
	-t transcript -g gene_id \
	--extraAttributes gene_name \
	-o $out/$genemx \
	2> $out/$genemx.screen \
	$sample

	
# clean up featureCounts results, keep the gene length information
cut -f 1,6- $out/$genemx | sed 1d > $out/$genemx.1
sed 's/.bam//g' $out/$genemx.1
sed -i 's/\//_/g' $out/$genemx.1
sed -i 's/_scratch_beegfs_PRTNR_CHUV_ONCO_mgraciot_immune_fitness_qngo2_bam_//g' $out/$genemx.1
sed -i 's/.bam//g' 

## to discard gene length information and clean up sample names for downstream DESeq2 analysis:
cut -f 1,3- $out/$genemx.1 > $out/$genemx.2
#sed -i 's/.bam//g' $out/$genemx.2

#jobID 4192333 (out of memory with 32Gb & 12 cores), 4194729 (256Gb, 4 cores)

# Report job for 1201 bam files using 4 cores:
#CPU Utilized: 1-05:24:40
#CPU Efficiency: 71.42% of 1-17:10:48 core-walltime
#Job Wall-clock time: 10:17:42
#Memory Utilized: 43.23 GB
#Memory Efficiency: 16.89% of 256.00 GB
