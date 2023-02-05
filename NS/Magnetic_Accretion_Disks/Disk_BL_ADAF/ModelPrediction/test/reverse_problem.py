import numpy as np
import random
import itertools
import multiprocessing
from joblib import Parallel, delayed
import sys
import matplotlib.pyplot as plt

def run(Source, Mass_Star, Radius, Mdot, Lower_QPO, Magnetic_Field, Perturbation):

	A1=89461.43821652
	A2=10835.745564151
	w1=420.05450884622
	w2=93.836876948741
	xc1=487.24281618702
	xc2=715.91658256079
	y0=187.37317350182

	#Radius_Sch = 2.0 * Gravitational_Constant * Mass_Star / (Speed_of_Light**2.0)
	Radius_Alfven = np.power((Gravitational_Constant * Mass_Star),(-1.0/7.0)) * np.power((Mdot),(-2.0/7.0)) * np.power((Magnetic_Field),(4.0/7.0)) * np.power((Radius),(12.0/7.0))
	Omega_rin = np.sqrt(Gravitational_Constant * Mass_Star * np.power(Radius_Alfven,-3.0))
	Keplerian_Frequency = Omega_rin / (2.0 * np.pi)
	Deltanu = y0 + np.sqrt(2.0/np.pi) * A1 / w1 * np.exp(-2.0 * (Lower_QPO - xc1)**2.0 / w1**2.0 ) + np.sqrt( 2.0 / np.pi ) * A2 / w2 * np.exp(-2.0 * (Lower_QPO - xc2)**2.0 / w2**2.0)
	Pert = np.random.uniform(-Perturbation, Perturbation, len(Mdot))
	Deltanu += Pert
	Delta = (Deltanu - Keplerian_Frequency) / ((((Deltanu + Lower_QPO)**2.0) / (2.0*Deltanu)) - (2.0 * Deltanu) + (1.5 * Keplerian_Frequency))

	delta_check_max = all(xxx <= 0.3 for xxx in Delta)
	delta_check_min = all(xxx >= 0.01 for xxx in Delta)
	if delta_check_max == True and delta_check_min == True:	
	
		print '%-30s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e \n' %(Source, Mass_Star/Mass_Solar, Radius, Magnetic_Field, Perturbation, np.min(Deltanu), np.max(Deltanu), np.min(Delta), np.max(Delta))

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
Perturbation = float(sys.argv[6])
ncpu = int(sys.argv[7])
NuCorona = float(sys.argv[8])

Mass_list = np.arange(0.1, 3.01, 0.1) 
Radius_list = np.arange(7.0, 16.01, 0.1) * 1e5 

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

			Parallel(n_jobs=ncpu)(delayed(run)(Source, Mass_Star, Radius, Mdot, Lower_QPO, Magnetic_Field, Perturbation) for Magnetic_Field in Magnetic_Field_list) 


