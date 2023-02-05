import numpy as np
import random
import itertools
import multiprocessing
from joblib import Parallel, delayed
import sys
import matplotlib.pyplot as plt

#################
### MAIN BODY ###
#################

Source = '4U_1608_52_4.22_kpc'
SourceName = '4U_1608_52.txt'
Conversion_Factor = 4.49754 * 1e-12
Parsec = 4.22
Nucorona = 200.0

Kiloparsec = 3.08567758e+21
Gravitational_Constant = 6.67e-08
Mass_Solar = 2e33
Light_Speed = 3e10
kappa = 0.4

Distance = Parsec * Kiloparsec
Mass = 1.4 * Mass_Solar
Radius = 1e6
Mag_Field = 1e8
D_BL = 10.0
C = 0.6

Count_Rate, Lower_QPO = np.genfromtxt(SourceName, delimiter='', usecols=(0,1), unpack=True)
Flux = np.array(Count_Rate) * Conversion_Factor
Luminosity = 4.0 * np.pi * np.square(Distance) * Flux

Mdot = (Luminosity * Radius) / (Gravitational_Constant * Mass)
r_isco = 6.0 * Gravitational_Constant * Mass / (Light_Speed**2.0)
r_in = ((Gravitational_Constant * Mass)**(-1.0/7.0)) * ((Mdot)**(-2.0/7.0)) * ((Mag_Field)**(4.0/7.0)) * ((Radius)**(12.0/7.0))  
r = r_isco / r_in
r_co = (Gravitational_Constant * Mass / ((2.0 * np.pi * Nucorona)**2.0) )**(1.0/3.0)

H_ss = 3.0 * kappa * Mdot / (8.0 * np.pi * Light_Speed) * (1.0 - C * (r**-0.5))
Epsilon = H_ss / r_in
Delta = D_BL / 2.0 * Epsilon

print '%-10.3e %-10.3e' %(np.min(Delta), np.max(Delta))
print '%-10.3e %s %-10.3e' %(np.min(r_in), ' > ', max(r_isco, Radius))
print '%-10.3e %s %-10.3e' %(np.max(r_in), ' < ', r_co)

if (np.min(Delta) >= 0.001) & (np.max(Delta) <= 0.3) & (np.min(r_in) > max(r_isco, Radius) ) & (np.max(r_in) < r_co) :

	keplerian_freq = np.sqrt((Gravitational_Constant * Mass) / (r_in**3.0))
	a1 = 3.0 - (2.0 / Delta)
	a2 = -a1 * keplerian_freq - 2.0 * Lower_QPO
	a3 = -(Lower_QPO**2.0)
	deltanu1 = (-a2 + np.sqrt((a2**2.0) - (4.0 * a1 * a3))) / (2.0 * a1)
	deltanu2 = (-a2 - np.sqrt((a2**2.0) - (4.0 * a1 * a3))) / (2.0 * a1)
	plt.scatter(Mdot*1e-18, Delta)
	plt.show()
	plt.scatter(Mdot*1e-18, deltanu1)
	plt.scatter(Mdot*1e-18, deltanu2)
	plt.xlim(1e-2, 1e0)
	plt.ylim(0, 400)	
	plt.show()
