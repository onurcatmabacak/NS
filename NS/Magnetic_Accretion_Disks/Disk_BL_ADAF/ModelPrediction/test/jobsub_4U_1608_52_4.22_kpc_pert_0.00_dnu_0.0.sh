#!/bin/bash -l 
#SBATCH --job-name="onur" 
#SBATCH --time=24:0:0 --mem=4G 
#SBATCH --ntasks=1 --cpus-per-task=32 
#SBATCH --output=deltanu_0.0_0.0_%j.o 
#SBATCH --error=deltanu_0.0_0.0_%j.e 
#======START===== 
srun python reverse_problem.py 4U_1608_52_4.22_kpc 4U_1608_52.txt 4.49754 619.0 4.22 100.0 32 200.0 
#=====END==== 
