#!/bin/bash -l 
#SBATCH --qos=medium#SBATCH --job-name="onur" 
#SBATCH --time=48:0:0 --mem=32GB 
#SBATCH --ntasks=1 --cpus-per-task=32 
#SBATCH --output=%j.o 
#SBATCH --error=%j.e 
#======START===== 
srun ./4_Sources 
#=====END==== 
