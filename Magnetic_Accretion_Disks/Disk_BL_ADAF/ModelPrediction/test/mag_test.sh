#!/bin/bash
module load hydra
#export OMP_NUM_THREADS=32

Source=(4U_1608_52_3.6_kpc 4U_1608_52_4.22_kpc 4U_1608_52_5.0_kpc 4U_1636_54_5.5_kpc 4U_1636_54_7.0_kpc 4U_1728_34_4.5_kpc Aql_X_1_2.5_kpc_Mendez Aql_X_1_5.2_kpc_Mendez Aql_X_1_2.5_kpc_Barret Aql_X_1_5.2_kpc_Barret)
SourceName=(4U_1608_52.txt 4U_1608_52.txt 4U_1608_52.txt 4U_1636_54.txt 4U_1636_54.txt 4U_1728_34.txt Aql_X_1_Mendez.txt Aql_X_1_Mendez.txt Aql_X_1_Barret.txt Aql_X_1_Barret.txt)
Parsec=(3.6 4.22 5.0 5.5 7.0 4.5 2.5 5.2 2.5 5.2)
Nustar=(619.0 619.0 619.0 581.0 581.0 363.0 549.0 549.0 549.0 549.0)
Conversion_Factor=(4.49754 4.49754 4.49754 4.6 4.6 3.95 2.3 2.3 10.0 10.0)

DELTANU=(100.0 200.0 300.0)
MEMORY=64
NJOBS=2
LIST=(0 1 2 3 4)

for i in ${LIST[@]}
do
	for k in ${DELTANU[@]}
	do

		JOBSUB=`printf "jobsub_%s_deltanu_%.1f.sh" ${Source[$i]} $k`

		printf "#!/bin/bash -l \n" > $JOBSUB
		printf "#SBATCH --job-name=\"onur\" \n" >> $JOBSUB
		printf "#SBATCH --time=24:0:0 --mem=%sG \n" $MEMORY >> $JOBSUB
		printf "#SBATCH --ntasks=1 --cpus-per-task=$NJOBS \n" >> $JOBSUB
		printf "#SBATCH --output=%%j.o \n" >> $JOBSUB
		printf "#SBATCH --error=%%j.e \n" >> $JOBSUB
		printf "#======START===== \n" >> $JOBSUB
		printf "srun python mag_test.py ${Source[$i]} ${SourceName[$i]} ${Conversion_Factor[$i]} ${Nustar[$i]} ${Parsec[$i]} $k \n" >> $JOBSUB 
		printf "#=====END==== \n" >> $JOBSUB
		sbatch $JOBSUB 

	done
done
