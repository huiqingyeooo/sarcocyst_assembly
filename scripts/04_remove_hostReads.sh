 #!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=3-00:00:00
#SBATCH --mem=100G

####### Set environment variables ###############
MINIMAP2=/work/soghigian_lab/apps/minimap2-2.31_x64-linux/minimap2
REF_GENOME=/work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/ref_genome/GCA_965153185.1_Rangifer_t_t_557_genomic.fna.gz

cd /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly

####### script ##################################

${MINIMAP2} -t 8 -ax map-ont ${REF_GENOME} sarcocyst_q10.fastq.gz > mapped.sam 

echo "Job finised with exit code $? at: `date`"