import numpy as np
import random
import itertools
import multiprocessing
from joblib import Parallel, delayed
import sys

def average_deltanu(Mdot, Lower_QPO, Deltanu):

	step = np.arange(np.min(Lower_QPO),np.max(Lower_QPO),Frequency_Range)
	Frequency = np.linspace(np.min(Lower_QPO), np.max(Lower_QPO), len(step)+1)

	Average_Deltanu = []
	Average_Lower_QPO = []

	for i in range(len(Frequency) - 1):

		Total_Mdot = np.array([a for a,b in zip(Mdot, Lower_QPO) if b >= Frequency[i] if b <= Frequency[i+1]])
		Total_Deltanu = np.array([a for a,b in zip(Deltanu, Lower_QPO) if b >= Frequency[i] if b <= Frequency[i+1]]) 
		Total_Lower_QPO = np.array([a for a,b in zip(Lower_QPO, Lower_QPO) if b >= Frequency[i] if b <= Frequency[i+1]]) 

		Average_Deltanu.append(np.sum(Total_Mdot * Total_Deltanu) / np.sum(Total_Mdot))
		Average_Lower_QPO.append(np.sum(Total_Mdot * Total_Lower_QPO) / np.sum(Total_Mdot))

	if (np.max(Average_Deltanu) <= Deltanu_max) & (np.min(Average_Deltanu) >= Deltanu_min):

		max_index = Average_Deltanu.index(np.max(Average_Deltanu))
		min_index = Average_Deltanu.index(np.min(Average_Deltanu))

		if Average_Lower_QPO[max_index] < Average_Lower_QPO[min_index]:	
			flag = 1
		else:
			flag = 0

	else:
		flag = 0
 
	return flag, Average_Deltanu, Average_Lower_QPO

def run(Source, Mass_Star, Radius, Mdot, Lower_QPO, List, Perturbation):

	Magnetic_Field = List[0]
	X = List[1]
	Y = List[2]
	Z = List[3]

	#Radius_Sch = 2.0 * Gravitational_Constant * Mass_Star / (Speed_of_Light**2.0)
	Radius_Alfven = np.power((Gravitational_Constant * Mass_Star),(-1.0/7.0)) * np.power((Mdot),(-2.0/7.0)) * np.power((Magnetic_Field),(4.0/7.0)) * np.power((Radius),(12.0/7.0))
	Omega_rin = np.sqrt(Gravitational_Constant * Mass_Star * np.power(Radius_Alfven,-3.0))
	Keplerian_Frequency = Omega_rin / (2.0 * np.pi)
	Pert = np.array([random.uniform(-Perturbation,Perturbation) for xxx in range(len(Mdot))])
	#f_1 = X * (3.0 * Kappa_es * Mdot) / (8.0 * np.pi * Speed_of_Light * Radius_Alfven)
	#f_2 = Y * (3.0 * Kappa_es * Mdot) / (8.0 * np.pi * Speed_of_Light * Radius_Alfven) * ((Radius_Alfven / (3.0 * Radius_Sch))**(-1./2.))
	#f_3 = Z * 1e5 / Radius_Alfven
	#Delta = (f_1 + f_2 + f_3) * (1.0 + Pert)
	Delta = X * ((Mdot * 1e-18)**(9.0/7.0)) + Y * ((Mdot * 1e-18)**(10.0/7.0)) + Z * ((Mdot * 1e-18)**(2.0/7.0)) 
	Delta *= (1.0 + Pert)

	delta_check_max = all(xxx <= 0.3 for xxx in Delta)
	delta_check_min = all(xxx >= 0.01 for xxx in Delta)

	if delta_check_max == True and delta_check_min == True:	

	 	#kappa, kappa-omega frequency band
		if frequency_band == 0:
			A = 3.0 - (2.0 / Delta)
			B = (-A * Keplerian_Frequency) - (2.0 * Lower_QPO)
			C = -Lower_QPO**2.0
			root = ((B/(2.0*A))**2.0) - (C/A)

		# kappa, kappa + omega frequency band
		if frequency_band == 1:
			A = (2.0 / Delta) - 4.0
			B = Keplerian_Frequency * (A - 1.0) / (2.0 * A)
			C = - (Lower_QPO**2.0) / A
			root = (B**2.0) + C

		root_check = all(xxx >= 0.0 for xxx in root)
		if root_check == True:
		
			Deltanu_1 = (-B / (2.0*A)) + np.sqrt(root)
			Deltanu_2 = (-B / (2.0*A)) - np.sqrt(root)

			Flag_1 = all(xxx >= 0.0 for xxx in Deltanu_1)
			Flag_2 = all(xxx >= 0.0 for xxx in Deltanu_2)

			if Flag_1 == True:
				flag, Average_Deltanu_1, Average_Lower_QPO_1 = average_deltanu(Mdot, Lower_QPO, Deltanu_1)
				if flag == 1:
					print '%-30s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e \n' %(Source, Mass_Star/Mass_Solar, Radius, Magnetic_Field, X, Y, Z, Perturbation, np.min(Average_Deltanu_1), np.max(Average_Deltanu_1), np.min(Average_Lower_QPO_1), np.max(Average_Lower_QPO_1), np.min(Delta), np.max(Delta))

			if Flag_2 == True:
				flag, Average_Deltanu_2, Average_Lower_QPO_2 = average_deltanu(Mdot, Lower_QPO, Deltanu_2)
				if flag == 1:
					print '%-30s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e \n' %(Source, Mass_Star/Mass_Solar, Radius, Magnetic_Field, X, Y, Z, Perturbation, np.min(Average_Deltanu_2), np.max(Average_Deltanu_2), np.min(Average_Lower_QPO_2), np.max(Average_Lower_QPO_2), np.min(Delta), np.max(Delta))

