import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from random import random
from matplotlib.ticker import NullFormatter, PercentFormatter
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

def limit_functions(a, x):

	'''
	x is deltanu / nu_a
	a is delta
	function returns nu2 / nu1 value

	c = (2.0/a-3.0) * (1/x-1.0) + 1.0
	y = 1.0 / (1.0 - 1.0 / (c**0.5))

	'''

	c = (((2.0 / a) - 3.0) * ((1.0 / x) - 1.0) + 1.0)
	return 1.0 / (1.0 - 1.0 / np.sqrt(c))

def data_process(n, case):

	A = 0.7
	alpha = 1.52 

	upper_qpo = np.array([random() for x in range(n)])*400 + 750
	lower_qpo = np.array([random() for x in range(n)])*300 + 500

	sel = (lower_qpo <= upper_qpo)
	upper_qpo = upper_qpo[sel]
	lower_qpo = lower_qpo[sel]

	deltanu = upper_qpo - lower_qpo

	if case == 1:
		nu_a = np.array([random() for x in range(len(deltanu))])*1450 + 250
	if case == 2:
		nu_a = np.array([random() for x in range(len(deltanu))])*1050 + 150

	deltanu_over_nu_a = deltanu / nu_a
	upper_over_lower = upper_qpo / lower_qpo

	sel = (deltanu <= 400.0) & (deltanu >= 200.0)
	deltanu = deltanu[sel]
	nu_a = nu_a[sel]
	deltanu_over_nu_a = deltanu_over_nu_a[sel]
	upper_over_lower = upper_over_lower[sel]

	sel = (deltanu_over_nu_a >= 0.1)
	nu2_over_nu1 = upper_over_lower[sel]
	dnu_over_nua = deltanu_over_nu_a[sel]

	# filter deltanu / nu_a and upper_qpo / lower_qpo
	dummy_dnu = []
	dummy_ul = []

	for x in range(len(dnu_over_nua)):

		if (nu2_over_nu1[x] <= limit_functions(0.29, dnu_over_nua[x]) and nu2_over_nu1[x] >= limit_functions(0.01, dnu_over_nua[x])):

			dummy_dnu.append(dnu_over_nua[x])
			dummy_ul.append(nu2_over_nu1[x])

	dnu_over_nua = dummy_dnu
	nu2_over_nu1 = dummy_ul

	return lower_qpo, upper_qpo, deltanu, upper_over_lower, dnu_over_nua, nu2_over_nu1

n_list = [1000, 500, 250, 100, 50, 25, 10]

