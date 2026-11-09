#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00
#SBATCH --mem=50G

####### set environment variables ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst

# quality filter
#source ~/software/init-conda-sl
#conda activate /work/soghigian_lab/apps/conda/envs/chopper_v0.11.0

#pigz -dc basecalled.fastq.gz | chopper -q 10 | pigz > basecalled_q10.fastq.gz

#pigz -dc basecalled_trimmed.fastq.gz | chopper -q 10 | pigz > basecalled_trimmed_q10.fastq.gz

chopper -q 10 -i basecalled_trimmed.fastq | pigz > basecalled_trimmed_q10.fastq.gz

echo "Job finised with exit code $? at: `date`"
