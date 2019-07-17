set terminal postscript eps enhanced monochrome font "Courier Bold, 20"
set out "ParallelTracks.eps"
unset key 
set size 0.82,2.55
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

Mass=2.8E+33
Radius=1.0E+06
pi=3.1415
Kiloparsec=3.086E+21
GravitationalConstant=6.67E-08

set multiplot layout 1,3

# 4U 1608-52
unset label
unset xlabel
unset ylabel
set ylabel "{/Symbol n}_1 (kHz)" font " ,30"
#set xlabel "~M{.8.} (10^{18} g/s)" 
set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.12,1.75
pi=3.1415
Kiloparsec=3.086E+21
Distance=4.22*Kiloparsec
xmin=0.0
xmax=0.18
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.4:0.95]
set xtics 0.05 nomirror
set x2tics auto nomirror
set ytics 0.4,0.1,0.95
set mxtics
set mytics
set mx2tics
set label "(a)" at 0.15,0.5 font " ,30"
set label "(b)" at 0.15,-0.2 font " ,30"
set label "(c)" at 0.15,-0.85 font " ,30"
set label "4U 1608-52" at 0.002,0.910
#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}  R=10 km  B=1.0x10^8 G" at 0.01,0.900
plot "4U_1608_52_Flux_QPO.dat" using ($4*1.0E-18):($5/1000.0) axes x1y1 pt 7 ps 1 title '4U 1608-52', \
" " using ($2*1.0E+07):($5/1000.0) axes x2y1 pt 7 ps 0.7 notitle

# 4U 1636-54
unset label
unset xlabel
unset ylabel
unset x2label
set ylabel "{/Symbol n}_1 (kHz)" font " ,30"
#set xlabel "~M{.8.} (10^{18} g/s)" 
#set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.12,0.95
pi=3.1415
Kiloparsec=3.086E+21
Distance=5.5*Kiloparsec
xmin=0.0
xmax=0.25
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.6:1.1]
set xtics auto nomirror
set x2tics auto nomirror
set ytics 0.1
set mxtics
set mytics
set mx2tics
set label "4U 1636-54" at 0.002,1.070
#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}  R=10 km  B=1.0x10^8 G" at 0.01,1.050
plot "4U_1636_54_Flux_QPO.dat" using ($4*1.0E-18):($5/1000.0) axes x1y1 pt 7 ps 1 title '4U 1636-54', \
" " using ($2*1.0E+07):($5/1000.0) axes x2y1 pt 7 ps 0.7 notitle

# Aql X-1 Barret
unset label
unset xlabel
unset ylabel
unset x2label
set ylabel "{/Symbol n}_1 (kHz)" font " ,30"
set xlabel "~M{.8.} (10^{18} g/s)" 
#set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.12,0.15
pi=3.1415
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
xmin=0.0
xmax=0.03
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.550:0.920]
set xtics 0.01 nomirror
set x2tics auto nomirror 
set ytics 0.5,0.100,0.95
set mxtics
set mytics
set mx2tics
set label "Aql X-1" at 0.0005,0.890
#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}   R=10 km   B=0.4x10^8 G" at 0.001,0.970
plot "Aql_X_1_Flux_QPO_Barret.dat" using ($4*1.0E-18):($5/1000.0) axes x1y1 pt 7 ps 1 title 'Aql X-1', \
" " using ($2*1.0E+07):($5/1000.0) axes x2y1 pt 7 ps 0.7 notitle

unset multiplot

reset
set terminal postscript eps enhanced monochrome font "Courier Bold, 10"
set out "Aql_X_1_Mendez.eps"
unset key 
Mass=2.8E+33
Radius=1.0E+06
pi=3.1415
Kiloparsec=3.086E+21
GravitationalConstant=6.67E-08
set size 0.61,0.505

set multiplot layout 1,1

