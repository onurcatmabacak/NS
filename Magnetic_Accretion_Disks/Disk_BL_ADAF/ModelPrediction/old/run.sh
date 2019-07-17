#!/bin/bash
#export OMP_STACKSIZE=1G 
export OMP_NUM_THREADS=6
#gfortran -Wall -fbacktrace -fbounds-check -O3 -o $1 -fopenmp $1.f95
gfortran -o $1 $1.f95
time ./$1
