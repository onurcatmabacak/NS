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

	if (np.max(Average_Deltanu) <= Deltanu_Cycle) & (np.min(Average_Deltanu) >= Nucorona):

		max_index = Average_Deltanu.index(np.max(Average_Deltanu))
		min_index = Average_Deltanu.index(np.min(Average_Deltanu))

		#if Average_Lower_QPO[max_index] < Average_Lower_QPO[min_index]:	
		return Average_Deltanu, Average_Lower_QPO 
		#else:
		#	return [-1], [-1]

	else:
		return [-1], [-1]
 
def run(Source, Mass_Star, Radius, Mdot, Lower_QPO, List):

	Magnetic_Field = List[0]
	Deltanu_Cycle = List[1]
	Nucorona = List[2]
	AMEC = List[3]

	Radius_ISCO = 6.0 * Gravitational_Constant * Mass_Star / (Speed_of_Light**2.0)
	Radius_Alfven = np.power((Gravitational_Constant * Mass_Star),(-1.0/7.0)) * np.power((Mdot),(-2.0/7.0)) * np.power((Magnetic_Field),(4.0/7.0)) * np.power((Radius),(12.0/7.0))
	r = Radius_ISCO / Radius_Alfven
	Omega_Kepler_rin = np.sqrt(Gravitational_Constant * Mass_Star * np.power(Radius_Alfven,-3.0))
	Keplerian_Frequency = Omega_Kepler_rin / (2.0 * np.pi)
	H_ss = ( 3.0 * Kappa_es * Mdot ) / ( 8.0 * np.pi * Speed_of_Light ) * ( 1.0 - (AMEC *  (r ** (-0.5 ) ) ) )
	Epsilon = H_ss / Radius_Alfven

	Omega_rin = 2.0 * np.pi * Deltanu_Cycle
	Kappa_epi = 2.0 * np.pi * (Deltanu_Cycle + Lower_QPO)
	Constant = ( (Kappa_epi ** 2.0) / ( 2.0 * Omega_rin ) ) - ( 2.0 * Omega_rin ) + ( 1.5 * Omega_Kepler_rin )
	dummy = Epsilon * Constant
	constant_check = all(xxx > 0.0 for xxx in dummy)

	if  constant_check == True:	

		DBL = 2.0 * ( Omega_Kepler_rin - Omega_rin ) / ( Epsilon * Constant )
		D_BL = np.max(DBL)
		
		#print 'DBL \n', D_BL, '\n#########################\n'
		H_ss_check = all(xxx > 0.0 for xxx in H_ss)

		if D_BL <= 100.0 and D_BL < 0.0 and H_ss_check == True:

			Delta = Epsilon * D_BL / 2.0 
			print "Delta\n", np.min(Delta), np.max(Delta)
			delta_check_max = all(xxx <= 0.3 for xxx in Delta)
			delta_check_min = all(xxx > 0.01 for xxx in Delta)

			if delta_check_max == True and delta_check_min == True:
			 
				# kappa, kappa-omega frequency band
				if frequency_band == 0:
					A = 3.0 - (2.0 / Delta)
					B = (-A * Keplerian_Frequency) - (2.0 * Lower_QPO)
					C = -(Lower_QPO**2.0)

				# kappa, kappa + omega frequency band
				if frequency_band == 1:
					A = 4.0 - (2.0 / Delta)
					B = Keplerian_Frequency * (1.0 - A)
					C = - (Lower_QPO**2.0)

				root = (B**2.0) - (4.0 * A * C)
				print "root", np.min(root), np.max(root)
				root_check = all(xxx >= 0.0 for xxx in root)

				if root_check == True:

					Deltanu_1 = (-B + np.sqrt(root)) / (2.0 * A)
					Deltanu_2 = (-B - np.sqrt(root)) / (2.0 * A)
					print Deltanu_1, Deltanu_2

					Flag_1 = all(xxx >= Nucorona for xxx in Deltanu_1)
					Flag_2 = all(xxx <= Deltanu_Cycle for xxx in Deltanu_1)
					Flag_3 = all(xxx >= Nucorona for xxx in Deltanu_2) 
					Flag_4 = all(xxx <= Deltanu_Cycle for xxx in Deltanu_2)

					if Flag_1 == True and Flag_2 == True :

						#Omega_rin_1 = 2.0 * np.pi * Deltanu_1
						#Omega_Fastness_1 = Omega_rin_1 / Omega_Kepler_rin
						#Gamma_Phi_1 = (1.0 - Omega_Fastness_1) / (D_BL / 2.0)

						Average_Deltanu_1, Average_Lower_QPO_1 = average_deltanu(Mdot, Lower_QPO, Deltanu_1)
						if Average_Deltanu_1[0] != -1:

							write_data = open(write_file, 'a+')	
							write_data.write('%-30s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e \n' %(Source, Mass_Star/Mass_Solar, Radius, Magnetic_Field, Deltanu_Cycle, Nucorona, AMEC, np.min(Average_Deltanu_1), np.max(Average_Deltanu_1), np.min(Average_Lower_QPO_1), np.max(Average_Lower_QPO_1), np.min(Delta), np.max(Delta)))
							write_data.close()

					if Flag_3 == True and Flag_4 == True:

						#Omega_rin_2 = 2.0 * np.pi * Deltanu_2
						#Omega_Fastness_2 = Omega_rin_2 / Omega_Kepler_rin
						#Gamma_Phi_2 = (1.0 - Omega_Fastness_2) / (D_BL / 2.0)

						Average_Deltanu_2, Average_Lower_QPO_2 = average_deltanu(Mdot, Lower_QPO, Deltanu_2)
						if Average_Deltanu_2[0] != -1:

							write_data = open(write_file, 'a+')	
							write_data.write('%-30s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e \n' %(Source, Mass_Star/Mass_Solar, Radius, Magnetic_Field, Deltanu_Cycle, Nucorona, AMEC, np.min(Average_Deltanu_2), np.max(Average_Deltanu_2), np.min(Average_Lower_QPO_2), np.max(Average_Lower_QPO_2), np.min(Delta), np.max(Delta)))
							write_data.close()

