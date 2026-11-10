#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/busco

####### Script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/unmapped

# check available BUSCO datasets
# busco --list-datasets

busco -m genome -i assembly.fasta -o busco_output -l apicomplexa -c 8

echo "Job finised with exit code $? at: `date`"