# Aql X-1 Mendez
set ylabel "{/Symbol n}_1 (kHz)" font " ,20"
set xlabel "~M{.8.} (10^{18} g/s)"
set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.6,0.5
set origin 0.0,0
set format x "%g"
set format y "%g"
pi=3.1415
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
xmin=0.005
xmax=0.015
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.740:0.950]
set xtics 0.005 nomirror
set x2tics auto nomirror 
set ytics 0.7,0.050,0.950
set mxtics
set mytics
set mx2tics
set label "Aql X-1" at 0.0052,0.940
#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}   R=10 km   B=0.3x10^8 G" at 0.001,0.970
plot "Aql_X_1_Flux_QPO_Mendez.dat" using ($4*1.0E-18):($5/1000.0) axes x1y1 pt 7 ps 1 title 'Aql X-1', \
" " using ($2*1.0E+07):($5/1000.0) axes x2y1 pt 7 ps 0.7 notitle

unset multiplot
reset

set terminal postscript eps enhanced monochrome font "Courier Bold, 20"
set out "Mdot_vs_Delta.eps"
unset key 
set size 0.84,2.55
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0
set encoding iso_8859_1

set multiplot layout 1,3

# 4U 1608-52
unset label
unset xlabel
unset ylabel
set ylabel "{/Symbol d}" font " ,30"
#set xlabel "~M{.8.} (10^{18} g/s)" 
set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.15,1.75
set fit errorvariables

mass=2.8E+33
radius=1.0E+06
mag_field=1.0E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=3.08468E+00
D_BL=Alpha_BL*2.0
pi=3.1415
Kiloparsec=3.086E+21
Distance=4.22*Kiloparsec
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) "4U_1608_52_4.22kpc_Delta.dat" using ($1*1.0E-18):3 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.1,0.1
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.1,0.08
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.1,0.06
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.1,0.04

xmin=0.0
xmax=0.35
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.0:0.35]
set xtics 0.1 nomirror
set x2tics auto nomirror
set ytics 0.0,0.05,0.35
set mxtics
set mytics
set mx2tics
set label "a)" at -0.08,0.4 font " ,30"
set label "b)" at -0.08,-0.04 font " ,30"
set label "c)" at -0.08,-0.47 font " ,30"
set label "4U 1608-52" at 0.002,0.33

#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}  R=10 km  B=1.0x10^8 G" at 0.01,0.33
plot "4U_1608_52_4.22kpc_Delta.dat" using ($1*1.0E-18):3 axes x1y1 pt 7 ps 1 title '4U 1608-52', \
" " using ($2*1.0E+07):3 axes x2y1 pt 7 ps 0.7 notitle,\
f(x) lt 1 lw 2 

# 4U 1636-54
unset label
unset xlabel
unset ylabel
unset x2label
set ylabel "{/Symbol d}" font " ,30"
#set xlabel "~M{.8.} (10^{18} g/s)" 
#set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.15,0.95
set fit errorvariables

mass=2.8E+33
radius=1.0E+06
mag_field=1.0E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.71773E+00
D_BL=Alpha_BL*2.0
pi=3.1415
Kiloparsec=3.086E+21
Distance=5.5*Kiloparsec
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) "4U_1636_54_5.5kpc_Delta.dat" using ($1*1.0E-18):3 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.1,0.1
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.1,0.08
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.1,0.06
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.1,0.04

xmin=0.0
xmax=0.4
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.0:0.3]
set xtics 0.1 nomirror
set x2tics auto nomirror
set ytics 0.05
set mxtics
set mytics
set mx2tics
set label "4U 1636-54" at 0.002,0.28

#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}  R=10 km  B=1.0x10^8 G" at 0.01,1.050
plot "4U_1636_54_5.5kpc_Delta.dat" using ($1*1.0E-18):3 axes x1y1 pt 7 ps 1 title '4U 1636-54', \
" " using ($2*1.0E+07):3 axes x2y1 pt 7 ps 0.7 notitle,\
f(x) lt 1 lw 2 

# Aql X-1 Barret
unset label
unset xlabel
unset ylabel
unset x2label
set ylabel "{/Symbol d}" font " ,30"
set xlabel "~M{.8.} (10^{18} g/s)" 
#set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.65,0.65
set format x "%g"
set format y "%g"
set origin 0.15,0.15
set fit errorvariables

