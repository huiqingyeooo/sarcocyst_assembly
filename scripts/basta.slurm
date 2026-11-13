#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=24:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/basta

PATH=/work/soghigian_lab/apps/ncbi-blast-2.12.0+/bin:$PATH

BASTA_INPUT=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/hifiasm
BASTA_OUTPUT=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/hifiasm/basta_output
SCRIPT=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/scripts

cd ${BASTA_INPUT}
mkdir -p ${BASTA_OUTPUT}

# convert gfa file to fasta file
#awk '/^S/{print ">"$2"\n"$3}' sarcocyst_q10_hifiasm.asm.bp.p_ctg.gfa > sarcocyst_q10_hifiasm.asm.bp.p_ctg.fasta

echo "starting run at: `date`"

######## Script #######################################
cd /scratch/${SLURM_JOB_ID}
echo check /scratch/${SLURM_JOB_ID}

# Copy taxonomy database into scratch for each sample, as program can sometimes throw errors when running parallel jobs
# https://github.com/timkahlke/BASTA/issues/24
cp -r /work/soghigian_lab/apps/BASTA/taxonomy /scratch/${SLURM_JOB_ID}/

cd ${BASTA_OUTPUT}

PATH=/work/soghigian_lab/apps/seqtk:$PATH
#seqtk seq -a ${BASTA_INPUT}/basecalled_q10.fastq.gz > ${BASTA_INPUT}/basecalled_q10.fasta
#seqtk seq -a ${BASTA_INPUT}/unmapped_q10.fastq > ${BASTA_INPUT}/unmapped_q10.fasta

# 1. Uses parallel to chunk fasta into blocks of 500K, and submits 5 (-j) of them each time, each using 3 (num_threads) threads on the cluster
echo "starting blast"
#cat ${BASTA_INPUT}/assembly.fasta | parallel -j 5 --block 500k --recstart '>' --pipe blastn -num_threads 3 -outfmt 6 -db /work/soghigian_lab/databases/gb_nt/nt_euk -query - > unmapped_flye.blast

cat ${BASTA_INPUT}/sarcocyst_q10_hifiasm.asm.bp.p_ctg.fasta | parallel -j 5 --block 500k --recstart '>' --pipe blastn -num_threads 3 -outfmt 6 -db /work/soghigian_lab/databases/gb_nt/nt_euk -query - > unmapped_hifiasm.blast

# 2. Assigns taxonomies to sequences or groups of sequences based on the Last Common Ancestor (LCA) of a number of best hits
# -m: minimum number of hits a sequence must have to be assigned an LCA (default 3)
# -p: percentage of hits that are used for LCA estimation (default 100)
# -l: minimum length for good blast alignment (default 100)
# -i: minimim identity of hit to be considered good (default 80)

echo "starting basta"
#basta sequence -m 1 -p 51 -l 10 -i 75 -e 0.001 unmapped_flye.blast unmapped_flye.basta gb -d /scratch/${SLURM_JOB_ID}/taxonomy
basta sequence -m 1 -p 51 -l 10 -i 75 -e 0.001 unmapped_hifiasm.blast unmapped_hifiasm.basta gb -d /scratch/${SLURM_JOB_ID}/taxonomy

# 3. Filter a given fasta based on basta annotations
#echo "extracting fasta for TEMPLATE"
/work/soghigian_lab/apps/BASTA/scripts/filter_basta_fasta.py ${BASTA_INPUT}/assembly.fasta unmapped_hifiasm.sarcocystidae.fasta sarcocystidae unmapped_hifiasm.basta

#rm -r /scratch/${SLURM_JOB_ID}/taxonomy

echo "Job finised with exit code $? at: `date`"