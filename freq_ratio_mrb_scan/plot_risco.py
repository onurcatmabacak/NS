import numpy as np
import matplotlib.pyplot as plt

grav_cons = 6.67e-8
mass_solar = 2e33
light_speed = 3e10

risco = lambda mass: 6.0 * grav_cons * mass * mass_solar / (light_speed**2.0) * 1e-5
mass = np.linspace(0,3,num=100, endpoint=True)

fig = plt.figure(1)
plt.plot(risco(mass), mass, c='k', ls='-', lw=1, label=r'$R_{ISCO}$')
plt.xlim(7,16)
plt.ylim(0,3)
plt.xlabel('radius (km)')
plt.ylabel(r'$mass\;(M_{\odot})$')
plt.legend(loc=0,prop={'size':10},frameon=False,scatterpoints=1)
plt.show()


