salloc --mem=80G -c 1 -N 1 -n 8 -t 05:00:00
source ~/software/init-conda-sl
conda activate /work/soghigian_lab/apps/conda/envs/compleasm

compleasm run -a assembly.fasta -o compleasm_output -l apicomplexa -t 8  -L /work/soghigian_lab/huiqing.yeo/sarcocyst_assembly/flye/unmapped/busco_downloads/lineages/apicomplexa_odb12