mass=2.8E+33
radius=1.0E+06
mag_field=0.4E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.55064E+00
D_BL=Alpha_BL*2.0
pi=3.1415
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) "Aql_X_1_Barret_2.5kpc_Delta.dat" using ($1*1.0E-18):3 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.02,0.1
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.02,0.08
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.02,0.06
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.02,0.04

xmin=0.0
xmax=0.08
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.0:0.3]
set xtics 0.02 nomirror
set x2tics 5 nomirror 
set ytics 0.05
set mxtics
set mytics
set mx2tics
set label "Aql X-1" at 0.0005,0.28

#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}   R=10 km   B=0.4x10^8 G" at 0.001,0.970
plot "Aql_X_1_Barret_2.5kpc_Delta.dat" using ($1*1.0E-18):3 axes x1y1 pt 7 ps 1 title 'Aql X-1', \
" " using ($2*1.0E+07):3 axes x2y1 pt 7 ps 0.7 notitle,\
f(x) lt 1 lw 2 

unset multiplot

reset
set terminal postscript eps enhanced monochrome font "Courier Bold, 10"
set out "Aql_X_1_Mendez_Mdot_vs_Delta.eps"
unset key 
set size 0.61,0.505

set multiplot layout 1,1
# Aql X-1 Mendez
set ylabel "{/Symbol d}" font " ,20"
set xlabel "~M{.8.} (10^{18} g/s)"
set x2label "Flux (10^{-9} erg cm^{-2} s^{-1})" 
#set size square
set size 0.6,0.5
set origin 0,0
set format x "%g"
set format y "%g"
set fit errorvariables

mass=2.8E+33
radius=1.0E+06
mag_field=0.3E+08
mag_moment=mag_field*(radius**3.0)
mdot_edd=1.0E+18
Alpha_BL=2.50397E+00
D_BL=Alpha_BL*2.0
pi=3.1415
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
Gravitational_Constant=6.67E-08
speed_of_light=3.0E+10
k_es=0.4

Alfven_Radius_18=((Gravitational_Constant*mass)**(-1.0/7.0))*(mdot_edd**(-2.0/7.0))*(mag_moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*mass/(speed_of_light**2.0)
Capital_A=(3.0*k_es*mdot_edd)/(8.0*pi*speed_of_light*Alfven_Radius_18)

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))-c*(x**(10.0/7.0))
fit f(x) "Aql_X_1_Mendez_2.5kpc_Delta.dat" using ($1*1.0E-18):3 via a,b,c

Small_a=b/(Capital_A*Alpha_BL)
amec=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c/b)
H_0=a*Alfven_Radius_18/Alpha_BL*1.0E-05

Small_a_err=b_err/(Capital_A*Alpha_BL)
amec_err=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(c_err/b_err)
H_0_err=a_err*Alfven_Radius_18/Alpha_BL*1.0E-05

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.015,0.1
set label sprintf("a=%3.2f\261%3.2f",Small_a,Small_a_err) at 0.015,0.08
set label sprintf("H_0=%3.2f\261%3.2f km",H_0,H_0_err) at 0.015,0.06
set label sprintf("C=%3.2f\261%3.2f",amec,amec_err) at 0.015,0.04

xmin=0.0
xmax=0.04
conversion=(4.0*pi*(Distance**2.0)*1.0E+04)/(6.67E-08*2.8E+33*1.0E+25)
set xrange[xmin:xmax]
set x2range[xmin/conversion:xmax/conversion]
set yrange [0.0:0.3]
set xtics 0.01 nomirror
set x2tics auto nomirror 
set ytics 0.05
set mxtics
set mytics
set mx2tics
set label "Aql X-1" at 0.0052,0.28

#set label "M=1.4 M_{{/=12 O}&{/*-.4 O}{/=12 \267}}   R=10 km   B=0.3x10^8 G" at 0.001,0.970
plot "Aql_X_1_Mendez_2.5kpc_Delta.dat" using ($1*1.0E-18):3 axes x1y1 pt 7 ps 1 title 'Aql X-1', \
" " using ($2*1.0E+07):3 axes x2y1 pt 7 ps 0.7 notitle,\
f(x) lt 1 lw 2 
unset multiplot
