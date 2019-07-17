import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

def filter(dummy1,dummy2):
    dummy1 = np.array(dummy1)
    dummy2 = np.array(dummy2)

    dummy3 = np.arange(np.min(dummy1), np.max(dummy1), 0.1)
    x = np.linspace(np.min(dummy1),np.max(dummy1),1000)
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

    degree = 20

    fit_min = np.polyfit(onur,merve,degree)
    fit_max = np.polyfit(onur,onder,degree)

    func_min = 0.0
    func_max = 0.0

    for i in range(len(fit_min)):

      func_min += fit_min[len(fit_min)-i-1] * np.power(x,i) 
      func_max += fit_max[len(fit_max)-i-1] * np.power(x,i) 

    return x, func_min, func_max

file1 = '4U_1608_52_3.6_kpc.dat'
file2 = '4U_1608_52_4.22_kpc.dat'
file3 = '4U_1608_52_5.0_kpc.dat'
file4 = '4U_1636_54_5.5_kpc.dat'
file5 = '4U_1636_54_7.0_kpc.dat'
file6 = '4U_1728_34_4.5_kpc.dat'
file7 = 'Aql_X_1_2.5_kpc_Barret.dat'
file8 = 'Aql_X_1_5.2_kpc_Barret.dat'
file9 = 'Aql_X_1_2.5_kpc_Mendez.dat'
file10 = 'Aql_X_1_5.2_kpc_Mendez.dat'

f1 = open(file1, 'r')
f2 = open(file2, 'r')
f3 = open(file3, 'r')
f4 = open(file4, 'r')
f5 = open(file5, 'r')
f6 = open(file6, 'r')
f7 = open(file7, 'r')
f8 = open(file8, 'r')
f9 = open(file9, 'r')
f10 = open(file10, 'r')

next(f1)
next(f2)
next(f3)
next(f4)
next(f5)
next(f6)
next(f7)
next(f8)
next(f9)
next(f10)

a1 = []
a2 = [] 
a3 = []
a4 = []
a5 = []
a6 = []
a7 = []
a8 = []
a9 = []
a10 = []

h1 = []
h2 = []
h3 = []
h4 = []
h5 = []
h6 = []
h7 = []
h8 = []
h9 = []
h10 = []

m1 = []
m2 = [] 
m3 = []
m4 = []
m5 = []
m6 = []
m7 = []
m8 = []
m9 = []
m10 = []

r1 = []
r2 = []
r3 = []
r4 = []
r5 = []
r6 = []
r7 = []
r8 = []
r9 = []
r10 = []

for line1,line2,line3,line4,line5,line6,line7,line8,line9,line10 in zip(f1,f2,f3,f4,f5,f6,f7,f8,f9,f10):

    data1 = line1.split()
    data2 = line2.split()
    data3 = line3.split()
    data4 = line4.split()
    data5 = line5.split()
    data6 = line6.split()
    data7 = line7.split()
    data8 = line8.split()
    data9 = line9.split()
    data10 = line10.split()

    a1.append(float(data1[10]))
    a2.append(float(data2[10]))
    a3.append(float(data3[10]))
    a4.append(float(data4[10]))
    a5.append(float(data5[10]))
    a6.append(float(data6[10]))
    a7.append(float(data7[10]))
    a8.append(float(data8[10]))
    a9.append(float(data9[10]))
    a10.append(float(data10[10]))

    h1.append(float(data1[11]))
    h2.append(float(data2[11]))
    h3.append(float(data3[11]))
    h4.append(float(data4[11]))
    h5.append(float(data5[11]))
    h6.append(float(data6[11]))
    h7.append(float(data7[11]))
    h8.append(float(data8[11]))
    h9.append(float(data9[11]))
    h10.append(float(data10[11]))

    m1.append(float(data1[2]))
    m2.append(float(data2[2]))
    m3.append(float(data3[2]))
    m4.append(float(data4[2]))
    m5.append(float(data5[2]))
    m6.append(float(data6[2]))
    m7.append(float(data7[2]))
    m8.append(float(data8[2]))
    m9.append(float(data9[2]))
    m10.append(float(data10[2]))

    r1.append(float(data1[3]))
    r2.append(float(data2[3]))
    r3.append(float(data3[3]))
    r4.append(float(data4[3]))
    r5.append(float(data5[3]))
    r6.append(float(data6[3]))
    r7.append(float(data7[3]))
    r8.append(float(data8[3]))
    r9.append(float(data9[3]))
    r10.append(float(data10[3]))

