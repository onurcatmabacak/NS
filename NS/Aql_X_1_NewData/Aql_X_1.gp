set terminal postscript eps monochrome enhanced
set out "Aql_X_1.eps"
set xlabel "Flux( ergs s^{-1} cm^{-2})" font "Courier Bold, 20"
set ylabel "{/Symbol n}_1"  rotate by 0 font "Courier Bold, 20"
set xrange [1.0E-10:5.0E-09]
set yrange [500:1000]
set xtics auto
set ytics auto
#set log x
#set format y "10^{%L}"
set format x "%.1tx10^{%T}"
set key bottom right

Mass=1.4
Radius=1.0E+06
Magnetic_Field=0.3E+08
Magnetic_Moment=Magnetic_Field*(Radius**3.0)
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
pi=3.1415

Luminosity(x)=4.0*pi*(Distance**2.0)*x
Mdot(x)=(Luminosity(x)*Radius)/(Gravitational_Constant*Mass_Star)
AlfvenRadius(x)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(x))**(-2.0/7.0))*(Magnetic_Moment**(4.0/7.0))
AlfvenFrequency(x)=sqrt(Gravitational_Constant*Mass_Star/(AlfvenRadius(x)**3.0))/(2.0*pi)

a=1.0
b=1.0
c=1.0
d=1.0 
# d is deltanu
e=1.0
# e is D_BL

B(x) = (0.0+100.0)/pi*(atan(x)+pi/2)-100.0
D(x) = (400.0-200.0)/pi*(atan(x)+pi/2)+200.0
E(x) = (10.0-0.1)/pi*(atan(x)+pi/2)+0.1

m(x)=Mdot(x)*1.0E-18
delta(x)=a*(m(x)**(2.0/7.0))+B(b)*(m(x)**(9.0/7.0))+c*(m(x)**(10.0/7.0))
w(x)=D(d)/AlfvenFrequency(x)
y(x)=AlfvenFrequency(x)*(sqrt(2.0*w(x)*(2.0*w(x)-1.5+((1.0-w(x))/(delta(x)*E(e)))))-w(x))

fit y(x) "Aql_X_1_Flux_QPO.dat" using 1:2 via a,b,c,d,e

pr a,B(b),c,D(d),E(e),FIT_WSSR

plot "Aql_X_1_Flux_QPO.dat" using 1:2 pt 7 ps 1 notitle,\
y(x) lt 1 lw 5 lc rgb "red" title 'fit'

