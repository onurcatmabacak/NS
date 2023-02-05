#!/bin/bash
CODE_PATH=/home/hydra/ocatma
cp -r $CODE_PATH/NS/* $CODE_PATH/HEAL
rm $CODE_PATH/HEAL/Magnetic_Accretion_Disks/Disk_BL_ADAF/Deltanu_constant/R_in_eq_R_Alfven/*.eps
rm $CODE_PATH/HEAL/Magnetic_Accretion_Disks/Disk_BL_ADAF/Deltanu_constant/R_in_eq_R_Alfven/*.dat
rm $CODE_PATH/HEAL/Magnetic_Accretion_Disks/Disk_BL_ADAF/Delta_Nu_Variable_Fit/MRB_Scan/*.dat
rm $CODE_PATH/HEAL/Magnetic_Accretion_Disks/Disk_BL_ADAF/Delta_Nu_Variable_Fit/MRB_Scan/*.eps
git add --all
git commit -m "`date +'%d.%m.%Y %H:%M:%S'`"
git push
