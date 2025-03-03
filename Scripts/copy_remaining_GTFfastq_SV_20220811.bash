#!/bin/bash

#SBATCH --time 00-1:00:00
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 16G

source=/archive/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2/fastq_GTF
dest=/data/PRTNR/CHUV/ONCO/mgraciot/immune_fitness/qngo2/fastq_GTF

input=$dest/../diff.txt
cd $source
while IFS= read -r line
do
  scp "$line" $dest
done < "$input"

