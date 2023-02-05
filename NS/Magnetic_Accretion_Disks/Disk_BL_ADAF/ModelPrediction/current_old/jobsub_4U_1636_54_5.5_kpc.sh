#!/bin/bash -l 
#SBATCH --qos=medium#SBATCH --job-name="onur" 
#SBATCH --time=48:0:0 --mem=32G 
#SBATCH --ntasks=1 --cpus-per-task=32 
#SBATCH --output=deltanu_%j.o 
#SBATCH --error=deltanu_%j.e 
#======START===== 
srun python Deltanu.py 4U_1636_54_5.5_kpc 4U_1636_54.txt 4.6 581.0 5.5 32 0 
#=====END==== 
