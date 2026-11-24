#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=24:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/medaka_2.2.2

####### Script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/unmapped
#cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/hifiasm

medaka_consensus -t 12 \
  -i /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/basecalled_trimmed_q10.fastq.gz \
  -d assembly.fasta \
  -o medaka_consensusnoR_out \
  -m r1041_e82_400bps_sup_v5.2.0

#medaka_consensus -t 12 \
#  -i /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/basecalled_trimmed_q10.fastq.gz \
#  -d sarcocyst_q10_hifiasm.asm.bp.p_ctg.fasta \
#  -o medaka_consensusnoR_out \
#  -m r1041_e82_400bps_sup_v5.2.0

echo "Job finised with exit code $? at: `date`"
