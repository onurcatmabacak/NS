import numpy as np
import glob
import os
import random
import lmfit 
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

def fit_func(x,c1,c2,c3):
	func = c1 * x**(9./7.) + c2 * x**(10./7.) + c3 * x**(2./7.)
	return func

gravitational_constant = 6.67e-08
mass_solar = 2.0e+33
speed_of_light = 3.0e+10
mdot_eddington = 1.0e+18
kappa_es = 0.4

step = 10
perturbation = 0.0

data_list = np.array(sorted(glob.glob('data/*.txt')))
mass_list = np.arange(0.1,3.1,0.1)
radius_list = np.arange(7.0,16.0,0.1) * 1e5

for source_file in data_list:

	source_name = source_file[5:-9]
	directory = 'output'
	if not os.path.exists(directory):
		os.makedirs(directory)
	
	luminosity, nu2_over_nu1, deltanu  = np.genfromtxt(source_file, delimiter='', usecols=(0,1,2), skip_header=0, unpack=True)
	luminosity *= 2.5e38

	for mass in mass_list:
		mass_star = mass * mass_solar

		for radius in radius_list:

			mdot = luminosity * radius / (mass_star * gravitational_constant)
			mdot_min = np.min(mdot)
			mdot_max = np.max(mdot)

			# Alfven radius is bigger than neutron star's radius
			magnetic_field_min_alfven = np.power((gravitational_constant * mass_star),(1.0/4.0)) * np.power((mdot_max),(1.0/2.0)) * np.power((radius),(-5.0/4.0))
			# Alfven radius is bigger than marginally stable orbit
			magnetic_field_min_isco = np.power((gravitational_constant * mass_star),(2.0)) * np.power((mdot_max),(1.0/2.0)) * np.power((radius),(-3.0)) * np.power((np.square(speed_of_light)/6.0),(-7.0/4.0))

			magnetic_field_min = max(magnetic_field_min_alfven, magnetic_field_min_isco)
		 
			magnetic_field_max = np.power((gravitational_constant * mass_star),(5.0/6.0)) * np.power((mdot_min),(1.0/2.0)) * np.power((radius),(-3.0)) * np.power((2.0*np.pi*np.min(deltanu)),(-7.0/6.0))

			magnetic_field_list = np.logspace(np.log10(magnetic_field_min), np.log10(magnetic_field_max), num=10, endpoint=True)

			for magnetic_field in magnetic_field_list:

				radius_sch = 2.0 * gravitational_constant * mass_star / (speed_of_light ** 2.0)
				radius_alfven = np.power((gravitational_constant * mass_star),(-1.0/7.0)) * np.power((mdot),(-2.0/7.0)) * np.power((magnetic_field),(4.0/7.0)) * np.power((radius),(12.0/7.0))
				omega_kepler = np.sqrt(gravitational_constant * mass_star * np.power(radius_alfven,-3.0))
				omega_rin = 2.0 * np.pi * deltanu

				nu1_over_nu2 = 1.0 / nu2_over_nu1
				f1 = ((1.0 - nu1_over_nu2)**(-2.0)) - 1.0
				f2 = (omega_kepler / omega_rin) - 1.0
				f3 = ((f1 / f2) + 3.0 ) / 2.0
				delta = f3**(-1.0)

				if np.min(delta) >= 0.01 and np.max(delta) <= 0.3:

					mdot_norm = mdot * 1e-18
					'''
					if len(delta) > 1:
						gmodel = lmfit.Model(fit_func)
						gmodel.set_param_hint('c1', value=1.0, min=0.0, max=np.inf)
						gmodel.set_param_hint('c2', value=-1.0, min=-np.inf, max=0.0)
						gmodel.set_param_hint('c3', value=1.0, min=-np.inf, max=np.inf)
						result = gmodel.fit(delta, x=mdot_norm)
		
						print '%-10s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e ' %(source_name, mass, radius, magnetic_field, result.best_values['c1'], result.best_values['c2'], result.best_values['c3'], np.min(delta), np.max(delta))
					else:
						print '%-10s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e ' %(source_name, mass, radius, magnetic_field, np.min(delta), np.max(delta))
					'''
					print '%-10s %-10.3e %-10.3e %-10.3e %-10.3e %-10.3e ' %(source_name, mass, radius, magnetic_field, np.min(delta), np.max(delta))
					#plt.plot(mdot_norm, delta, 'bo')
					#plt.plot(mdot_norm, result.best_fit, 'r-')
					#plt.show()
