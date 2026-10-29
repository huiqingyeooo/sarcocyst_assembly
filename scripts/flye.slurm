#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=7-00:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/flye

####### script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

# genome assembly
flye --threads 16 --nano-hq unmapped_q10.fastq --out-dir ./flye/

echo "Job finised with exit code $? at: `date`"