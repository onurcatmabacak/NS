#!/bin/bash
#export PYTHONPATH=$PYTHONPATH:/home/hydra/ocatma/pfh_python_rf
srun --pty --ntasks=1 --cpus-per-task=32 --time=24:0:0 --mem=2GB python $1
#time python2.7 $1
#python2.7 -m cProfile -s time $1 > $2
#vim $2 
