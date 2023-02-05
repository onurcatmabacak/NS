# Sample 1 Mdot vs Epsilon

set terminal postscript eps enhanced color
set out "Sample.eps"

set xlabel "M (10^{18} g s^{-1}})" font "Courier Bold, 18"
set ylabel "{/Symbol e}" font "Courier Bold, 18" rotate by 0
set xrange [0:1]
set yrange [0:0.1]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

f(x)=a*(x**(2.0/7.0))+exp(b)*(x**(9.0/7.0))-exp(c)*(x**(10.0/7.0))
fit f(x) 'Sample2.dat' using 5:6 via a,b,c

set label sprintf("{/Symbol c}^2=%3.5e",FIT_WSSR) at 0.5,0.08
set label sprintf("a=%3.5e",a) at 0.8,0.07
set label sprintf("b=%3.5e",exp(b)) at 0.8,0.065
set label sprintf("c=%3.5e",-exp(c)) at 0.8,0.06

set label "M:0.3, R:7 km, B:7.92029E+07 G, {/Symbol a}_{BL}:3.9" at 0.4,0.09

plot "Sample2.dat" using 5:6 pt 7 ps 0.3 notitle, f(x) lt 1 lw 2 title 'Gnuplot Fit', "Epsilon_Fit.dat" using 1:3 w l lt 2 lw 5 title 'Fortran Fit'

reset

set terminal postscript eps enhanced color
set out "Test.eps"

set xlabel "M (10^{18} g s^{-1}})" font "Courier Bold, 18"
set ylabel "{/Symbol e}" font "Courier Bold, 18" rotate by 0
set xrange [0:1]
set yrange [0:0.1]
set xtics auto
set ytics auto
set xtics font "Courier Bold, 18"
set ytics font "Courier Bold, 18"
set mxtics 5
set mytics 5
set key bottom right

f(x)=a*(x**(2.0/7.0))+exp(b)*(x**(9.0/7.0))-exp(c)*(x**(10.0/7.0))
fit f(x) 'Sample1.dat' using 5:6 via a,b,c
set label sprintf("{/Symbol c}^2=%3.5e",FIT_WSSR) at 0.5,0.08
set label sprintf("a=%3.5e",a) at 0.8,0.07
set label sprintf("b=%3.5e",exp(b)) at 0.8,0.065
set label sprintf("c=%3.5e",-exp(c)) at 0.8,0.06


g(x)=d*(x**(2.0/7.0))+e*(x**(9.0/7.0))+f*(x**(10.0/7.0))
fit g(x) 'Sample1.dat' using 5:6 via d,e,f
set label sprintf("{/Symbol c}^2=%3.5e",FIT_WSSR) at 0.5,0.055
set label sprintf("d=%3.5e",d) at 0.8,0.05
set label sprintf("e=%3.5e",e) at 0.8,0.045
set label sprintf("f=%3.5e",f) at 0.8,0.04

plot "Sample1.dat" using 5:6 pt 7 ps 0.3 notitle, f(x) lt 1 lw 2 title '1', g(x) lt 2 lw 2title '2'


