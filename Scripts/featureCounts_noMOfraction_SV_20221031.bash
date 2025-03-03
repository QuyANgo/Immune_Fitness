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
genemx=$expname.wB.noMO.featureCounts
out=$dirout/${expname}_107
sample=`ls $bam/*.bam`

mkdir -p $dirout
mkdir -p $out

featureCounts -T 4 -s 2 -p -B \
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
sed -i 's/_scratch_beegfs_PRTNR_CHUV_ONCO_mgraciot_immune_fitness_qngo2_//g' $out/$genemx.1

## to discard gene length information and clean up sample names for downstream DESeq2 analysis:
cut -f 1,3- $out/$genemx.1 > $out/$genemx.2

# then open $genemx.2 and clean up the sample names by Ctr-H

#jobID 4192333 (out of memory with 32Gb & 12 cores) 

