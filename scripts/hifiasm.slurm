#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=7-00:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
HIFIASM=/work/soghigian_lab/apps/hifiasm-0.16/hifiasm

####### script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

# genome assembly
${HIFIASM} -t 16 -o ./hifiasm/sarcocyst_q10_hifiasm.asm unmapped_q10.fastq

echo "Job finised with exit code $? at: `date`"