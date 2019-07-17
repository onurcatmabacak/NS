#!/bin/bash -l
#
#SBATCH --job-name="onur"
#SBATCH --time=24:0:0 --mem=2G
#SBATCH --ntasks=1 --cpus-per-task=2
#SBATCH --output=%j.o
#SBATCH --error=%j.e

#======START=====
srun python deneme2.py
#=====END====
