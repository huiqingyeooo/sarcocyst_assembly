#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=24:00:00
#SBATCH --mem=16G
#SBATCH --gres=gpu:1
####################################
# Check the GPUs with the nvidia-smi command.
nvidia-smi

### File paths
POD5=/work/soghigian_lab/data/20251203_sarcocyst_1x/dsu-25-344/20251203_1123_X1_FBD88094_226fd0d2/pod5_skip
OUTPUT=/work/soghigian_lab/huiqing.yeo/sarcocyst
SAMTOOLS=/work/soghigian_lab/apps/samtools-1.23/samtools

### Load required programs
DORADO=/work/soghigian_lab/apps/dorado/dorado-1.0.0-linux-x64/bin/dorado

echo "`date` Starting basecalling"
${DORADO} basecaller sup ${POD5} --verbose > calls.bam
#dna_r10.4.1_e8.2_400bps_sup@v5.2.0

# to resume dorado basecalling, add --resume-from flag
# IMPORTANT: make sure output file name is named differently
# ${DORADO} basecaller sup ${POD5} --verbose --resume-from calls.bam > calls2.bam
# note: could try --emit-fastq and --min-qscore 10 next time

echo "`date` Converting BAM to FASTQ"
${SAMTOOLS} fastq -@ 16 calls2.bam | gzip > sarcocyst.fastq.gz

echo "`date` End of script"