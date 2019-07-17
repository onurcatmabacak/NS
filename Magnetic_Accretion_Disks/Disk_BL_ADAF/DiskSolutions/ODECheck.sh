#!/bin/bash
for i in {1..300}
do
echo "cd /home/onur/Dropbox/DiskSolutions/ && cp ODECheck.py ODECheck_$i.py && echo $i | ./ODECheck_$i.py"
done > ODECheck_Command.s

cat 4_Sources_Sample.sh | parallel -j 32 --progress

for((i=1;i<301;i++))
do
cd $HOME/Desktop/Onur/Deltanu_constant/R_in_eq_R_Alfven && rm 4_Sources_$i
done

cd $HOME/Desktop/Onur/Deltanu_constant/R_in_eq_R_Alfven
gfortran 4_Sources_DataMan.f95 -o 4_Sources_DataMan
./4_Sources_DataMan

for((i=1;i<301;i++))
do
cd $HOME/Desktop/Onur/Deltanu_constant/R_in_eq_R_Alfven && rm Mass_$i.dat
done
