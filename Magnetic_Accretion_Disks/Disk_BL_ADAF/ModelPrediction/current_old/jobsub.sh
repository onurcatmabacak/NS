#!/bin/bash -l
#
#SBATCH --job-name="onur"
#SBATCH --time=24:0:0 --mem=2G
#SBATCH --ntasks=1 --cpus-per-task=32
#SBATCH --output=%j.o
#SBATCH --error=%j.e
rm result.txt
#====START===
srun python Deltanu_Final.py >> result.txt
#=====END====

