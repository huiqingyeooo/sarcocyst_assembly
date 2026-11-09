#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00
#SBATCH --mem=50G

####### set environment variables ##################################
isONclust=/work/soghigian_lab/apps/isONclust3/target/release/isONclust3

####### script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

${isONclust} --fastq unmapped_q10.fastq  --mode ont --min-shared-minis 0.9 --outfolder ./reads_polishing

echo "Job finised with exit code $? at: `date`"
