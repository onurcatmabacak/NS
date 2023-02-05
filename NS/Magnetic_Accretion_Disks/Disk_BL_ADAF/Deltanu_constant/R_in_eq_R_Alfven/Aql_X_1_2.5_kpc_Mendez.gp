set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_1.eps"
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
set xrange [0:0.04]
set yrange [0:0.3]
set xtics 0.01,0.01,0.035
set ytics 0.05,0.05,0.25 nomirror
set key bottom right

mass=2.0E+33
radius=1.3E+06
mag_field=0.17E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.6
D_BL = Alpha_BL * 2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.01,0.12
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.01,0.1
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.01,0.08
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.01,0.06
set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.001,0.28 

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

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
set xrange [0:0.02]
set yrange [0:0.2]
set xtics 0.005,0.005,0.015
set ytics 0.05,0.05,0.15

set key bottom right

mass=3.0E+33
radius=0.8E+06
mag_field=0.14E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=3.44
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.014,0.08
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.014,0.065
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.014,0.05
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.014,0.035
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.0005,0.185 

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

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
set xrange [0:0.022]
set yrange [0:0.2]
set xtics 0.005,0.005,0.02 nomirror
set ytics 0.05,0.05,0.15 nomirror
set origin 0.15,0.15
set key bottom right

mass=3.0E+33
radius=1.1E+06
mag_field=0.33E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=4.4
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.013,0.06
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.013,0.045
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.013,0.03
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.013,0.015
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.001,0.17

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.02]
set yrange [0:0.2]
set xtics 0.005,0.005,0.015 nomirror
set ytics 0.05,0.05,0.15 mirror
set origin 0.95,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30" 

set key bottom right

mass=4.0E+33
radius=1.3E+06
mag_field=0.44E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
D_BL=2.4
Alpha_BL=D_BL/2.0
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 5:8 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.013,0.06
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.013,0.045
set label sprintf("H_0=%3.3f\261%3.2f km",H_0,H_0_err) at 0.013,0.03
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.013,0.015
set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.001,0.17

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle
unset multiplot

reset
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_2.eps"
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
set xrange [0:0.04]
set yrange [0:0.35]
set xtics 0.005,0.005,0.035 mirror
set ytics 0.05,0.05,0.3 nomirror
set key bottom right

a=1.0
b=-1.0

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.018,0.15
set label sprintf("b=%3.2f",a) at 0.025,0.12
set label sprintf("d=%3.2f",b) at 0.025,0.09
set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.001,0.32 

plot "Aql_X_1_2.5_kpc_Mendez_Sample_1.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 2 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.02]
set xtics 0.005,0.005,0.015 mirror
set yrange [0:0.4]
set ytics 0.05,0.05,0.35 mirror
set origin 0.95,0.95

set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.007,0.15
set label sprintf("b=%3.2f",a) at 0.015,0.12
set label sprintf("d=%3.2f",b) at 0.015,0.09
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.0005,0.37 

plot "Aql_X_1_2.5_kpc_Mendez_Sample_2.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 3 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.025]
set xtics 0.005,0.005,0.02 nomirror
set yrange [0:0.6]
set ytics 0.1,0.1,0.5 nomirror
set origin 0.15,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30"
set ylabel "|{/Symbol g}_{/Symbol f}|" font ", 30"

set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.0125,0.15
set label sprintf("b=%3.2f",a) at 0.016,0.12
set label sprintf("d=%3.2f",b) at 0.016,0.08
set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.001,0.5

plot "Aql_X_1_2.5_kpc_Mendez_Sample_3.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.03]
set xtics 0.005,0.005,0.025 nomirror
set yrange [0:0.6]
set ytics 0.1,0.1,0.4 mirror
set origin 0.95,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" font ", 30"
set key bottom right

