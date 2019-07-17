set terminal postscript eps enhanced color font "Courier Bold, 20"
set out "XTE J1701-462.eps"
set encoding iso_8859_1 
set format x "%g"
set format y "%g"
set xrange [0:1]
set yrange [0:0.7]
set xtics 0,0.1,1
set ytics 0,0.1,0.6
set key at 0.3,0.6

set xlabel "~M{.8.} (10^{18} g s^{-1})" font ", 40"
set ylabel "{/Symbol d}"  rotate by 0 font ", 40"

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

set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.7,0.25
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.7,0.2
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.7,0.15
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.7,0.1

fit g(x) 'XTE J1701-462.txt' using ($2*1.0E-18):5 via m,n
set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.15,0.4 tc rgb "blue"
fit h(x) 'XTE J1701-462.txt' using ($2*1.0E-18):5 via p,q
set label sprintf("SSE=%3.5f",FIT_WSSR) at 0.15,0.35 tc rgb "red"

set label "XTE J1701-462" at 0.7,0.3


plot \
'XTE J1701-462.txt' using ($2*1.0E-18):5 pt 7 ps 2 title '{/Symbol Dn}=280Hz',\
f(x) lt 1 lw 3 lc rgb "black" title 'phy',\
g(x) lt 2 lw 2 lc rgb "blue" title 'linear',\
h(x) lt 3 lw 2 lc rgb "red" title 'PL'

