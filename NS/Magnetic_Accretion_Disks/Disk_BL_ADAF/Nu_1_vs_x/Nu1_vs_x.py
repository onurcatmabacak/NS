#!/usr/bin/env python
import numpy as np 
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

source = ['4U_1608_52_4.22_kpc_Sample_3.dat', '4U_1608_52_4.22_kpc_Sample_3_Reduced.dat', '4U_1636_54_5.5_kpc_Sample_3.dat', '4U_1636_54_5.5_kpc_Sample_3_Reduced.dat', 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat', 'Aql_X_1_2.5_kpc_Barret_Sample_3.dat']
figname = ['4U_1608_52_4.22_kpc.eps', '4U_1608_52_4.22_kpc_Reduced.eps', '4U_1636_54_5.5_kpc.eps', '4U_1636_54_5.5_kpc_Reduced.eps', 'Aql_X_1_2.5_kpc_Mendez.eps', 'Aql_X_1_2.5_kpc_Barret.eps']

k = 2

filename = source[k]
Mdot = []
Delta = []
Lower_QPO = []
num_lines = sum(1 for line in open(filename))
x = np.zeros(shape=(num_lines))

f = open(filename, 'r')
for i in range(num_lines):
    data = f.readline().split()
    Mdot.append(float(data[4]))
    Delta.append(float(data[7]))
    Lower_QPO.append(float(data[9])/1000.0)
#    print Mdot[i],Delta[i],Lower_QPO[i]
for i in range(num_lines):
    x[i] = np.sqrt(pow(Mdot[i],(3.0/7.0)) / Delta[i])

fig = plt.figure(1,figsize=(5,5))
ax1 = fig.add_subplot(111)
ax1.scatter(x, Lower_QPO, color='k', marker='.', s=20)
ax1.set_xscale('linear')
ax1.set_yscale('linear')
ax1.set_xlim(1,3)
ax1.set_ylim(0.5,1.12)
ax1.xaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=5))
ax1.xaxis.set_minor_locator(ticker.MultipleLocator(0.1))
ax1.yaxis.set_minor_locator(ticker.MultipleLocator(0.01))
ax1.set_xlabel(r'$x \quad (\sqrt{\dot M ^{3/7} / \delta})$', fontsize=20)
ax1.set_ylabel(r'$\nu_{1} \; [kHz]$', fontsize=20)

#ax1.text(0.1, 0.95, r'$4U \; 1608-52 \quad 4.22 kpc \quad M:1.5 M_{\odot} \quad R:11km \quad B:1.1 \times 10^8 G$', fontsize=9)
#ax1.text(0.1, 0.95, r'$Aql X-1 \quad 2.5 kpc \quad M:1.5 M_{\odot} \quad R:11km \quad B:0.63 \times 10^8 G$', fontsize=9)
ax1.text(1.05, 1.08, r'$4U \; 1636-54 \quad 5.5 kpc \quad M:1.5 M_{\odot} \quad R:11km \quad B:0.87 \times 10^8 G$', fontsize=9)
#ax1.text(0.1, 0.95, r'$Aql X-1 \quad 2.5 kpc \quad M:1.5 M_{\odot} \quad R:11km \quad B:0.33 \times 10^8 G$', fontsize=9)

fig.savefig(figname[k], format='eps',bbox_inches='tight')