for n in n_list:
	for case in [1,2]:

		lower_qpo, upper_qpo, deltanu, upper_over_lower, dnu_over_nua, nu2_over_nu1 = data_process(n, case)

		# equations for limits
		dnu_nua_arr = np.linspace(1e-3, 1.0, 1000)
		lower_limit = limit_functions(0.01, dnu_nua_arr)
		upper_limit = limit_functions(0.29, dnu_nua_arr)

		fontsize = 10

		fig = plt.figure(1)
		fig.subplots_adjust(wspace=0.3, hspace=0.3)

		ax1 = fig.add_subplot(221)
		ax1.scatter(upper_qpo*1e-3, lower_qpo*1e-3, color='k', marker='o', s=5, label='n:' + str(n))
		ax1.set_xlabel(r'$\mathrm{ \nu_2 \; (kHz) }$', fontsize=fontsize)
		ax1.set_ylabel(r'$\mathrm{ \nu_1 \; (kHz) }$', fontsize=fontsize)   
		#ax1.set_title('%s' %(merger + ' ' + center_label), size=8)
		ax1.set_xscale('linear')
		ax1.set_yscale('linear')
		ax1.set_xlim(0.7, 1.2)
		ax1.set_ylim(0.4, 0.9)

		ax1.xaxis.set_tick_params(labelsize=fontsize)
		ax1.yaxis.set_tick_params(labelsize=fontsize)
		ax1.xaxis.set_major_locator(ticker.MultipleLocator(0.1))
		ax1.xaxis.set_minor_locator(ticker.MultipleLocator(0.05))  
		ax1.yaxis.set_major_locator(ticker.MultipleLocator(0.1))        
		ax1.yaxis.set_minor_locator(ticker.MultipleLocator(0.05))  

		ax1.tick_params(axis='both', color='k', which='minor', direction='in', length=2.0, width=1.0)
		ax1.tick_params(axis='both', color='k', which='major', direction='in', length=4.0, width=2.0)

		ax1.legend(loc=0,frameon=False,scatterpoints=1)

		ax2 = fig.add_subplot(222)
		ax2.scatter(deltanu*1e-3, upper_over_lower, color='k', marker='o', s=5, label='n:' + str(len(deltanu)))
		ax2.set_xlabel(r'$\mathrm{ \Delta \nu \; (kHz) }$', fontsize=fontsize)   
		ax2.set_ylabel(r'$\mathrm{ \nu_2/ \nu_1 }$', fontsize=fontsize)
		#ax2.set_title('%s' %(merger + ' ' + center_label), size=8)
		ax2.set_xscale('linear')
		ax2.set_yscale('linear')
		ax2.set_xlim(0.2, 0.4)
		ax2.set_ylim(1.01, 1.8)

		ax2.xaxis.set_tick_params(labelsize=fontsize)
		ax2.yaxis.set_tick_params(labelsize=fontsize)
		ax2.xaxis.set_major_locator(ticker.MultipleLocator(0.05))
		ax2.xaxis.set_minor_locator(ticker.MultipleLocator(0.01))  
		ax2.yaxis.set_major_locator(ticker.MultipleLocator(0.2))        
		ax2.yaxis.set_minor_locator(ticker.MultipleLocator(0.1))  

		ax2.tick_params(axis='both', color='k', which='minor', direction='in', length=2.0, width=1.0)
		ax2.tick_params(axis='both', color='k', which='major', direction='in', length=4.0, width=2.0)

		ax2.legend(loc=0,frameon=False,scatterpoints=1)

		ax3 = fig.add_subplot(223)
		ax3.scatter(dnu_over_nua, nu2_over_nu1, color='k', marker='o', s=5, alpha=1.0, label='n:' + str(len(dnu_over_nua)))
		ax3.plot(dnu_nua_arr, lower_limit, color='r', ls='-', lw=1, label=r'$\mathrm{ \delta = 0.01 }$')
		ax3.plot(dnu_nua_arr, upper_limit, color='b', ls='-', lw=1, label=r'$\mathrm{ \delta = 0.29 }$')

		ax3.set_xlabel(r'$\mathrm{ \Delta \nu / \nu_A }$', fontsize=fontsize)   
		ax3.set_ylabel(r'$\mathrm{ \nu_2/ \nu_1 }$', fontsize=fontsize)
		#ax3.set_title('%s' %(merger + ' ' + center_label), size=8)
		ax3.set_xscale('log')
		ax3.set_yscale('linear')

		ax3.xaxis.set_major_formatter(NullFormatter())
		ax3.xaxis.set_minor_formatter(NullFormatter())

		#ax3.set_xlim(0.9*np.min(x), 1.1*np.max(x))
		#ax3.set_ylim(0.9*np.min(y), 1.1*np.max(y))
		ax3.set_xlim(1e-1, 1.2e0)
		ax3.set_ylim(1.0, 2.5)
		ax3.set_xticks([1e-1, 1e0])
		ax3.get_xaxis().set_major_formatter(ticker.ScalarFormatter())

		ax3.xaxis.set_tick_params(labelsize=fontsize)
		ax3.yaxis.set_tick_params(labelsize=fontsize)
		#ax3.xaxis.set_major_locator(ticker.FixedLocator([1e-1, 1e0]))
		#ax3.xaxis.set_minor_locator(ticker.MultipleLocator(0.1))  
		ax3.yaxis.set_major_locator(ticker.MultipleLocator(0.2))        
		ax3.yaxis.set_minor_locator(ticker.MultipleLocator(0.1))  

		ax3.tick_params(axis='both', color='k', which='minor', direction='in', length=2.0, width=1.0)
		ax3.tick_params(axis='both', color='k', which='major', direction='in', length=4.0, width=2.0)

		ax3.legend(loc=0, frameon=False,scatterpoints=1)

		ax4 = fig.add_subplot(224)
		ax4.hist(nu2_over_nu1, bins=12, weights=np.ones(len(nu2_over_nu1)) / len(nu2_over_nu1), color='g', edgecolor='k')
		plt.gca().yaxis.set_major_formatter(PercentFormatter(1))
		ax4.set_xlim(1.2,2.0)

		ax4.set_xlabel(r'$\mathrm{ \nu_2 / \nu_1 }$')
		#ax4.set_ylabel(r'$\mathrm{ \# \; of \; occ. }$')
		ax4.xaxis.set_major_locator(ticker.MultipleLocator(0.1))        
		ax4.xaxis.set_minor_locator(ticker.MultipleLocator(0.05))  
		ax4.yaxis.set_minor_locator(ticker.MultipleLocator(5))  

		plt.savefig('qpo_random_n' + str(n) + '_case' + str(case) + '.pdf', bbox_inches='tight')
		plt.close()

		fig, axs = plt.subplots(4,4, figsize=(20, 10), facecolor='w', edgecolor='k')
		fig.subplots_adjust(wspace=0.0, hspace=0.0)

		axs = axs.ravel()

		for i in range(16):

			lower_qpo, upper_qpo, deltanu, upper_over_lower, dnu_over_nua, nu2_over_nu1 = data_process(n, case)
			
			axs[i].scatter(dnu_over_nua, nu2_over_nu1, color='k', marker='o', s=5, alpha=1.0, label='n:' + str(len(dnu_nua_arr)))
			axs[i].plot(dnu_nua_arr, lower_limit, color='r', ls='-', lw=1, label=r'$\mathrm{ \delta = 0.01 }$')
			axs[i].plot(dnu_nua_arr, upper_limit, color='b', ls='-', lw=1, label=r'$\mathrm{ \delta = 0.29 }$')
			axs[i].set_xscale('log')
			axs[i].set_yscale('linear')

			axs[i].xaxis.set_major_formatter(NullFormatter())
			axs[i].xaxis.set_minor_formatter(NullFormatter())

			#axs[i].set_xlim(0.9*np.min(x), 1.1*np.max(x))
			#axs[i].set_ylim(0.9*np.min(y), 1.1*np.max(y))
			axs[i].set_xlim(1e-1, 1.2e0)
			axs[i].set_ylim(1.0, 2.5)
			axs[i].set_xticks([1e-1, 1e0])
			axs[i].set_yticks([1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2])
			axs[i].get_xaxis().set_major_formatter(ticker.ScalarFormatter())

			axs[i].xaxis.set_tick_params(labelsize=fontsize)
			axs[i].yaxis.set_tick_params(labelsize=fontsize)
			#axs[i].xaxis.set_major_locator(ticker.FixedLocator([1e-1, 1e0]))
			#axs[i].xaxis.set_minor_locator(ticker.MultipleLocator(0.1))  
			#axs[i].yaxis.set_major_locator(ticker.MultipleLocator(0.2))        
			axs[i].yaxis.set_minor_locator(ticker.MultipleLocator(0.1))  

			axs[i].tick_params(axis='both', color='k', which='minor', direction='in', length=2.0, width=1.0)
			axs[i].tick_params(axis='both', color='k', which='major', direction='in', length=4.0, width=2.0)

			if i not in [0,4,8,12]:
				#axs[i].yaxis.set_tick_params(labelsize=1e-100)	
				axs[i].set_yticks([])
			if i not in [12,13,14,15]:
				#axs[i].xaxis.set_tick_params(labelsize=1e-100)	
				axs[i].set_xticks([])

			#axins = inset_axes(axs[i], width=1.8, height=0.9, loc=2)
			axins = inset_axes(axs[i], width="80%", height="80%", bbox_to_anchor=(.13, .53, .5, .5), bbox_transform=axs[i].transAxes, loc=3)
			axins.hist(nu2_over_nu1, weights=np.ones(len(nu2_over_nu1)) / len(nu2_over_nu1), bins=12, color='g', edgecolor='k')
			plt.gca().yaxis.set_major_formatter(PercentFormatter(1))

			axins.set_xlim(1.3, 1.7)
			axins.set_xticks([1.3, 1.4, 1.5, 1.6, 1.7])	

		plt.savefig('dist_random_n' + str(n) + '_case' + str(case) + '.pdf', bbox_inches='tight')
		plt.close()
