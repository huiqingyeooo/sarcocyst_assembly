#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=3-00:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
PATH=/work/soghigian_lab/apps/ncbi-blast-2.12.0+/bin:$PATH

REF=coi
REF=18S_28S_ITS_5.8S
REF=rpoB

####### script ##################################
cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/ref_database/barcodes

# make blast database
# makeblastdb -in 5809_Sarcocystidae_barcodes.fasta -dbtype nucl -out 5809_Sarcocystidae_${REF}.fasta

# convert gfa file to fasta file
#awk '/^S/{print ">"$2"\n"$3}' sarcocyst_q10_hifiasm.asm.bp.p_ctg.gfa > sarcocyst_q10_hifiasm.asm.bp.p_ctg.fasta

# hifiasm - 3962
# flye - 5006

# blast and identify gene regions mapping to sarcocyst contigs
blastn \
-db /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/ref_database/barcodes/5809_Sarcocystidae_${REF}.fasta \
-query /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/hifiasm/sarcocyst_q10_hifiasm.asm.bp.p_ctg.fasta \
-out /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/hifiasm/blast_${REF}_hifiasm.out -outfmt 6 -max_target_seqs 5

blastn \
-db /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/ref_database/barcodes/5809_Sarcocystidae_${REF}.fasta \
-query /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/assembly.fasta \
-out /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/blast_${REF}_flye.out -outfmt 6 -max_target_seqs 5

REF=coi
awk '$4 >= 400' blast_${REF}_hifiasm.out > blast_${REF}_hifiasm_filtered.txt
awk '$4 >= 400' blast_${REF}_flye.out > blast_${REF}_flye_filtered.txt

awk '$4 >= 1000' blast_${REF}_flye.out > blast_${REF}_flye_filtered1000.txt




echo "Job finised with exit code $? at: `date`"