# Mdot vs Epsilon

set terminal postscript eps enhanced monochrome
set out "Mdot_vs_Epsilon.eps"

set xlabel "M (10^{18} g s^{-1}})" font "Courier Bold, 18"
set ylabel "{/Symbol e}" font "Courier Bold, 18" rotate by 0
set xrange [0:0.8]
set yrange [0.04:0.1]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right
    
a=1.43094E-01        
b=2.73410E-01   
c=-4.46072E-01

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))+c*(x**(10.0/7.0))
#fit f(x) 'Mdot_vs_Epsilon.dat' using 1:2 via a,b,c
#set label sprintf("{/Symbol c}^2=%3.5e",FIT_WSSR) at 0.5,0.08
#set label sprintf("a=%3.5e",a) at 0.8,0.07
#set label sprintf("b=%3.5e",exp(b)) at 0.8,0.065
#set label sprintf("c=%3.5e",-exp(c)) at 0.8,0.06

set label "a=1.43094E-01" at 0.6,0.08
set label "b=2.73410E-01" at 0.6,0.075
set label "c=-4.46072E-01" at 0.6,0.07
set label "{/Symbol c}^2=1.34521E-01" at 0.6,0.065
set label "M:1.35, R:11.2 km, B:6.81808 10^7 G, {/Symbol a}_{BL}:3.90587" at 0.2,500 font ",12"
set label "f(x)=a x^{2/7}+b x^{9/7}+c x^{10/7}" at 0.37,0.085
set label "." at 0.31,0.0368 font ",26"

plot "Mdot_vs_Epsilon.dat" using 1:2 pt 7 ps 0.3 notitle, f(x) lt 1 lw 2 title 'Fit'

reset

# Mdot vs Nu1

set terminal postscript eps enhanced monochrome
set out "Mdot_vs_Nu1.eps"

set xlabel "M (10^{18} g s^{-1}})" font "Courier Bold, 18"
set ylabel "{/Symbol n}_1" font "Courier Bold, 18" rotate by 0
set xrange [*:*]
set yrange [*:*]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

set label "M:1.35, R:11.2 km, B:6.81808 10^7 G, {/Symbol a}_{BL}:3.90587" at 0.2,500 font ",12"
plot "Mdot_vs_Epsilon.dat" using 1:4 pt 7 ps 1.0 notitle

reset

# Mdot vs DeltaNu

set terminal postscript eps enhanced monochrome
set out "Mdot_vs_DeltaNu.eps"

set xlabel "M (10^{18} g s^{-1}})" font "Courier Bold, 18"
set ylabel "{/Symbol Dn}" font "Courier Bold, 18" rotate by 0
set xrange [*:*]
set yrange [*:*]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

set label "M:1.35, R:11.2 km, B:6.81808 10^7 G, {/Symbol a}_{BL}:3.90587" at 0.2,500 font ",12"
plot "Mdot_vs_Epsilon.dat" using 1:3 pt 7 ps 1.0 notitle

reset

# Nu1 vs DeltaNu

set terminal postscript eps enhanced monochrome
set out "Nu1_vs_DeltaNu.eps"

set xlabel "{/Symbol n}_1" font "Courier Bold, 18"
set ylabel "{/Symbol Dn}" font "Courier Bold, 18" rotate by 0
set xrange [*:*]
set yrange [*:*]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

set label "M:1.35, R:11.2 km, B:6.81808 10^7 G, {/Symbol a}_{BL}:3.90587" at 0.2,500 font ",12"
plot "Mdot_vs_Epsilon.dat" using 4:3 pt 7 ps 1.0 notitle

# Nu1 vs DeltaNu

set terminal postscript eps enhanced monochrome
set out "Epsilon_vs_DeltaNu.eps"

set xlabel "{/Symbol d}" font "Courier Bold, 18"
set ylabel "{/Symbol Dn}" font "Courier Bold, 18" rotate by 0
set xrange [*:*]
set yrange [*:*]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

set label "M:1.35, R:11.2 km, B:6.81808 10^7 G, {/Symbol a}_{BL}:3.90587" at 0.2,500 font ",12"
plot "Mdot_vs_Epsilon.dat" using 6:3 pt 7 ps 0.5 notitle

