#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=4:00:00
#SBATCH --mem=50G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/nanoplot

####### script ##################################
# reference script from: https://github.com/henrimdias/emu-microbiome-HPC/blob/main/emu_pipeline/scripts/run_nanotools_pipeline.slurm

cd /work/soghigian_lab/huiqing.yeo/sarcocyst

# QC reads after filtering
NanoPlot --fastq sarcocyst.fastq.gz --threads 8 \
--outdir nanoplot \
--legacy hex dot

echo "Job finised with exit code $? at: `date`"