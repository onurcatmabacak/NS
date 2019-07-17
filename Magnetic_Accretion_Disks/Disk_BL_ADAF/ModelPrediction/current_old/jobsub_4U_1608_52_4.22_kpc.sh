#!/bin/bash -l 
#SBATCH --qos=medium#SBATCH --job-name="onur" 
#SBATCH --time=48:0:0 --mem=32G 
#SBATCH --ntasks=1 --cpus-per-task=32 
#SBATCH --output=deltanu_%j.o 
#SBATCH --error=deltanu_%j.e 
#======START===== 
srun python Deltanu.py 4U_1608_52_4.22_kpc 4U_1608_52.txt 4.49754 619.0 4.22 32 0 
#=====END==== 
