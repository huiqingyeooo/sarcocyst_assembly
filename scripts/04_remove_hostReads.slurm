#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=3-00:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
MINIMAP2=/work/soghigian_lab/apps/minimap2-2.31_x64-linux/minimap2
SAMTOOLS=/work/soghigian_lab/apps/samtools-1.23/samtools
REF_GENOME=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/ref_genome/GCA_965153185.1_Rangifer_t_t_557_genomic.fna.gz

cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

####### script ##################################
# Map reads to Rangifer tarandus reference genome
# Find and extract unmapped reads
${MINIMAP2} -t 8 -ax map-ont ${REF_GENOME} basecalled_q10.fastq.gz | ${SAMTOOLS} view -b -f 4 | ${SAMTOOLS} fastq > unmapped.fastq

# convert BAM to FASTQ
${SAMTOOLS} fastq unmapped.bam > unmapped.fastq

echo "Job finised with exit code $? at: `date`"
