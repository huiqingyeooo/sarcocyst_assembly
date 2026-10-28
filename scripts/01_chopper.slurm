#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00
#SBATCH --mem=50G

####### script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst

# quality filter
#source ~/software/init-conda-sl
#conda activate /work/soghigian_lab/apps/conda/envs/chopper_v0.11.0
#pigz -dc sarcocyst.fastq.gz | chopper -q 10 | pigz > sarcocyst_q10.fastq.gz

echo "Job finised with exit code $? at: `date`"
