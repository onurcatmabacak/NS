#!/bin/bash
clear
squeue --nodelist=hydra1,hydra2
squeue -u ocatma
ls -hlt *.e *.o
#ls -hlt /home/hydra/ocatma/NS/freq_ratio_mrb_scan/*.{e,o}
#ls -hlt *.txt | head -5
#printf "\n"
#ls -hlt /home/hydra/ocatma/NS/freq_ratio_mrb_scan/output/*
