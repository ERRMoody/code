#!/bin/sh
#SBATCH --job-name=baliarrayluca
#SBATCH --partition=hmem
#SBATCH --output=arrayJob_%A_%a.out
#SBATCH --error=arrayJob_%A_%a.err
#SBATCH --array=0-51
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=14-00:00:0

module load apps/bali/3.4.1  


echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

bali -s Genfam${SLURM_ARRAY_TASK_ID}hmmalignment.faa



