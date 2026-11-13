#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
VERKKO=/work/soghigian_lab/apps/verkko/verkko-v1.2/bin/verkko
OUTPUT_DIR=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/verkko

###### Script ###################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

${VERKKO} -d ${OUTPUT_DIR} --nano basecalled_trimmed_q10.fastq.gz --threads 8

echo "Job finised with exit code $? at: `date`"