h1 = [aa*1e-5 for aa in h1]
h2 = [aa*1e-5 for aa in h2]
h3 = [aa*1e-5 for aa in h3]
h4 = [aa*1e-5 for aa in h4]
h5 = [aa*1e-5 for aa in h5]
h6 = [aa*1e-5 for aa in h6]
h7 = [aa*1e-5 for aa in h7]
h8 = [aa*1e-5 for aa in h8]
h9 = [aa*1e-5 for aa in h9]
h10 = [aa*1e-5 for aa in h10]

r1 = [aa*1e-5 for aa in r1]
r2 = [aa*1e-5 for aa in r2]
r3 = [aa*1e-5 for aa in r3]
r4 = [aa*1e-5 for aa in r4]
r5 = [aa*1e-5 for aa in r5]
r6 = [aa*1e-5 for aa in r6]
r7 = [aa*1e-5 for aa in r7]
r8 = [aa*1e-5 for aa in r8]
r9 = [aa*1e-5 for aa in r9]
r10 = [aa*1e-5 for aa in r10]

high1 = np.min([np.max(a1),np.max(a2),np.max(a3),np.max(a4),np.max(a5),np.max(a6),np.max(a7),np.max(a8),np.max(a9),np.max(a10)])
high2 = np.min([np.max(h1),np.max(h2),np.max(h3),np.max(h4),np.max(h5),np.max(h6),np.max(h7),np.max(h8),np.max(h9),np.max(h10)])
low1 = np.max([np.min(a1),np.min(a2),np.min(a3),np.min(a4),np.min(a5),np.min(a6),np.min(a7),np.min(a8),np.min(a9),np.min(a10)])
low2 = np.max([np.min(h1),np.min(h2),np.min(h3),np.min(h4),np.min(h5),np.min(h6),np.min(h7),np.min(h8),np.min(h9),np.min(h10)])

