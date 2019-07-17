import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt

def fit_func1(cr_data, qpo_data, conversion, d, mass, radius, magnetic_field, x, y, z):

	kiloparsec = 3.08567758e+21
	gravitational_constant = 6.67e-08
	mass_solar = 2.0e+33
	kappa_es = 0.4
	speed_of_light = 3.0e+10
	mdot_edd = 1e18

	flux = cr_data * conversion
	dist = d * kiloparsec
	luminosity = 4.0 * np.pi * np.square(dist) * flux

	mdot = (luminosity * radius * 1e5) / (gravitational_constant * mass * mass_solar)
	radius_alfven = np.power((gravitational_constant * mass * mass_solar),(-1.0/7.0)) * np.power((mdot * mdot_edd),(-2.0/7.0)) * np.power((magnetic_field * 1e8),(4.0/7.0)) * np.power((radius * 1e5),(12.0/7.0))
	omega_rin = np.sqrt(gravitational_constant * mass * mass_solar * np.power(radius_alfven,-3.0))
	keplerian_frequency = omega_rin / (2.0 * np.pi)
	delta = x * ((mdot * mdot_edd)**(2.0/7.0)) + y * ((mdot * mdot_edd)**(9.0/7.0)) + z * ((mdot * mdot_edd)**(10.0/7.0)) 
	a = (2.0/ delta) - 3.0
	delta_nu = ((keplerian_frequency / 2.0) - (qpo_data / a)) + np.sqrt((((keplerian_frequency / 2.0) - (qpo_data / a))**2.0) - ((qpo_data**2.0)/a))

	return delta_nu

def fit_func2(cr_data, qpo_data, conversion, d, mass, radius, magnetic_field, x, y, z):

	kiloparsec = 3.08567758e+21
	gravitational_constant = 6.67e-08
	mass_solar = 2.0e+33
	kappa_es = 0.4
	speed_of_light = 3.0e+10
	mdot_edd = 1.0e+18

	flux = cr_data * conversion
	dist = d * kiloparsec
	luminosity = 4.0 * np.pi * np.square(dist) * flux

	mdot = (luminosity * radius * 1e5) / (gravitational_constant * mass * mass_solar)
	radius_alfven = np.power((gravitational_constant * mass * mass_solar),(-1.0/7.0)) * np.power((mdot * 1e18),(-2.0/7.0)) * np.power((magnetic_field * 1e8),(4.0/7.0)) * np.power((radius * 1e5),(12.0/7.0))
	omega_rin = np.sqrt(gravitational_constant * mass * mass_solar * np.power(radius_alfven,-3.0))
	keplerian_frequency = omega_rin / (2.0 * np.pi)
	delta = x * ((mdot*1e18)**(2.0/7.0)) + y * ((mdot*1e18)**(9.0/7.0)) + z * ((mdot*1e18)**(10.0/7.0)) 
	a = (2.0/ delta) - 3.0
	delta_nu = ((keplerian_frequency / 2.0) - (qpo_data / a)) - np.sqrt((((keplerian_frequency / 2.0) - (qpo_data / a))**2.0) - ((qpo_data**2.0)/a))

	return delta_nu

#################
### MAIN BODY ###
#################

filename = ['1608-52_DNu_Nu1.dat', '1636-54_DNu_Nu1.dat']
dataname = ['4U_1608_52.txt', '4U_1636_54.txt']
conversion_factor = [4.49754e-12, 4.6e-12]
diffs = [2.0, 4.0]
distance = [4.22, 5.5]

for diff, name, data, conversion, d in zip(diffs,filename,dataname,conversion_factor,distance):

	lower_qpo, deltanu = np.genfromtxt(name, delimiter='', usecols=(0,1), skip_header=0, unpack=True)
	count_rate, nu1 = np.genfromtxt(data, delimiter='', usecols=(0,1), skip_header=0, unpack=True)

	qpo_max = lower_qpo + diff
	qpo_min = lower_qpo - diff

	cr_data = []
	qpo_data = []
	deltanu_data = []

	for xxx in range(len(lower_qpo)):

		sel = (nu1 <= qpo_max[xxx]) & (nu1 >= qpo_min[xxx])
		
		for yyy in range(len(count_rate[sel])):

			cr_data.append(count_rate[sel][yyy])
			qpo_data.append(lower_qpo[xxx])
			deltanu_data.append(deltanu[xxx])

	cr_data = np.array(cr_data)
	qpo_data = np.array(qpo_data)
	deltanu_data = np.array(deltanu_data)

	guess = [1.0, 12.0, 1.0, 1.0, 1.0, -1.0]
	bound = ((0.1, 7.0, 1e-2, -np.inf, 0.0, -np.inf), (3.0, 16.0, 1e1, np.inf, np.inf, 0.0))
	popt1, pcov1 = curve_fit(lambda qpo_data,mass,radius,magnetic_field,x,y,z: fit_func1(cr_data, qpo_data, conversion, d, mass, radius, magnetic_field, x, y, z), qpo_data, deltanu_data, guess, bounds=bound)
	popt2, pcov2 = curve_fit(lambda qpo_data,mass,radius,magnetic_field,x,y,z: fit_func2(cr_data, qpo_data, conversion, d, mass, radius, magnetic_field, x, y, z), qpo_data, deltanu_data, guess, bounds=bound)

	plt.scatter(qpo_data, deltanu_data)
	plt.plot(qpo_data, fit_func1(cr_data, qpo_data, conversion, d, *popt1), 'k-')	
	plt.plot(qpo_data, fit_func2(cr_data, qpo_data, conversion, d, *popt2), 'r-')	
	plt.ylim(0,1000)
	plt.show()
