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
cd /work/soghigian_lab/huiqing.yeo/sarcocyst

# genome assembly
${HIFIASM} -t 16 -o sarcocyst_hifiasm.asm sarcocyst_q15.fastq.gz

echo "Job finised with exit code $? at: `date`"