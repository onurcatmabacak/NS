set terminal postscript eps enhanced monochrome font "Courier Bold, 14"
set out "4U_1608_52_3.6_kpc.eps"
set size 2.7,1.9
set key bottom
#set lmargin 0
#set rmargin 0
#set bmargin 0
#set tmargin 0

set multiplot layout 2,3 

# DeltaNu_vs_Nu1
unset label
unset xlabel
unset ylabel
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set xlabel '{/Symbol n}_1' font 'Courier Bold,18'
set ylabel '{/Symbol Dn}' font 'Courier Bold,18' rotate by 0
set ytics auto 
set xtics auto
set xrange[400:920]
set yrange[0:420]
set key top left

# 'Delta_Nu.dat' using 2:6 pt 7 ps 1 title 'Root -', 
plot 'Delta_Nu.dat' using 2:6 pt 7 ps 1 title 'Root +'

# Mdot-Nu1
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95

set xlabel "~M{.8.} (10^{18} g s^{-1}})" 
set ylabel '{/Symbol n}_1' font 'Courier Bold,18' rotate by 0
set label "M:1.0 R:10 km B: 6.32x10^7 G {/Symbol a}_BL: 9.9" at 0.075,1150 font 'Courier Bold,25'
set ytics auto
set xtics auto
set xrange[0:0.15]
set yrange[400:920]
set key top left

#'Delta_Nu.dat' using 2:4 pt 7 ps 1 title '-', 
plot 'Delta_Nu.dat' using 1:2 pt 7 ps 1 title 'Root +'

# DeltaNu - Nu1 Average
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 1.75,0.95

set xlabel '{/Symbol n}_1' font 'Courier Bold,18'
set ylabel '{/Symbol Dn}' font 'Courier Bold,18' rotate by 0
set ytics auto
set xtics auto
set xrange[400:920]
set yrange[0:400]
set key top left
plot 'Delta_Nu_vs_Nu_1_Average.dat' using 1:3 pt 7 ps 1 title 'Average'


# Mdot-Epsilon
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.15,0.15

set xlabel "~M{.8.} (10^{18} g s^{-1}})" 
set ylabel '{/Symbol e}' font 'Courier Bold,18' rotate by 0
set ytics auto
set xtics auto
set xrange[0:0.5]
set yrange[0:0.04]
set key top left

Mass=1.0
Radius=1.0E+06
Magnetic_Field=0.6319E+08
D_BL=19.8

Nustar=619.0
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
pi=3.1415
Kappa_es=0.4
Speed_of_Light=3.0E+10
Mdot_Edd=1.0E+18

Radius_Alfven(x)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((x)**(-2.0/7.0))*((Magnetic_Field)**(4.0/7.0))*((Radius)**(12.0/7.0))*((Mdot_Edd)**(-2.0/7.0))
Omega_Kepler_rin(x)=sqrt(Gravitational_Constant*Mass_Star/(Radius_Alfven(x)**3.0))
Radius_Sch=2.0*Gravitational_Constant*Mass_Star/(Speed_of_Light**2.0)
Radius_Corotation=(Gravitational_Constant*Mass_Star/((2.0*pi*Nustar)**(2.0)))**(1.0/3.0)

H_SS(x)=(3.0*Kappa_es*Mdot_Edd*x)/(8.0*pi*Speed_of_Light)*(1.0-sqrt(3.0*Radius_Sch/Radius_Alfven(x)))
Epsilon(x)=H_SS(x)/Radius_Alfven(x)

plot 'Delta_Nu.dat' using 1:3 pt 7 ps 1 notitle, Epsilon(x) title 'Teorik Egri'

# Mdot-GammaPhi
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.15

set xlabel '{M}_{dot}' font 'Courier Bold,18'
set ylabel '{/Symbol g}_{/Symbol f}' font 'Courier Bold,18' rotate by 0
set ytics auto
set xtics auto
set xrange[0:0.3]
set yrange[0:0.1]
set key top left
set dummy x

f(x)=a*(x**(3.0/7.0))+b
fit f(x) 'Delta_Nu.dat' using 1:4 via a,b

set label sprintf("{/Symbol c}^2=%3.5f",FIT_WSSR) at 0.1,0.04
set label sprintf("a=%3.5f",a) at 0.1,0.03
set label sprintf("b=%3.5f",-exp(b)) at 0.1,0.02

plot 'Delta_Nu.dat' using 1:4 pt 7 ps 1, f(x) notitle

# Mass-Radius
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 1.75,0.15

set xlabel 'Radius (km)' font 'Courier Bold,18'
set ylabel 'Mass (M_{solar})' font 'Courier Bold,18'
set ytics auto
set xtics auto
set xrange[7:16]
set yrange[0:3]
set key top left

plot 'Mass_vs_Radius.dat' using ($2*1.0E-05):1 pt 7 ps 1 notitle

unset multiplot
