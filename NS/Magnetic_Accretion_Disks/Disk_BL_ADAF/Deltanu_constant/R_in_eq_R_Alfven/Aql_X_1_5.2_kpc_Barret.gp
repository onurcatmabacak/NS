set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_1.eps"
set size 1.77,1.77
set encoding iso_8859_1 
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2 

# Sample 1 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set ylabel "{/Symbol d}" font ", 30"
set xrange [0:0.45]
set yrange [0:0.2]
set xtics 0.1,0.1,0.4
set ytics 0.05,0.05,0.15 nomirror
set key bottom right

mass=2.0E+33
radius=1.3E+06
mag_field=0.76E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=3.46
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.2,0.075
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.2,0.06
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.2,0.045
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.2,0.03
set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.01,0.18

plot 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 2 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [0:0.2]
set yrange [0:0.2]
set xtics 0.05,0.05,0.15
set ytics 0.05,0.05,0.15

set key bottom right

mass=3.0E+33
radius=0.8E+06
mag_field=2.9E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=4.0
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.08,0.075
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.08,0.06
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.08,0.045
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.08,0.03
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.01,0.18

plot 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 3 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30" 
set ylabel "{/Symbol d}" font ", 30"

set size 0.8,0.8
set format x "%g"
set format y "%g"
set xrange [0:0.25]
set yrange [0:0.2]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.05,0.05,0.15 nomirror
set origin 0.15,0.15
set key bottom right

mass=3.0E+33
radius=1.1E+06
mag_field=1.3E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=3.2
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.12,0.075
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.12,0.06
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.12,0.045
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.12,0.03
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.001,0.17

plot 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.25]
set yrange [0:0.2]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.05,0.05,0.15 mirror
set origin 0.95,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30" 

set key bottom right

mass=4.0E+33
radius=1.3E+06
mag_field=0.98E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=3.4
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.1,0.075
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.1,0.06
set label sprintf("H_0=%3.3f\261%3.2f km",H_0,H_0_err) at 0.1,0.045
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.1,0.03
set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.001,0.17

plot 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle
unset multiplot

reset
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_2.eps"
set size 1.77,1.77
set encoding iso_8859_1 
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2 

# Sample 1 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.15,0.95

set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"
set xrange [0:0.5]
set yrange [0:0.5]
set xtics 0.1,0.1,0.4 mirror
set ytics 0.1,0.1,0.4 nomirror
set key bottom right

a=1.0
b=-1.0

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.08,0.15
set label sprintf("b=%3.2f",a) at 0.35,0.15
set label sprintf("d=%3.2f",b) at 0.35,0.1
set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.001,0.45

plot "Aql_X_1_5.2_kpc_Barret_Sample_1.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 2 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.2]
set xtics 0.05,0.05,0.15 mirror
set yrange [0:0.5]
set ytics 0.1,0.1,0.4 mirror
set origin 0.95,0.95

set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.03,0.15
set label sprintf("b=%3.2f",a) at 0.15,0.12
set label sprintf("d=%3.2f",b) at 0.15,0.08
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.001,0.45

plot "Aql_X_1_5.2_kpc_Barret_Sample_2.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 3 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.3]
set xtics 0.05,0.05,0.25 nomirror
set yrange [0:0.6]
set ytics 0.1,0.1,0.5 nomirror
set origin 0.15,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"

set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.05,0.15
set label sprintf("b=%3.2f",a) at 0.21,0.17
set label sprintf("d=%3.2f",b) at 0.21,0.12
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.001,0.5

plot "Aql_X_1_5.2_kpc_Barret_Sample_3.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.4]
set xtics 0.05,0.05,0.35 nomirror
set yrange [0:0.6]
set ytics 0.1,0.1,0.5 mirror
set origin 0.95,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30"
set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.05,0.15
set label sprintf("b=%3.2f",a) at 0.3,0.17
set label sprintf("d=%3.2f",b) at 0.3,0.12
set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.001,0.5

plot "Aql_X_1_5.2_kpc_Barret_Sample_4.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

unset multiplot

reset

set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_3.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1 GammaPhi-Delta r_in
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

#set xlabel "{/Symbol d}" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"
set xrange [0:0.5]
set yrange [0:0.5]
set xtics 0.1,0.1,0.4 mirror
set ytics 0.1,0.1,0.4 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 12:7 pt 7 ps 1 notitle

# Sample 2 Gammaphi-Delta r_in
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

#set xlabel "{/Symbol d}" font ", 30"

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [0:0.5]
set yrange [0:0.5]
set xtics 0.1,0.1,0.4 mirror
set ytics 0.1,0.1,0.4 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 12:7 pt 7 ps 1 notitle

