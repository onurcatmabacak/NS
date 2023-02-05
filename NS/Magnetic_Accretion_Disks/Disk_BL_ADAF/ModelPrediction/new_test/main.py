import numpy as np
import glob
from scipy.optimize import curve_fit


def func(x,a,b,c):
	return a * (x**2.0/7.0) + b * (x**9.0/7.0) + c * (x**10.0/7.0)

mstar = 1.5 * 2.0e33
radius = 1.1e6
grav_cons = 6.67e-8

filelist = sorted(glob.glob('*_Sample_3.dat'))
print filelist
for fname in filelist:

	source_name = fname[:10]
	distance = float(fname[11:-17])

	mdot, delta = np.genfromtxt(fname, delimiter='', usecols=(4,7), skip_header=0, unpack=True)

	popt, pcov = curve_fit(func, mdot, delta)
	#luminosity = grav_cons * mstar * mdot * mdot_edd / radius
	

