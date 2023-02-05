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

filename = 'pulsar_radio_efficiency_data_Edot_1e32.txt'

p, pdot, edot, eps400, eps1400 = np.genfromtxt(filename, delimiter='', usecols=(5,8,15,18,19), skip_header=4, unpack=True)

ind = 299
p400, p1400 = p[:ind], p[ind:]
pdot400, pdot1400 = pdot[:ind], pdot[ind:]
eps400, eps1400 = eps400[:ind], eps1400[ind:]
edot400, edot1400 = edot[:ind], edot[ind:]

sel400 = (edot400 <= 1e32)
p400 = p400[sel400]
pdot400 = pdot400[sel400]
eps400 = eps400[sel400]

sel1400 = (edot1400 <= 1e32)
p1400 = p1400[sel1400]
pdot1400 = pdot1400[sel1400]
eps1400 = eps1400[sel1400]

ind_400 = np.argsort(eps400)
p400 = p400[ind_400]
pdot400 = pdot400[ind_400]
eps400 = eps400[ind_400]

ind_1400 = np.argsort(eps1400)
p1400 = p1400[ind_1400]
pdot1400 = pdot1400[ind_1400]
eps1400 = eps1400[ind_1400]

p_death, pdot_death = np.genfromtxt('pulsar_deathline.txt', delimiter='', usecols=(0,1), skip_header=0, unpack=True)

pdot_dummy = 10.0**np.arange(-30,0)
age_list = [1e5, 1e6, 1e7, 1e8, 1e9]
edot_list = [1e29, 1e33, 1e37]
b_list = [1e8, 1e10, 1e12, 1e14]

fontsize = 20

fig = plt.figure(1, figsize=(10,10))

ax1 = fig.add_subplot(111)

sc = ax1.scatter(p1400, np.log10(pdot1400), c=np.log10(eps1400), marker='o', s=50, alpha=1.0, vmin=-5.0, vmax=1.0, cmap='coolwarm', label='1400 MHz')
ax1.scatter(p400, np.log10(pdot400), c=np.log10(eps400), marker='*', s=200, alpha=1.0, vmin=-5.0, vmax=1.0, cmap='coolwarm', label='400 MHz')
#ax1.plot(p_death, pdot_death, c='k', ls='-', lw=2, label='PDL Szary+14')

for age in age_list: ax1.plot(p_time(age, pdot_dummy), np.log10(pdot_dummy), c='k', alpha=0.5, ls='--', lw=1)
ax1.text(0.0012, -15.65, '100 kyr', rotation=20, alpha=0.5)
ax1.text(0.0012, -16.65, '1 Myr', rotation=20, alpha=0.5)
ax1.text(0.0012, -17.65, '10 Myr', rotation=20, alpha=0.5)
ax1.text(0.0012, -18.65, '100 Myr', rotation=20, alpha=0.5)
ax1.text(0.0012, -19.65, '1 Gyr', rotation=20, alpha=0.5)

for edot in edot_list: ax1.plot(p_spindown_power(edot, pdot_dummy), np.log10(pdot_dummy), c='r', alpha=0.5, ls='--', lw=1)
ax1.text(0.1, -20.4, r'$\mathrm{ 10^{29} \; ergs/s }$', rotation=45, alpha=0.5, c='r')
ax1.text(0.1, -16.4, r'$\mathrm{ 10^{33} \; ergs/s }$', rotation=45, alpha=0.5, c='r')
ax1.text(0.1, -12.4, r'$\mathrm{ 10^{37} \; ergs/s }$', rotation=45, alpha=0.5, c='r')

for b in b_list: ax1.plot(p_magnetic_field(b, pdot_dummy), np.log10(pdot_dummy), c='b', alpha=0.5, ls='--', lw=1)
ax1.text(0.4, -10.6, r'$\mathrm{ 10^{14} \; G }$', rotation=-20, alpha=0.5, c='b')
ax1.text(0.03, -13.55, r'$\mathrm{ 10^{12} \; G }$', rotation=-20, alpha=0.5, c='b')
ax1.text(0.003, -16.55, r'$\mathrm{ 10^{10} \; G }$', rotation=-20, alpha=0.5, c='b')
ax1.text(0.003, -20.55, r'$\mathrm{ 10^{8} \; G }$', rotation=-20, alpha=0.5, c='b')

ax1.fill_between(p_spindown_power(1e29, pdot_dummy), np.log10(pdot_dummy), -30, color='k', alpha=0.5)
ax1.text(0.5, -20, "Graveyard", fontsize=fontsize)

ax1.set_xlabel('P (s)', fontsize=fontsize)
ax1.set_ylabel('log ' + r'$\mathrm{\dot{P}}$' + r'$(\mathrm{s\; s^{-1}})$', fontsize=fontsize)
ax1.set_title('P-'+ r'$\mathrm{\dot{P}}$' + ' Diagram from ATNF Pulsar Catalogue', size=fontsize)
ax1.set_xscale('log')
ax1.set_yscale('linear')
#ax1.set_yscale('log', nonposy='clip')
ax1.set_xlim(0.001, 10.0)
ax1.set_ylim(-21.5, -10.0)

ax1.xaxis.set_tick_params(labelsize=fontsize)
ax1.yaxis.set_tick_params(labelsize=fontsize)
#ax1.xaxis.set_major_locator(ticker.MultipleLocator())
ax1.xaxis.set_minor_locator(ticker.LogLocator(base=10, subs=(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)))
ax1.yaxis.set_major_locator(ticker.MultipleLocator(2.0))
ax1.yaxis.set_minor_locator(AutoMinorLocator(4))

ax1.xaxis.set_tick_params(which='major', size=8, width=2, direction='in')
ax1.xaxis.set_tick_params(which='minor', size=4, width=1, direction='in')
ax1.yaxis.set_tick_params(which='major', size=8, width=2, direction='in', right='on')
ax1.yaxis.set_tick_params(which='minor', size=4, width=1, direction='in', right='on')

cbar = fig.colorbar(sc, cax=inset_axes(ax1, width="2%", height="100%", loc='lower left', bbox_to_anchor=(1.02,0.0,1.0,1.0), bbox_transform=ax1.transAxes, borderpad=0))
cbar.set_label('log Radio Efficiency', rotation=90, fontsize=fontsize)
cbar.ax.tick_params(labelsize=fontsize)
cbar.solids.set(alpha=1)

ax1.legend(loc='upper left', prop={'size':fontsize}, frameon=True, scatterpoints=1)

fig.savefig('p_pdot_plot+Edot_1e32.pdf', bbox_inches = 'tight')
plt.close()