# Sample 3 Gammaphi-Delta r_in
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d} r_{in} (10^6 cm)" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"

set origin 0.15,0.15
set xrange [0:0.5]
set yrange [0:0.5]
set xtics 0.1,0.1,0.4 nomirror
set ytics 0.1,0.1,0.4 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 12:7 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta r_in
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d} r_{in} (10^6 cm)" font ", 30"

set origin 0.95,0.15
set xrange [0:0.5]
set yrange [0:0.5]
set xtics 0.1,0.1,0.4 nomirror
set ytics 0.1,0.1,0.4 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 12:7 pt 7 ps 1 notitle
unset multiplot

reset

set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_4.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1 GammaPhi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

#set xlabel "{/Symbol d}" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"
set xrange [0:0.25]
set yrange [0:0.5]
set xtics 0.05,0.05,0.2 mirror
set ytics 0.1,0.1,0.4 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 8:7 pt 7 ps 1 notitle

# Sample 2 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

#set xlabel "{/Symbol d}" font ", 30"

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [0:0.25]
set yrange [0:0.5]
set xtics 0.05,0.05,0.2 mirror
set ytics 0.1,0.1,0.4 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 8:7 pt 7 ps 1 notitle

# Sample 3 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d}" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"

set origin 0.15,0.15
set xrange [0:0.25]
set yrange [0:0.5]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.1,0.1,0.4 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 8:7 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d}" font ", 30"

set origin 0.95,0.15
set xrange [0:0.25]
set yrange [0:0.5]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.1,0.1,0.4 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.01,0.45

plot 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 8:7 pt 7 ps 1 notitle
unset multiplot


reset
# Mdot vs R_in / R_ISCO
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_5.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set ylabel "R_{in} / R_{ISCO}" font ", 30"
set xrange [0:0.3]
set yrange [6:12]
set xtics 0.05,0.05,0.25 mirror
set ytics 7,1,11 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.002,11.5

plot 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 5:13 pt 7 ps 1 notitle

# Sample 2 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [0:0.12]
set yrange [4:10]
set xtics 0.02,0.02,0.1 mirror
set ytics 5,1,9 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.002,9.5

plot 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 5:13 pt 7 ps 1 notitle

# Sample 3 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30" 
set ylabel "R_{in} / R_{ISCO}" font ", 30"

set origin 0.15,0.15
set xrange [0:0.16]
set yrange [4:10]
set xtics 0.02,0.02,0.14 nomirror
set ytics 5,1,9 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.004,9

plot 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 5:13 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30" 

set origin 0.95,0.15
set xrange [0:0.15]
set yrange [3:9]
set xtics 0.02,0.02,0.14 nomirror
set ytics 4,1,8 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.004,8

plot 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 5:13 pt 7 ps 1 notitle
unset multiplot

reset
# Delta vs R_in / R_ISCO
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_5.2_kpc_Barret_6.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set ylabel "R_{in} / R_{ISCO}" font ", 30"
set xrange [0:0.2]
set yrange [5:12]
set xtics 0.05,0.05,0.15 mirror
set ytics 6,1,11 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.66x10^8 G     {D}_{BL}=3.46" at 0.002,11.5

plot 'Aql_X_1_5.2_kpc_Barret_Sample_1.dat' using 8:13 pt 7 ps 1 notitle

# Sample 2 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [0:0.2]
set yrange [4:10]
set xtics 0.05,0.05,0.15 mirror
set ytics 5,1,9 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=2.5x10^8 G     {D}_{BL}=4.0" at 0.002,9.5

plot 'Aql_X_1_5.2_kpc_Barret_Sample_2.dat' using 8:13 pt 7 ps 1 notitle

# Sample 3 Gammaphi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d}" font ", 30" 
set ylabel "R_{in} / R_{ISCO}" font ", 30"

set origin 0.15,0.15
set xrange [0:0.2]
set yrange [4:10]
set xtics 0.05,0.05,0.15 nomirror
set ytics 5,1,9 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=1.13x10^8 G     {D}_{BL}=3.2" at 0.005,9

plot 'Aql_X_1_5.2_kpc_Barret_Sample_3.dat' using 8:13 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d}" font ", 30" 

set origin 0.95,0.15
set xrange [0:0.2]
set yrange [3:9]
set xtics 0.05,0.05,0.15 nomirror
set ytics 4,1,8 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.85x10^8 G     {D}_{BL}=3.4" at 0.005,8

plot 'Aql_X_1_5.2_kpc_Barret_Sample_4.dat' using 8:13 pt 7 ps 1 notitle
unset multiplot

