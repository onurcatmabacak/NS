import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

def filter(dummy1,dummy2):
    dummy1 = np.array(dummy1)
    dummy2 = np.array(dummy2)

    dummy3 = np.arange(np.min(dummy1), np.max(dummy1), 0.1)
    onur = []
    onder = []
    merve = []

    err = 0.01
    for j in dummy3:
        aaaa = [abuzer for abuzer,pelinsu in zip(dummy2,dummy1) if pelinsu < j+err if pelinsu > j-err]
        if len(aaaa) <= 1:
            continue
        else:
            onur.append(j)
            onder.append(np.max(aaaa))
            merve.append(np.min(aaaa))

    return onur,onder,merve

file1 = '4U_1608_52_3.6_kpc.dat'
file2 = '4U_1608_52_4.22_kpc.dat'
file3 = '4U_1608_52_5.0_kpc.dat'
file4 = '4U_1636_54_5.5_kpc.dat'
file5 = '4U_1636_54_7.0_kpc.dat'
file6 = '4U_1728_34_4.5_kpc.dat'

f1 = open(file1, 'r')
f2 = open(file2, 'r')
f3 = open(file3, 'r')
f4 = open(file4, 'r')
f5 = open(file5, 'r')
f6 = open(file6, 'r')

next(f1)
next(f2)
next(f3)
next(f4)
next(f5)
next(f6)

a1 = []
a2 = [] 
a3 = []
a4 = []
a5 = []
a6 = []

h1 = []
h2 = []
h3 = []
h4 = []
h5 = []
h6 = []

m1 = []
m2 = [] 
m3 = []
m4 = []
m5 = []
m6 = []

r1 = []
r2 = []
r3 = []
r4 = []
r5 = []
r6 = []

for line1,line2,line3,line4,line5,line6 in zip(f1,f2,f3,f4,f5,f6):

    data1 = line1.split()
    data2 = line2.split()
    data3 = line3.split()
    data4 = line4.split()
    data5 = line5.split()
    data6 = line6.split()

    a1.append(float(data1[10]))
    a2.append(float(data2[10]))
    a3.append(float(data3[10]))
    a4.append(float(data4[10]))
    a5.append(float(data5[10]))
    a6.append(float(data6[10]))

    h1.append(float(data1[11]))
    h2.append(float(data2[11]))
    h3.append(float(data3[11]))
    h4.append(float(data4[11]))
    h5.append(float(data5[11]))
    h6.append(float(data6[11]))

    m1.append(float(data1[2]))
    m2.append(float(data2[2]))
    m3.append(float(data3[2]))
    m4.append(float(data4[2]))
    m5.append(float(data5[2]))
    m6.append(float(data6[2]))

    r1.append(float(data1[3]))
    r2.append(float(data2[3]))
    r3.append(float(data3[3]))
    r4.append(float(data4[3]))
    r5.append(float(data5[3]))
    r6.append(float(data6[3]))

h1 = [aa*1e-5 for aa in h1]
h2 = [aa*1e-5 for aa in h2]
h3 = [aa*1e-5 for aa in h3]
h4 = [aa*1e-5 for aa in h4]
h5 = [aa*1e-5 for aa in h5]
h6 = [aa*1e-5 for aa in h6]

r1 = [aa*1e-5 for aa in r1]
r2 = [aa*1e-5 for aa in r2]
r3 = [aa*1e-5 for aa in r3]
r4 = [aa*1e-5 for aa in r4]
r5 = [aa*1e-5 for aa in r5]
r6 = [aa*1e-5 for aa in r6]

high1 = np.min([np.max(a1),np.max(a2),np.max(a3),np.max(a4),np.max(a5),np.max(a6)])
high2 = np.min([np.max(h1),np.max(h2),np.max(h3),np.max(h4),np.max(h5),np.max(h6)])
low1 = np.max([np.min(a1),np.min(a2),np.min(a3),np.min(a4),np.min(a5),np.min(a6)])
low2 = np.max([np.min(h1),np.min(h2),np.min(h3),np.min(h4),np.min(h5),np.min(h6)])

