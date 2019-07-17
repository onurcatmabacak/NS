import numpy as np
import random
import itertools
import sys

#####################
##### MAIN BODY #####
#####################
Source = str(sys.argv[1])
SourceName = str(sys.argv[2])
Conversion_Factor = float(sys.argv[3]) * 1e-12
Nustar = float(sys.argv[4])
Parsec = float(sys.argv[5])
NuCorona = float(sys.argv[6])

Mass_list = np.arange(0.1, 3.01, 0.1) 
Radius_list = np.arange(7.0, 16.01, 0.1) * 1e5 

Kiloparsec = 3.08567758e+21
Gravitational_Constant = 6.67e-08
Mass_Solar = 2.0e+33
Kappa_es = 0.4
Speed_of_Light = 3.0e+10
Mdot_Eddington = 1.0e+18

Count_Rate, Lower_QPO = np.genfromtxt(SourceName, delimiter='', usecols=(0,1), unpack=True)
Flux = np.array(Count_Rate) * Conversion_Factor

data = open('MRB_' + Source + '_Nucorona_' + str(NuCorona) + '.txt','w')

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

			for Magnetic_Field in Magnetic_Field_list:
				data.write('%-10.3e %-10.3e %-10.3e \n' %(Mass, Radius, Magnetic_Field))

data.close()
