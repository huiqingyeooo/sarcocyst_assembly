 #!/bin/bash
####### Reserve computing resources #############
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00
#SBATCH --mem=50G

####### Set environment variables ###############
MINIMAP2=/work/soghigian_lab/apps/minimap2-2.31_x64-linux/minimap2


####### script ##################################