mnew1 = [aa for aa,bb,cc in zip(m1,a1,h1) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew2 = [aa for aa,bb,cc in zip(m2,a2,h2) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew3 = [aa for aa,bb,cc in zip(m3,a3,h3) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew4 = [aa for aa,bb,cc in zip(m4,a4,h4) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew5 = [aa for aa,bb,cc in zip(m5,a5,h5) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew6 = [aa for aa,bb,cc in zip(m6,a6,h6) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]

rnew1 = [aa for aa,bb,cc in zip(r1,a1,h1) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew2 = [aa for aa,bb,cc in zip(r2,a2,h2) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew3 = [aa for aa,bb,cc in zip(r3,a3,h3) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew4 = [aa for aa,bb,cc in zip(r4,a4,h4) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew5 = [aa for aa,bb,cc in zip(r5,a5,h5) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew6 = [aa for aa,bb,cc in zip(r6,a6,h6) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]

anew1 = [aa for aa,bb in zip(a1,h1) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew2 = [aa for aa,bb in zip(a2,h2) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew3 = [aa for aa,bb in zip(a3,h3) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew4 = [aa for aa,bb in zip(a4,h4) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew5 = [aa for aa,bb in zip(a5,h5) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew6 = [aa for aa,bb in zip(a6,h6) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]

hnew1 = [bb for aa,bb in zip(a1,h1) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew2 = [bb for aa,bb in zip(a2,h2) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew3 = [bb for aa,bb in zip(a3,h3) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew4 = [bb for aa,bb in zip(a4,h4) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew5 = [bb for aa,bb in zip(a5,h5) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew6 = [bb for aa,bb in zip(a6,h6) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]

onur1, onder1, merve1 = filter(rnew1,mnew1)
onur2, onder2, merve2 = filter(rnew2,mnew2)
onur3, onder3, merve3 = filter(rnew3,mnew3)
onur4, onder4, merve4 = filter(rnew4,mnew4)
onur5, onder5, merve5 = filter(rnew5,mnew5)
onur6, onder6, merve6 = filter(rnew6,mnew6)

onur11, onder11, merve11 = filter(anew1,hnew1)
onur12, onder12, merve12 = filter(anew2,hnew2)
onur13, onder13, merve13 = filter(anew3,hnew3)
onur14, onder14, merve14 = filter(anew4,hnew4)
onur15, onder15, merve15 = filter(anew5,hnew5)
onur16, onder16, merve16 = filter(anew6,hnew6)

alpha = 0.3

fig = plt.figure(1)
fig.subplots_adjust(wspace=0, hspace=0.25)

ax1 = fig.add_subplot(211)
#ax1.fill_between(onur1, onder1, merve1, color='g', alpha=alpha, label=r'$4U\;1608-52\;3.6\;kpc$')
ax1.fill_between(onur2, onder2, merve2, color='r', alpha=alpha, label=r'$4U\;1608-52\;4.22\;kpc$')
#ax1.fill_between(onur3, onder3, merve3, color='b', alpha=alpha, label=r'$4U\;1608-52\;5.0\;kpc$')
ax1.fill_between(onur4, onder4, merve4, color='k', alpha=alpha, label=r'$4U\;1636-54\;5.5\;kpc$')
#ax1.fill_between(onur5, onder5, merve5, color='c', alpha=alpha, label=r'$4U\;1636-54\;7.0\;kpc$')
ax1.fill_between(onur6, onder6, merve6, color='m', alpha=alpha, label=r'$4U\;1728-34\;4.5\;kpc$')
ax1.set_xscale('linear')
ax1.set_yscale('linear')
ax1.set_xlim(7,16)
ax1.set_ylim(0,3)
ax1.text(13, 2.8, '4U 1608-52 4.22 kpc', color='red', fontsize=10)
ax1.text(13, 2.6, '4U 1636-54 5.5 kpc', color='blue', fontsize=10)
ax1.text(13, 2.4, '4U 1728-34 4.5 kpc', color='green', fontsize=10)
ax1.xaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=10))
ax1.xaxis.set_minor_locator(ticker.MultipleLocator(0.25))
ax1.yaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=7))
ax1.yaxis.set_minor_locator(ticker.MultipleLocator(0.1))
ax1.tick_params(axis='x')
ax1.tick_params(axis='y')
ax1.set_xlabel(r'$Radius\;(km)$')
ax1.set_ylabel(r'$Mass\;(M_{\odot})$')
#ax1.legend(loc='upper right',prop={'size':8},frameon=False,fill_betweenpoints=1)

ax2 = fig.add_subplot(212)
#ax2.fill_between(onur11, onder11, merve11, color='g', alpha=alpha, label=r'$4U\;1608-52\;3.6\;kpc$')
ax2.fill_between(onur12, onder12, merve12, color='r', alpha=alpha, label=r'$4U\;1608-52\;4.22\;kpc$')
#ax2.fill_between(onur13, onder13, merve13, color='b', alpha=alpha, label=r'$4U\;1608-52\;5.0\;kpc$')
ax2.fill_between(onur14, onder14, merve14, color='k', alpha=alpha, label=r'$4U\;1636-54\;5.5\;kpc$')
#ax2.fill_between(onur15, onder15, merve15, color='c', alpha=alpha, label=r'$4U\;1636-54\;7.0\;kpc$')
ax2.fill_between(onur16, onder16, merve16, color='m', alpha=alpha, label=r'$4U\;1728-34\;4.5\;kpc$')
ax2.set_xscale('linear')
ax2.set_yscale('linear')
ax2.set_xlim(-0.25,6)
ax2.set_ylim(-0.1,2)
ax2.text(4, 1.8, '4U 1608-52 4.22 kpc', color='red', fontsize=10)
ax2.text(4, 1.6, '4U 1636-54 5.5 kpc', color='blue', fontsize=10)
ax2.text(4, 1.4, '4U 1728-34 4.5 kpc', color='green', fontsize=10)
ax2.xaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=7))
ax2.xaxis.set_minor_locator(ticker.MultipleLocator(0.25))
ax2.yaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=12))
ax2.yaxis.set_minor_locator(ticker.MultipleLocator(0.05))
#ax2.tick_params(axis='y', labelsize=10)
ax2.set_xlabel(r'$a$')
ax2.set_ylabel(r'$H_0\;(km)$')
#ax2.legend(loc='upper right',prop={'size':8},frameon=False,fill_betweenpoints=1)

plt.savefig('MR_ah0.png', dpi=300, format='png')
plt.close()