#####################
##### MAIN BODY #####
#####################
global Frequency_Range
global Deltanu_max
global Deltanu_min
global Kiloparsec 
global Gravitational_Constant 
global Mass_Solar 
global Kappa_es 
global Speed_of_Light 
global Mdot_Eddington 
global Source
global frequency_band
global write_file

Source = str(sys.argv[1])
SourceName = str(sys.argv[2])
Conversion_Factor = float(sys.argv[3]) * 1e-12
Nustar = float(sys.argv[4])
Parsec = float(sys.argv[5])
Num_step = int(sys.argv[6])
Perturbation = float(sys.argv[7])
ncpu = int(sys.argv[8])
NuCorona = float(sys.argv[9])
frequency_band = int(sys.argv[10])

write_file = Source + '_' + str(frequency_band) + '.txt'

Mass_list = [1.4] #np.arange(1.0, 1.01, 0.1) 
Radius_list = [1e6] #np.arange(10.0, 10.01, 0.1) * 1e5 
X_list = np.logspace(-5, 2, num=Num_step+1, endpoint=True)
Y_list = np.linspace(-0.1, -200.0, num=Num_step+1, endpoint=True)
Z_list = np.linspace(-0.01, 1.0, num=Num_step+1, endpoint=True)

Frequency_Range = 50.0
Deltanu_max = 400.0
Deltanu_min = NuCorona

Kiloparsec = 3.08567758e+21
Gravitational_Constant = 6.67e-08
Mass_Solar = 2.0e+33
Kappa_es = 0.4
Speed_of_Light = 3.0e+10
Mdot_Eddington = 1.0e+18

Count_Rate, Lower_QPO = np.genfromtxt(SourceName, delimiter='', usecols=(0,1), skip_header=0, unpack=True)
Flux = Count_Rate * Conversion_Factor

for Mass in Mass_list:
	
	Radius_lower = (6.0*Mass+4.1)/1.7*1.0e+05
	Hadronic_Constant = 1.08
	Radius_upper = 1e6 * np.power(Mass,(1.0/3.0)) * np.power((Hadronic_Constant*1000.0/Nustar),(2.0/3.0))
	Radius_filter = np.array([aaa for aaa in Radius_list if aaa < Radius_upper if aaa > Radius_lower])

	if len(Radius_filter) > 0:
		for Radius in Radius_filter: 

			Distance = Parsec * Kiloparsec
			Mass_Star = Mass * Mass_Solar
			Luminosity = 4.0 * np.pi * np.square(Distance) * Flux
			Mdot = (Luminosity * Radius) / (Gravitational_Constant * Mass_Star)

			Mdot_min = np.min(Mdot)
			Mdot_max = np.max(Mdot)
			# Alfven radius is bigger than neutron star's radius
			Magnetic_Field_min_Alfven = np.power((Gravitational_Constant * Mass_Star),(1.0/4.0)) * np.power((Mdot_max),(1.0/2.0)) * np.power((Radius),(-5.0/4.0))
			# Alfven radius is bigger than marginally stable orbit
			Magnetic_Field_min_ISCO = np.power((Gravitational_Constant * Mass_Star),(2.0)) * np.power((Mdot_max),(1.0/2.0)) * np.power((Radius),(-3.0)) * np.power((np.square(Speed_of_Light)/6.0),(-7.0/4.0))

			if Magnetic_Field_min_Alfven > Magnetic_Field_min_ISCO:
				Magnetic_Field_min = Magnetic_Field_min_Alfven
			elif Magnetic_Field_min_Alfven < Magnetic_Field_min_ISCO:
				Magnetic_Field_min = Magnetic_Field_min_ISCO
		 
			#Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min)**(1.0/2.0))*&
			#((Radius)**(-3.0))*((2.0*np.pi*Nustar)**(-7.0/6.0))

			# If corotation radius is determined with D-BL-ADAF corotation radius instead of star's corotation radius

			Magnetic_Field_max = np.power((Gravitational_Constant * Mass_Star),(5.0/6.0)) * np.power((Mdot_min),(1.0/2.0)) * np.power((Radius),(-3.0)) * np.power((2.0*np.pi*NuCorona),(-7.0/6.0))

			Magnetic_Field_list = np.logspace(np.log10(Magnetic_Field_min), np.log10(Magnetic_Field_max), num=10, endpoint=True)

			paramlist = list(itertools.product(Magnetic_Field_list, X_list, Y_list, Z_list))
			Parallel(n_jobs=ncpu)(delayed(run)(Source, Mass_Star, Radius, Mdot, Lower_QPO, List, Perturbation) for List in paramlist) 
