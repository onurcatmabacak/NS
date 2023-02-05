#!/bin/bash
clear
squeue -S e --nodelist=hydra1,hydra2
squeue -u ocatma 
ls -hlt *.e *.o | head -10

SIM_NAME=(B100_N512_M3e13_TL00001_baryon_toz2_HR_9915 B100_N512_M3e13_TL00003_baryon_toz2_HR_9915 B100_N512_M3e13_TL00004_baryon_toz2_HR_9915 B100_N512_TL00002_baryon_toz2 B100_N512_TL00007_baryon_toz2_HR B100_N512_TL00009_baryon_toz2_HR B100_N512_TL00011_baryon_toz2_HR B100_N512_TL00013_baryon_toz2_HR B100_N512_TL00018_baryon_toz2_HR B100_N512_TL00029_baryon_toz2_HR B100_N512_TL00031_baryon_toz2_HR B100_N512_TL00037_baryon_toz0_HR_9915 B100_N512_TL00113_baryon_toz0_HR_9915 B100_N512_TL00206_baryon_toz0_HR_9915 B100_N512_TL00217_baryon_toz2 B100_N512_TL00223_baryon_toz2_HR B100_N512_TL00228_baryon_toz2 B100_N512_TL00236_baryon_toz2 B400_N512_M1e14_TL00010_baryon_toz6_HR_9915 B400_N512_z6_TL00000_baryon_toz6_HR_9915 B400_N512_z6_TL00001_baryon_toz6_HR_9915 B400_N512_z6_TL00002_baryon_toz6_HR_9915 B400_N512_z6_TL00005_baryon_toz6_HR_9915 B400_N512_z6_TL00006_baryon_toz6_HR_9915 B400_N512_z6_TL00013_baryon_toz6_HR_9915 B400_N512_z6_TL00017_baryon_toz6_HR_9915 B400_N512_z6_TL00021_baryon_toz6_HR_9915 B762_N1024_z6_TL00000_baryon_toz6_HR B762_N1024_z6_TL00001_baryon_toz6_HR B762_N1024_z6_TL00002_baryon_toz6_HR B762_N1024_z6_TL00000_baryon_toz6_HR B762_N1024_z6_TL00001_baryon_toz6_HR B762_N1024_z6_TL00002_baryon_toz6_HR h113_HR_sn1dy300ro100ss h206_HR_sn1dy300ro100ss h29_HR_sn1dy300ro100ss h2_HR_sn1dy300ro100ss)
SIM_SUITE=(MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE MassiveFIRE2 MassiveFIRE2 MassiveFIRE2 MassiveFIRE2 MassiveFIRE2 MassiveFIRE2 MassiveFIRE2)

LIST=($1)
for i in ${LIST[@]}
do
	printf ${SIM_NAME[$i]}
	printf "\n" 

	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*converted* | head -5
	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*halos | head -5
	#printf "# in zred file: "
	#cat ${SIM_SUITE[$i]}/${SIM_NAME[$i]}/zred_pos_list | wc -l
	#printf "# binary files: "
	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*converted* | wc -l
	#printf "number of halos files: "
	#ls ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*halos | wc -l
	#printf "\n\n"
	#printf "number of mtree files: "
	#ls ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*mtree | wc -l
	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/halo/*/*mtree | head -5

	#printf "# in tracer file: "
	#cat ${SIM_SUITE[$i]}/${SIM_NAME[$i]}/halo_0.txt | wc -l
	#printf "extracted: \n"
	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/output/halo_0/*.hdf5 | head -5
	#ls -hlt ../data/${SIM_SUITE[$i]}/analysis/AHF/HR/${SIM_NAME[$i]}/output/halo_0/*.hdf5 | wc -l

	printf "# in tracer file: "
	cat ${SIM_SUITE[$i]}/${SIM_NAME[$i]}/halo_0.txt | wc -l
	#printf "BDD: \n"
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.1_kpc_cold.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.2_kpc_cold.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.5_kpc_cold.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_1.0_kpc_cold.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_rvir_cold.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.1_kpc_total.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.2_kpc_total.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_0.5_kpc_total.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_1.0_kpc_total.txt | wc -l
	#cat /bulk1/feldmann/Onur/bdd_data/${SIM_SUITE[$i]}/${SIM_NAME[$i]}_rvir_total.txt | wc -l

	ls -hlt /bulk1/feldmann/Onur/${SIM_SUITE[$i]}/${SIM_NAME[$i]}/*hdf5 | head -10

done
