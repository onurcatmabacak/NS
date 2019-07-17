set terminal postscript portrait enhanced color font "Courier Bold, 20"
set out "MS_Repair.eps"
set encoding iso_8859_1 
set size 1.17,1.61
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 1,3

# 1608-52
unset label
unset xlabel
unset ylabel
set size 1,0.5
set format x "%g"
set format y "%g"
set origin 0.16,1.105

set xrange [0:0.35]
set yrange [0:0.35]
set xtics 0.05,0.05,0.3
set ytics 0.1,0.1,0.3
set key at 0.325,0.3

set ylabel "{/Symbol d}"  rotate by 0 font ", 30"

d=9.0/7.0
e=10.0/7.0
f=2.0/7.0

f(x)=a*(x**d)-b*(x**e)+c*(x**f)
g(x)=m*x+n
h(x)=p*(x**q)

mass=2.0E+33
radius=1.1E+06
mag_field=1.09E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

fit f(x) '1608-52.txt' using ($2*1.0E-18):5 via a,b,c

Small_a=a/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b/a)
H_0=c*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=a_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b_err/a_err)
H_0_err=c_err*Alfven_Radius_18/Alpha_BL*1.0E-05


set label sprintf("SSE=%3.3f",FIT_WSSR) at 0.12,0.1
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.12,0.08
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.12,0.06
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.12,0.04
fit g(x) '1608-52.txt' using ($2*1.0E-18):5 via m,n
set label sprintf("SSE=%3.3f",FIT_WSSR) tc rgb "blue" at 0.245,0.23
fit h(x) '1608-52.txt' using ($2*1.0E-18):5 via p,q
set label sprintf("SSE=%3.3f",FIT_WSSR) tc rgb "red" at 0.245,0.21
set label "{/Symbol Dn}=224Hz" at 0.25,0.31
set label "4U 1608-52" at 0.12,0.12


plot \
'1608-52.txt' using ($2*1.0E-18):5 pt 7 ps 2 notitle,\
f(x) lt 1 lw 3 lc rgb "black" title 'phy',\
g(x) lt 2 lw 2 lc rgb "blue" title 'linear',\
h(x) lt 3 lw 2 lc rgb "red" title 'PL'

# 1636-54
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 1,0.5
set format x "%g"
set format y "%g"

set ylabel "{/Symbol d}" rotate by 0 font ", 30"

set origin 0.16,0.605
set xrange [0:0.6]
set yrange [0:0.7]
set xtics 0.1,0.1,0.5 nomirror
set ytics 0.2,0.2,0.6

set key at 0.6,0.5

d=9.0/7.0
e=10.0/7.0
f=2.0/7.0

f(x)=a*(x**d)-b*(x**e)+c*(x**f)
g(x)=m*x+n
h(x)=p*(x**q)

mass=2.0E+33
radius=1.1E+06
mag_field=0.58E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=3.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

fit f(x) '1636-54.txt' using ($2*1.0E-18):5 via a,b,c

Small_a=a/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b/a)
H_0=c*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=a_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b_err/a_err)
H_0_err=c_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.2,0.20
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.2,0.16
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.2,0.12
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.2,0.08

fit g(x) '1636-54.txt' using ($2*1.0E-18):5 via m,n
set label sprintf("SSE=%3.2f",FIT_WSSR) tc rgb "blue" at 0.48,0.36

fit h(x) '1636-54.txt' using ($2*1.0E-18):5 via p,q
set label sprintf("SSE=%3.2f",FIT_WSSR) tc rgb "red" at 0.48,0.32
set label "{/Symbol Dn}=217Hz" at 0.48,0.52
set label "4U 1636-53" at 0.2,0.24

plot \
'1636-54.txt' using ($2*1.0E-18):5 pt 7 ps 2 notitle,\
f(x) lt 1 lw 3 lc rgb "black" title 'phy',\
g(x) lt 2 lw 2 lc rgb "blue" title 'linear',\
h(x) lt 3 lw 2 lc rgb "red" title 'PL'

# XTE J1701-462
unset label
unset xlabel
unset ylabel
set size 1,0.5
set format x "%g"
set format y "%g"
set origin 0.16,0.105

set xrange [0:1]
set yrange [0:0.7]
set xtics 0,0.1,0.9 nomirror
set ytics 0,0.2,0.6 
set key at 0.4,0.55

set xlabel "~M{.8.} (10^{18} g s^{-1})" font ", 30"
set ylabel "{/Symbol d}"  rotate by 0 font ", 30"

d=9.0/7.0
e=10.0/7.0
f=2.0/7.0

f(x)=a*(x**d)-b*(x**e)+c*(x**f)
g(x)=m*x+n
h(x)=p*(x**q)

mass=2.0E+33
radius=1.1E+06
mag_field=1.75E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

fit f(x) 'XTE J1701-462.txt' using ($2*1.0E-18):5 via a,b,c

Small_a=a/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b/a)
H_0=c*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=a_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(b_err/a_err)
H_0_err=c_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.6,0.25
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.6,0.2
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.6,0.15
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.6,0.1

fit g(x) 'XTE J1701-462.txt' using ($2*1.0E-18):5 via m,n
set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.12,0.4 tc rgb "blue"
fit h(x) 'XTE J1701-462.txt' using ($2*1.0E-18):5 via p,q
set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.12,0.35 tc rgb "red"
set label "{/Symbol Dn}=232Hz" at 0.195,0.58

set label "XTE J1701-462" at 0.6,0.3

plot \
'XTE J1701-462.txt' using ($2*1.0E-18):5 pt 7 ps 2 notitle,\
f(x) lt 1 lw 3 lc rgb "black" title 'phy',\
g(x) lt 2 lw 2 lc rgb "blue" title 'linear',\
h(x) lt 3 lw 2 lc rgb "red" title 'PL'

unset multiplot
