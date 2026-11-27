#!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=24:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/sepp

module load gcc/10.2.0
PATH=/work/soghigian_lab/apps/bbmap:$PATH
PATH=/work/soghigian_lab/apps/ncbi-blast-2.12.0+/bin:$PATH
PATH=/work/soghigian_lab/apps/diamond:$PATH
PATH=/work/soghigian_lab/apps/seqtk:$PATH
PATH=/work/soghigian_lab/apps/minimap2-2.23_x64-linux:$PATH

BLOBTOOLS_FOLDER=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/unmapped/blobtools2
cd ${BLOBTOOLS_FOLDER}

###blobtools can be finnicky about file names and formats

#create soft links to reads (fastq.gz) and assembly (fasta)
#ln -s /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/basecalled_trimmed_q10.fastq.gz sarcocystis_reads.fastq.gz
#ln -s /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/unmapped/assembly.fasta sarcocystis_assembly_flye.fasta

#make variables from the links created
asm=sarcocystis_assembly_flye.fasta
r1=sarcocystis_reads.fastq.gz
name=sarcocystis_assembly_flye #make sure this matches with the assembly prefix in config_abs.yaml

#if you have just one fastq.gz you can just comment this out
#but make sure you make the corresponding change in the config_abs.yaml
#cat $r1 $r2 > reads_cat.fastq.gz

####do this interactively
#####get the number of scaffolds in the assembly and the scaffold bp length
#stats.sh in=assembly.fasta format=3 > bbmap.txt

####do this interactively
#####get the number of bases in the reads file (this just prints to console so pay attention, also kinda slow)
#zcat ${r1} | paste - - - - | cut -f2 | wc -c
#164489725

###your assembly needs to be gzipped. if it is already, you can just comment this out
###or pigz -p 40 $asm
#gzip $asm

# Copy BUSCO database to writable location
#mkdir -p ${BLOBTOOLS_FOLDER}/busco_db/lineages
#cp -r /work/soghigian_lab/databases/busco/lineages/eukaryota_odb10 ${BLOBTOOLS_FOLDER}/busco_db/lineages/

# Ignore user-site packages. python resolves the first generic top level lib which in my case was geneminer
export PYTHONNOUSERSITE=1

btk pipeline run --tool blobtoolkit --config /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/scripts/blobtools_config.yaml --threads 24 --workdir ${BLOBTOOLS_FOLDER}