mnew1 = [aa for aa,bb,cc in zip(m1,a1,h1) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew2 = [aa for aa,bb,cc in zip(m2,a2,h2) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew3 = [aa for aa,bb,cc in zip(m3,a3,h3) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew4 = [aa for aa,bb,cc in zip(m4,a4,h4) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew5 = [aa for aa,bb,cc in zip(m5,a5,h5) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew6 = [aa for aa,bb,cc in zip(m6,a6,h6) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew7 = [aa for aa,bb,cc in zip(m7,a7,h7) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew8 = [aa for aa,bb,cc in zip(m8,a8,h8) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew9 = [aa for aa,bb,cc in zip(m9,a9,h9) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
mnew10 = [aa for aa,bb,cc in zip(m10,a10,h10) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]

rnew1 = [aa for aa,bb,cc in zip(r1,a1,h1) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew2 = [aa for aa,bb,cc in zip(r2,a2,h2) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew3 = [aa for aa,bb,cc in zip(r3,a3,h3) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew4 = [aa for aa,bb,cc in zip(r4,a4,h4) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew5 = [aa for aa,bb,cc in zip(r5,a5,h5) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew6 = [aa for aa,bb,cc in zip(r6,a6,h6) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew7 = [aa for aa,bb,cc in zip(r7,a7,h7) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew8 = [aa for aa,bb,cc in zip(r8,a8,h8) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew9 = [aa for aa,bb,cc in zip(r9,a9,h9) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]
rnew10 = [aa for aa,bb,cc in zip(r10,a10,h10) if bb <= high1 if bb >= low1 if cc <= high2 if cc >= low2]

anew1 = [aa for aa,bb in zip(a1,h1) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew2 = [aa for aa,bb in zip(a2,h2) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew3 = [aa for aa,bb in zip(a3,h3) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew4 = [aa for aa,bb in zip(a4,h4) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew5 = [aa for aa,bb in zip(a5,h5) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew6 = [aa for aa,bb in zip(a6,h6) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew7 = [aa for aa,bb in zip(a7,h7) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew8 = [aa for aa,bb in zip(a8,h8) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew9 = [aa for aa,bb in zip(a9,h9) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
anew10 = [aa for aa,bb in zip(a10,h10) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]

hnew1 = [bb for aa,bb in zip(a1,h1) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew2 = [bb for aa,bb in zip(a2,h2) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew3 = [bb for aa,bb in zip(a3,h3) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew4 = [bb for aa,bb in zip(a4,h4) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew5 = [bb for aa,bb in zip(a5,h5) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew6 = [bb for aa,bb in zip(a6,h6) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew7 = [bb for aa,bb in zip(a7,h7) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew8 = [bb for aa,bb in zip(a8,h8) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew9 = [bb for aa,bb in zip(a9,h9) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]
hnew10 = [bb for aa,bb in zip(a10,h10) if aa <= high1 if aa >= low1 if bb <= high2 if bb >= low2]

x1,onur1, onder1 = filter(rnew1,mnew1)
x2,onur2, onder2 = filter(rnew2,mnew2)
x3,onur3, onder3 = filter(rnew3,mnew3)
x4,onur4, onder4 = filter(rnew4,mnew4)
x5,onur5, onder5 = filter(rnew5,mnew5)
x6,onur6, onder6 = filter(rnew6,mnew6)
x7,onur7, onder7 = filter(rnew7,mnew7)
x8,onur8, onder8 = filter(rnew8,mnew8)
x9,onur9, onder9 = filter(rnew9,mnew9)
x10,onur10, onder10 = filter(rnew10,mnew10)

x11,onur11, onder11 = filter(anew1,hnew1)
x12,onur12, onder12 = filter(anew2,hnew2)
x13,onur13, onder13 = filter(anew3,hnew3)
x14,onur14, onder14 = filter(anew4,hnew4)
x15,onur15, onder15 = filter(anew5,hnew5)
x16,onur16, onder16 = filter(anew6,hnew6)
x17,onur17, onder17 = filter(anew7,hnew7)
x18,onur18, onder18 = filter(anew8,hnew8)
x19,onur19, onder19 = filter(anew9,hnew9)
x20,onur20, onder20 = filter(anew10,hnew10)

alpha = 0.3

fig = plt.figure(1)
fig.subplots_adjust(wspace=0, hspace=0.25)

ax1 = fig.add_subplot(211)
#ax1.fill_between(x1, onur1, onder1, color='g', alpha=alpha, label=r'$4U\;1608-52\;3.6\;kpc$')
ax1.fill_between(x2, onur2, onder2, color='r', alpha=alpha, label=r'$4U\;1608-52\;4.22\;kpc$')
#ax1.fill_between(x3, onur3, onder3, color='b', alpha=alpha, label=r'$4U\;1608-52\;5.0\;kpc$')
ax1.fill_between(x4, onur4, onder4, color='k', alpha=alpha, label=r'$4U\;1636-54\;5.5\;kpc$')
#ax1.fill_between(x5, onur5, onder5, color='c', alpha=alpha, label=r'$4U\;1636-54\;7.0\;kpc$')
ax1.fill_between(x6, onur6, onder6, color='m', alpha=alpha, label=r'$4U\;1728-34\;4.5\;kpc$')
ax1.fill_between(x7, onur7, onder7, color='b', alpha=alpha, label=r'$Aql\;X-1\;2.5\;kpc\;Barret$')
#ax1.fill_between(x8, onur8, onder8, color='k', alpha=alpha, label=r'$Aql\;X-1\;5.2\;kpc\;Barret$')
ax1.fill_between(x9, onur9, onder9, color='c', alpha=alpha, label=r'$Aql\;X-1\;2.5\;kpc\;Mendez$')
#ax1.fill_between(x10, onur10, onder10, color='m', alpha=alpha, label=r'$Aql\;X-1\;5.2\;kpc\;Mendez$')

ax1.set_xscale('linear')
ax1.set_yscale('linear')
ax1.set_xlim(7,16)
ax1.set_ylim(0,3)
ax1.text(13, 2.8, '4U 1608-52 4.22 kpc', color='red', fontsize=10)
ax1.text(13, 2.6, '4U 1636-54 5.5 kpc', color='blue', fontsize=10)
ax1.text(13, 2.4, '4U 1728-34 4.5 kpc', color='green', fontsize=10)
ax1.text(13, 2.2, 'Aql X-1 2.5 kpc Barret', color='cyan', fontsize=10)
ax1.text(13, 2.0, 'Aql X-1 2.5 kpc Mendez', color='black', fontsize=10)
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
#ax2.fill_between(x11, onur11, onder11, color='g', alpha=alpha, label=r'$4U\;1608-52\;3.6\;kpc$')
ax2.fill_between(x12, onur12, onder12, color='r', alpha=alpha, label=r'$4U\;1608-52\;4.22\;kpc$')
#ax2.fill_between(x13, onur13, onder13, color='b', alpha=alpha, label=r'$4U\;1608-52\;5.0\;kpc$')
ax2.fill_between(x14, onur14, onder14, color='k', alpha=alpha, label=r'$4U\;1636-54\;5.5\;kpc$')
#ax2.fill_between(x15, onur15, onder15, color='c', alpha=alpha, label=r'$4U\;1636-54\;7.0\;kpc$')
ax2.fill_between(x16, onur16, onder16, color='m', alpha=alpha, label=r'$4U\;1728-34\;4.5\;kpc$')
ax2.fill_between(x17, onur17, onder17, color='b', alpha=alpha, label=r'$Aql\;X-1\;2.5\;kpc\;Barret$')
#ax2.fill_between(x18, onur18, onder18, color='k', alpha=alpha, label=r'$Aql\;X-1\;5.2\;kpc\;Barret$')
ax2.fill_between(x19, onur19, onder19, color='c', alpha=alpha, label=r'$Aql\;X-1\;2.5\;kpc\;Mendez$')
#ax2.fill_between(x20, onur20, onder20, color='m', alpha=alpha, label=r'$Aql\;X-1\;5.2\;kpc\;Mendez$')

ax2.set_xscale('linear')
ax2.set_yscale('linear')
ax2.set_xlim(-0.25,6)
ax2.set_ylim(-0.1,2)
ax2.text(4, 1.8, '4U 1608-52 4.22 kpc', color='red', fontsize=10)
ax2.text(4, 1.6, '4U 1636-54 5.5 kpc', color='blue', fontsize=10)
ax2.text(4, 1.4, '4U 1728-34 4.5 kpc', color='green', fontsize=10)
ax2.text(4, 1.2, 'Aql X-1 2.5 kpc Barret', color='cyan', fontsize=10)
ax2.text(4, 1.0, 'Aql X-1 2.5 kpc Mendez', color='black', fontsize=10)
ax2.xaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=7))
ax2.xaxis.set_minor_locator(ticker.MultipleLocator(0.25))
ax2.yaxis.set_major_locator(ticker.MaxNLocator(prune=None, nbins=12))
ax2.yaxis.set_minor_locator(ticker.MultipleLocator(0.05))
#ax2.tick_params(axis='y', labelsize=10)
ax2.set_xlabel(r'$a$')
ax2.set_ylabel(r'$H_0\;(km)$')
#ax2.legend(loc='upper right',prop={'size':8},frameon=False,fill_betweenpoints=1)

plt.savefig('deneme.png', dpi=300, format='png')
plt.close()
