import numpy as np

#filename = '/home/cluster/ocatma/NS/Magnetic_Accretion_Disks/Disk_BL_ADAF/Deltanu_constant/R_in_eq_R_Alfven/4U_1608_52_4.22_kpc.dat'
#filename = '/home/cluster/ocatma/NS/Magnetic_Accretion_Disks/Disk_BL_ADAF/Delta_Nu_Variable_Fit/MRB_Scan/4U_1608_52_4.22_kpc.dat'

#filename = '/home/cluster/ocatma/NS/Magnetic_Accretion_Disks/Disk_BL_ADAF/Deltanu_constant/R_in_eq_R_Alfven/4U_1636_54_5.5_kpc.dat'
filename = '/home/cluster/ocatma/NS/Magnetic_Accretion_Disks/Disk_BL_ADAF/Delta_Nu_Variable_Fit/MRB_Scan/4U_1636_54_5.5_kpc.dat'

a1, a2, a3 = np.genfromtxt(filename, delimiter='', usecols=(7,8,9), skip_header=1, unpack=True)

print np.min(a1), np.min(a2), np.min(a3)
print np.max(a1), np.max(a2), np.max(a3)

