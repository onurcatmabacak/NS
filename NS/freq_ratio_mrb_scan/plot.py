import numpy as np
import glob
import os
import matplotlib.pyplot as plt
from matplotlib import cm 

data_list = np.array(sorted(glob.glob('output/*.txt')))

for source_file in data_list:

	source_name = source_file[7:-4]
	print source_file
	print source_name
	directory = 'plot'
	if not os.path.exists(directory):
		os.makedirs(directory)
	
	mass, radius, magnetic_field, X, Y = np.genfromtxt(source_file, delimiter='', usecols=(0,1,2,3,4), skip_header=0, unpack=True)

	radius *= 1e-5
	magnetic_field *= 1e-8

	all_data = zip(mass, radius, magnetic_field)
	data = list(set(all_data))
	mass = np.array(zip(*data)[0])
	radius = np.array(zip(*data)[1])
	magnetic_field = np.array(zip(*data)[2])

	ticks = np.linspace(np.min(magnetic_field), np.max(magnetic_field), num=10, endpoint=True)

	fig = plt.figure(1)
	fig.suptitle(source_name)
	fig.subplots_adjust(wspace=0, hspace=0)

	ax1 = fig.add_subplot(111)	

	cm = plt.cm.get_cmap('RdYlBu')
	sc = plt.scatter(radius, mass, c=magnetic_field, vmin=np.min(magnetic_field), vmax=np.max(magnetic_field), s=4, cmap=cm)
	plt.colorbar(sc)

	'''
	#ax1.scatter(radius, mass, c=magnetic_field)
	ax1.set_xscale('linear')
	ax1.set_yscale('linear')
	ax1.set_xlim(7,16)
	ax1.set_ylim(0,3)
	ax1.xaxis.set_major_locator(plt.FixedLocator([7,8,9,10,11,12,13,14,15,16]))
	ax1.yaxis.set_major_locator(plt.FixedLocator([0,0.5,1.0,1.5,2.0,2.5,3.0]))
	ax1.tick_params(axis='y', labelsize=8)
	ax1.set_xlabel(r'$Radius\;(km)$')
	ax1.set_ylabel(r'$Mass\;(M_{\odot})$')
	ax1.legend(loc=0,prop={'size':8},frameon=False,scatterpoints=1)
	'''
	plt.savefig(directory + '/' + source_name + '.png', dpi=300, format='png')
	plt.close()

