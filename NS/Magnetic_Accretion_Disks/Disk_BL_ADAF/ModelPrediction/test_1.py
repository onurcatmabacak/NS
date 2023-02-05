import numpy as np
import matplotlib.pyplot as plt

def fitfunc(x):

    A1=89461.43821652
    A2=10835.745564151
    w1=420.05450884622
    w2=93.836876948741
    xc1=487.24281618702
    xc2=715.91658256079
    y0=187.37317350182

    y = y0 + 2 * A1 / np.pi * w1 / (4 * (x - xc1)**2 + w1**2) + 2 * A2 / np.pi * w2 / (4 * (x - xc2)**2 + w2**2)

    return y

datafile = 'Deltanu_data/4U_1608_52_4.22_kpc_Sample_3.dat'

mass, radius, mag_field, alpha_bl, mdot, epsilon, delta, deltanu, nu1 = np.genfromtxt(datafile, delimiter='', usecols=(0,1,2,3,4,5,7,8,9), skip_header=1, unpack=True)

mass = mass[0]
radius = radius[0]
mag_field = mag_field[0]
alpha_bl = alpha_bl[0]
mdot *= 1e18
deltanu *= 1000.0
nu1 *= 1000.0

grav_constant = 6.67e-8
light_speed = 3e10
solar_mass = 2e33
kappa_es = 0.4

ns_mass = mass * solar_mass

r_in = (grav_constant * ns_mass)**(-1.0/7.0) * mdot**(-2.0/7.0) * mag_field**(4.0/7.0) * radius**(12.0/7.0)
r_isco = 6.0 * grav_constant * ns_mass / (light_speed**2.0)
keplerian_freq = np.sqrt(grav_constant * ns_mass / r_in**3.0) / (2.0 * np.pi)

AMEC = 0.845
h_ss = (3.0 * kappa_es * mdot) /(8.0 * np.pi * light_speed) * (1.0 - AMEC * ((r_isco / r_in)**(-0.5)))
epsilon = h_ss / r_in
delta = epsilon * alpha_bl

a = 3.0 - (2.0 / delta) 
b = -(2.0 * nu1) - (a * keplerian_freq)
c = -(nu1**2.0)
root = (b**2.0) - (4.0 * a * c)
dnu_plus = (-b + np.sqrt(root)) / (2.0 * a)
dnu_minus = (-b - np.sqrt(root)) / (2.0 * a)

fitvalue = fitfunc(nu1)
diff_plus = np.abs(dnu_plus - fitvalue)
diff_minus = np.abs(dnu_minus - fitvalue)

data = np.array([a if b < d else c for a,b,c,d in zip(dnu_plus, diff_plus, dnu_minus, diff_minus)])

#np.array(zip(*data)[0])

x = np.array(range(100,1500))

#plt.scatter(nu1, deltanu, color='k', label='obs.')
#plt.scatter(nu1, dnu_plus, color='b', label='plus')
#plt.scatter(nu1, dnu_minus, color='g', label='minus')
#plt.scatter(nu1, dnu_mean, color='r', label='mean')
plt.plot(x, fitfunc(x), color='k', ls='-', lw=2, label='fit')
plt.scatter(nu1, data, color='r', label='combined solutions')
#plt.scatter(nu1, diff_plus, color='k', label='plus diff')
#plt.scatter(nu1, diff_minus, color='r', label='minus diff')

plt.legend(loc=0,prop={'size':12},frameon=False,scatterpoints=1)
plt.xlim(400,1000)
#plt.ylim(100,400)
plt.show()
#plt.savefig('combined_solutions.pdf')

