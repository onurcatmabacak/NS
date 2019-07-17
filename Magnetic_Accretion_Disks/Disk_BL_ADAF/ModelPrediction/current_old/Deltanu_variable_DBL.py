import os
import numpy as np
import random
import itertools
import multiprocessing
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

Source_ID = range(6)
Source = ['4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc','4U_1728_34_4.5_kpc']
SourceName = ['4U_1608_52_Gaussian.dat', '4U_1608_52_Gaussian.dat', '4U_1608_52_Gaussian.dat', '4U_1636_54_Gaussian.dat', '4U_1636_54_Gaussian.dat', '4U_1728_34_Gaussian.dat']
Parsec = np.array([3.6, 4.22, 5.0, 5.5, 7.0, 4.5])
Nustar = np.array([619.0, 619.0, 619.0, 581.0, 581.0, 363.0])
Conversion_Factor = np.array([4.49754e-12, 4.49754e-12, 4.49754e-12, 4.6e-12, 4.6e-12, 3.95e-12])
Perturbation = np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0])

global NuCorona 
global a_0 
global H_0 
global Kiloparsec 
global Gravitational_Constant 
global Mass_Solar 
global Kappa_es 
global Speed_of_Light 
global Mdot_Eddington 

NuCorona = 300.0
#a_0 = 0.5
#H_0 = 0.25e5
Kiloparsec = 3.08567758e+21
Gravitational_Constant = 6.67e-08
Mass_Solar = 2.0e+33
Kappa_es = 0.4
Speed_of_Light = 3.0e+10
Mdot_Eddington = 1.0e+18

output_path = './plot/'

if not os.path.exists(output_path):
	os.makedirs(output_path)

for i in Source_ID:
	###############################################
	#################### FIG 3 ####################
	###############################################
	fig, axes = plt.subplots(2,2)
	fig.subplots_adjust(hspace = 0, wspace=0)
	#fig.suptitle(r'$AMEC:$' + str('%-3.2f' %(C)))
	ax = axes.ravel()

	#4U_1608_52_4.22_kpc_Sample_Fit.dat
	coef_path = '../Delta_Nu_Variable_Fit/MRB_Scan/' + Source[i] + '_Sample_Fit.dat'
	a_0, H_0, C = np.genfromtxt(coef_path, delimiter='', usecols=(8,9,10), unpack=True) 

	for k in range(4):
		data_path = '../Delta_Nu_Variable_Fit/MRB_Scan/' + Source[i] + '_Sample_' + str(k+1) + '.dat'
		Mass_raw, Radius_raw, Magnetic_Field_raw, Mdot, Delta, Deltanu, Lower_QPO =np.genfromtxt(data_path, delimiter='', usecols=(0,1,2,4,7,8,9), unpack=True) 
		Mass = Mass_raw[0]
		Mass_NS = Mass * Mass_Solar
		Radius = Radius_raw[0]
		Magnetic_Field = Magnetic_Field_raw[0]
		Mdot *= 1e18
		Deltanu *= 1e3
		Lower_QPO *= 1e3

		R_in = np.power((Gravitational_Constant * Mass_NS),(-1.0/7.0)) * np.power((Mdot),(-2.0/7.0)) * np.power((Magnetic_Field),(4.0/7.0)) * np.power((Radius),(12.0/7.0))	
		R_ISCO = 6.0 * Gravitational_Constant * Mass_NS / np.power(Speed_of_Light,2.0)
		H_SS = (3.0 * Kappa_es * Mdot) / (8.0 * np.pi * Speed_of_Light) * (1.0 - C[k] / np.sqrt(R_in/R_ISCO))

		Epsilon = (a_0[k] * H_SS + H_0[k]) / R_in
		D_BL = 2.0 * Delta / Epsilon

		ax[k].scatter(Mdot, D_BL, color='k', marker='.', s=4)

		ax[k].set_xscale('log')
		ax[k].set_yscale('linear')

		ax[k].set_xlim(1e15,1e18)
		ax[k].set_ylim(0,10)
		ax[k].xaxis.set_major_locator(plt.FixedLocator([1e15,1e16,1e17]))
		ax[k].yaxis.set_major_locator(plt.FixedLocator([0,2,4,6,8]))

		#ax[k].tick_params(axis='x', labelsize=8)
		#ax[k].tick_params(axis='y', labelsize=8)
		ax[k].text(1.2e15,9.5, r'$M:$' + str(Mass) + r'$\;M_{\odot}\;R:$' + str(Radius*1e-5) + r'$\;km\;$' + r'$B:\;$' + str('%-6.2E' %(Magnetic_Field)) + r'$G$', size=6)
		ax[k].text(1.2e15,8.5, r'$a:\;$' + str('%-5.3f' %(a_0[k])) + r'$\;H_0:\;$' + str('%-5.3f' %(H_0[k]*1e-5)) + r'$\;km$', size=6)
		#ax[k].legend(loc=0,prop={'size':6},frameon=False,scatterpoints=1)

		if k == 0:
			ax[k].get_xaxis().set_ticks([])
			#ax[k].get_yaxis().set_ticks([])
			#ax[k].set_xlabel(r'$\dot{M}\;(10^{18}\;gs^{-1})$')
			ax[k].set_ylabel(r'$D_{BL}$')
		if k == 1:
			ax[k].get_xaxis().set_ticks([])
			ax[k].get_yaxis().set_ticks([])
			#ax[k].set_xlabel(r'$\dot{M}\;(10^{18}\;gs^{-1})$')
			#ax[k].set_ylabel(r'$D_{BL}$')
		if k == 2:
			#ax[k].get_xaxis().set_ticks([])
			#ax[k].get_yaxis().set_ticks([])
			ax[k].set_xlabel(r'$\dot{M}\;(g/s)$')
			ax[k].set_ylabel(r'$D_{BL}$')
		if k == 3:
			#ax[k].get_xaxis().set_ticks([])
			ax[k].get_yaxis().set_ticks([])
			ax[k].set_xlabel(r'$\dot{M}\;(g/s)$')
			#ax[k].set_ylabel(r'$D_{BL}$')

		#if (k != 0):
		#	ax[k].legend().set_visible(False)

	#plt.tight_layout()
	plt.savefig(output_path + Source[i] + '_variable_deltanu_mdot_vs_delta.png', dpi=300, format='png')
	plt.close()

