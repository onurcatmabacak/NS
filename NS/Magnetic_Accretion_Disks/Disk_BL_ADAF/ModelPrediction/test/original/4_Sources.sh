#!/bin/bash
module load hydra

#gfortran -ffree-line-length-512 -fopenmp -o 4_Sources 4_Sources.f95 && ./4_Sources
gfortran -ffree-line-length-512 -o 4_Sources 4_Sources.f95 && ./4_Sources

#JOBSUB=jobsub.sh
#rm $JOBSUB

#printf "#!/bin/bash -l \n" > $JOBSUB
#printf "#SBATCH --qos=medium" >> $JOBSUB
#printf "#SBATCH --job-name=\"onur\" \n" >> $JOBSUB
#printf "#SBATCH --time=48:0:0 --mem=32GB \n" >> $JOBSUB
#printf "#SBATCH --ntasks=1 --cpus-per-task=32 \n" >> $JOBSUB
#printf "#SBATCH --output=%%j.o \n" >> $JOBSUB
#printf "#SBATCH --error=%%j.e \n" >> $JOBSUB
#printf "#======START===== \n" >> $JOBSUB
#printf "srun ./4_Sources \n" >> $JOBSUB
#printf "#=====END==== \n" >> $JOBSUB

#sbatch $JOBSUB 

#for((i=1;i<301;i++)) 
#do 
#cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan && rm 4_Sources_$i
#done

#cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan
#gfortran 4_Sources_DataMan.f95 -o 4_Sources_DataMan
#./4_Sources_DataMan

#for((i=1;i<301;i++)) 
#do 
#cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan && rm Mass_$i.dat
#done