#####################
##### MAIN BODY #####
#####################
global Frequency_Range
global Deltanu_Cycle
global Nucorona
global AMEC
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
ncpu = int(sys.argv[6])
frequency_band = int(sys.argv[7])

write_file = Source + '_' + str(frequency_band) + '.txt'

Mass_list = np.arange(0.1, 3.0, 0.1) 
Radius_list = np.arange(7.0, 16.01, 0.1) * 1e5 
Deltanu_Cycle_list = np.arange(300.0, 501.0, 10.0)
Nucorona_list = np.arange(100.0, 301.0, 10.0)
AMEC_list = np.arange(0.5, 1.01, 0.05)

Frequency_Range = 30.0
Kiloparsec = 3.08567758e+21
Gravitational_Constant = 6.67e-08
Mass_Solar = 2.0e+33
Kappa_es = 0.4
Speed_of_Light = 3.0e+10
Mdot_Eddington = 1.0e+18
Nu_corotation = 100.0

Count_Rate, Lower_QPO = np.genfromtxt(SourceName, delimiter='', usecols=(0,1), unpack=True)
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

			Magnetic_Field_max = np.power((Gravitational_Constant * Mass_Star),(5.0/6.0)) * np.power((Mdot_min),(1.0/2.0)) * np.power((Radius),(-3.0)) * np.power((2.0*np.pi*Nu_corotation),(-7.0/6.0))

			Magnetic_Field_list = np.logspace(np.log10(Magnetic_Field_min), np.log10(Magnetic_Field_max), num=10, endpoint=True)
			paramlist = list(itertools.product(Magnetic_Field_list, Deltanu_Cycle_list, Nucorona_list, AMEC_list))
			Parallel(n_jobs=ncpu)(delayed(run)(Source, Mass_Star, Radius, Mdot, Lower_QPO, List) for List in paramlist) 
