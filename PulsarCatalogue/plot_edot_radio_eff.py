import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from matplotlib.ticker import AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

def p_time(age, pdot):

	return age * 2.0 * pdot * 3.154e7

def p_spindown_power(edot, pdot):

	return (4.0 * (np.pi**2.0) * 1e45 * pdot / edot)**(1.0/3.0)
	
def p_magnetic_field(mag_field, pdot):

	return (mag_field**2.0) / (3.2e19 * 3.2e19 * pdot)

filename = 'pulsar_radio_efficiency_data.txt'
p, pdot, edot, eps400, eps1400 = np.genfromtxt(filename, delimiter='', usecols=(5,8,15,18,19), skip_header=4, unpack=True)

ind = 18
p400, pdot400 = p[:ind], pdot[:ind]
p1400, pdot1400 = p[ind:], pdot[ind:]
eps400, eps1400 = eps400[:ind], eps1400[ind:]
edot400, edot1400 = edot[:ind], edot[ind:]

p_death, pdot_death = np.genfromtxt('pulsar_deathline.txt', delimiter='', usecols=(0,1), skip_header=0, unpack=True)

pdot_dummy = 10.0**np.arange(-30,0)
age_list = [1e5, 1e6, 1e7, 1e8, 1e9]
edot_list = [1e29, 1e33, 1e37]
b_list = [1e8, 1e10, 1e12, 1e14]

filename1 = 'edot_vs_eps.txt'
x, y = np.genfromtxt(filename1, delimiter='', usecols=(0,1), skip_header=0, unpack=True)

fit1 = np.poly1d(np.polyfit(x[:2], y[:2], deg=1))
fit2 = np.poly1d(np.polyfit(x[2:], y[2:], deg=1))
x = np.arange(25.0, 35.0)

fontsize = 20

fig = plt.figure(1, figsize=(10,10))

ax1 = fig.add_subplot(111)

ax1.scatter(np.log10(edot400), np.log10(eps400), c='k', marker='o', s=100, label='400 MHz')
ax1.scatter(np.log10(edot1400), np.log10(eps1400), c='r', marker='o', s=100, label='1400 MHz')
ax1.plot(x, fit1(x), c='r', ls='--', lw=1, label=r'$ \xi \propto \dot{E}^{-0.94} $')
ax1.plot(x, fit2(x), c='b', ls='--', lw=1, label=r'$ \xi \propto \dot{E}^{-0.90} $')

ax1.set_xlabel(r'$\log( \dot{E} \; [erg/s] )$', fontsize=fontsize)
ax1.set_ylabel(r'$\log( \xi )$', fontsize=fontsize)
ax1.set_title('Edot vs Radio Effiency', size=fontsize)
ax1.set_xscale('linear')
ax1.set_yscale('linear')
#ax1.set_yscale('log', nonposy='clip')
ax1.set_xlim(27.0, 32.0)
ax1.set_ylim(-1.5, 1.0)

ax1.xaxis.set_tick_params(labelsize=fontsize)
ax1.yaxis.set_tick_params(labelsize=fontsize)
ax1.xaxis.set_major_locator(ticker.MultipleLocator(1))
ax1.xaxis.set_minor_locator(ticker.AutoMinorLocator(4))
ax1.yaxis.set_major_locator(ticker.MultipleLocator(1.0))
ax1.yaxis.set_minor_locator(AutoMinorLocator(4))

ax1.xaxis.set_tick_params(which='major', size=8, width=2, direction='in')
ax1.xaxis.set_tick_params(which='minor', size=4, width=1, direction='in')
ax1.yaxis.set_tick_params(which='major', size=8, width=2, direction='in', right='on')
ax1.yaxis.set_tick_params(which='minor', size=4, width=1, direction='in', right='on')

ax1.legend(loc='upper left', prop={'size':fontsize}, frameon=True, scatterpoints=1)

fig.savefig('edot_radio_eff_plot.pdf', bbox_inches = 'tight')
plt.close()