f(x)=a+b*(x**(-3.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 5:7 via a,b

#set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.01,0.15
set label sprintf("b=%3.2f",a) at 0.022,0.15
set label sprintf("d=%3.2f",b) at 0.022,0.1
set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.001,0.5

plot "Aql_X_1_2.5_kpc_Mendez_Sample_4.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

unset multiplot

reset

set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_3.eps"
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
set xrange [0.28:0.38]
set yrange [0.2:0.3]
set xtics 0.3,0.02,0.36 mirror
set ytics 0.22,0.02,0.28 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.281,0.2925

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 12:7 pt 7 ps 1 notitle

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
set xrange [0.25:0.35]
set yrange [0.18:0.32]
set xtics 0.26,0.02,0.34 mirror
set ytics 0.2,0.02,0.3 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.251,0.31

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 12:7 pt 7 ps 1 notitle

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
set xrange [0.2:0.35]
set yrange [0.2:0.5]
set xtics 0.22,0.02,0.34 nomirror
set ytics 0.25,0.05,0.45 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.201,0.46

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 12:7 pt 7 ps 1 notitle

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
set xrange [0.24:0.36]
set yrange [0.2:0.4]
set xtics 0.26,0.02,0.34 nomirror
set ytics 0.25,0.05,0.35 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.241,0.375

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 12:7 pt 7 ps 1 notitle
unset multiplot

reset

set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_4.eps"
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
set xrange [0.15:0.25]
set yrange [0.2:0.3]
set xtics 0.16,0.02,0.24 mirror
set ytics 0.22,0.02,0.28 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.151,0.29

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 8:7 pt 7 ps 1 notitle

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
set xrange [0.08:0.17]
set yrange [0.18:0.32]
set xtics 0.1,0.02,0.16 mirror
set ytics 0.2,0.02,0.3 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.081,0.305

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 8:7 pt 7 ps 1 notitle

# Sample 3 Gammaphi-Delta r_in
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
set xrange [0.05:0.15]
set yrange [0.2:0.45]
set xtics 0.06,0.02,0.14 nomirror
set ytics 0.25,0.05,0.4 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.051,0.42

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 8:7 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta r_in
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
set xrange [0.05:0.15]
set yrange [0.2:0.4]
set xtics 0.06,0.02,0.14 nomirror
set ytics 0.25,0.05,0.35 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.051,0.375

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 8:7 pt 7 ps 1 notitle
unset multiplot


reset
# Mdot vs R_in / R_ISCO
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_5.eps"
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
set xrange [0:0.05]
set yrange [4.5:7]
set xtics 0.01,0.01,0.04 mirror
set ytics 5,0.5,6.5 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.001,6.75

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 5:13 pt 7 ps 1 notitle

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
set xrange [0:0.02]
set yrange [4.5:7]
set xtics 0.005,0.005,0.015 mirror
set ytics 5,0.5,6.5 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.001,6.8

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 5:13 pt 7 ps 1 notitle

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
set xrange [0:0.03]
set yrange [5:7.5]
set xtics 0.005,0.005,0.025 nomirror
set ytics 5.5,0.5,7 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.001,7.15

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 5:13 pt 7 ps 1 notitle

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
set xrange [0:0.02]
set yrange [4:6.5]
set xtics 0.005,0.005,0.015 nomirror
set ytics 4.5,0.5,6 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.001,6.15

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 5:13 pt 7 ps 1 notitle
unset multiplot

reset
# Delta vs R_in / R_ISCO
set terminal postscript eps enhanced monochrome font ", 20"
set out "Aql_X_1_2.5_kpc_Mendez_6.eps"
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
set xrange [0.15:0.25]
set yrange [4.5:7]
set xtics 0.16,0.02,0.24 mirror
set ytics 5,0.5,6.5 nomirror
set key bottom right

set label "M=1 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.15x10^8 G     {D}_{BL}=5.2" at 0.151,6.8

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_1.dat' using 8:13 pt 7 ps 1 notitle

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
set xrange [0.09:0.18]
set yrange [4.5:6.5]
set xtics 0.1,0.02,0.16 mirror
set ytics 5,0.5,6 mirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=8 km     B=0.88x10^8 G     {D}_{BL}=4" at 0.091,6.3

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_2.dat' using 8:13 pt 7 ps 1 notitle

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
set xrange [0.07:0.15]
set yrange [5:7]
set xtics 0.08,0.02,0.14 nomirror
set ytics 5.5,0.5,6.5 nomirror
set key bottom right

set label "M=1.5 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=11 km     B=0.45x10^8 G     {D}_{BL}=2.75" at 0.071,6.75

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_3.dat' using 8:13 pt 7 ps 1 notitle

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
set xrange [0.07:0.16]
set yrange [4:5.7]
set xtics 0.08,0.02,0.14 nomirror
set ytics 4.5,0.5,5.5 mirror
set key bottom right

set label "M=2 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}     R=13 km     B=0.32x10^8 G     {D}_{BL}=3.2" at 0.071,5.5

plot 'Aql_X_1_2.5_kpc_Mendez_Sample_4.dat' using 8:13 pt 7 ps 1 notitle
unset multiplot
