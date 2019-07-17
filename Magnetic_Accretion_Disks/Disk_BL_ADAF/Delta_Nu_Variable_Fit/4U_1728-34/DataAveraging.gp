set terminal postscript eps enhanced monochrome font 'Courier Bold,18'
set output 'DataAveraging_Mdot_Epsilon.eps'
#set size 1.5,0.50
set xlabel 'M (10^{18} g s^{-1})' font 'Courier Bold,18'
set ylabel '{/Symbol e}' rotate by 0 font 'Courier Bold,18'
set ytics
set xtics
set xrange[0:0.8]
set yrange[0:0.1]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics
#set samples 1000000
set key top right
set dummy x

f(x)=a*(x**(2.0/7.0))+exp(b)*(x**(9.0/7.0))-exp(c)*(x**(10.0/7.0))
fit f(x) 'DataAveraging.dat' using 1:3 via a,b,c

set label "." at 0.302,-0.0085 font 'Courier Bold,20'
set label sprintf("{/Symbol c}^2=%3.5e",FIT_STDFIT) at 0.6,0.09
set label sprintf("a=%3.5f",a) at 0.6,0.085
set label sprintf("b=%3.5f",exp(b)) at 0.6,0.08
set label sprintf("c=%3.5f",-exp(c)) at 0.6,0.075

show var FIT

plot 'DataAveraging.dat' using 1:3 pt 7 ps 1 notitle, f(x) lt 1 lw 2 title 'Fit'

reset

set terminal postscript eps enhanced monochrome
set output 'DataAveraging_Mdot_AverageEpsilon.eps'
#set size 1.5,0.50
set xlabel 'M (10^{18} g s^{-1})' font 'Courier Bold,18'
set ylabel '{/Symbol e}' rotate by 0 font 'Courier Bold,18'
set ytics
set xtics
set xrange[0:0.8]
set yrange[0:0.1]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics
#set samples 1000000
set key top right
set dummy x

f(x)=a*(x**(2.0/7.0))+exp(b)*(x**(9.0/7.0))-exp(c)*(x**(10.0/7.0))
fit f(x) 'DataAveraging.dat' using 1:2 via a,b,c

set label "." at 0.302,-0.0085 font 'Courier Bold,20'
set label sprintf("{/Symbol c}^2=%3.5e",FIT_STDFIT) at 0.6,0.09
set label sprintf("a=%3.5f",a) at 0.6,0.085
set label sprintf("b=%3.5f",exp(b)) at 0.6,0.08
set label sprintf("c=%3.5f",-exp(c)) at 0.6,0.075

show var FIT

plot 'DataAveraging.dat' using 1:2 pt 7 ps 1 notitle, f(x) lt 1 lw 2 title 'Fit'

reset

set terminal postscript eps enhanced monochrome
set output 'DataAveraging_Nu1_DeltaNu.eps'
#set size 1.5,0.50
set xlabel '{/Symbol n}_1' font 'Courier Bold,18'
set ylabel '{/Symbol Dn}' rotate by 0 font 'Courier Bold,18'
set ytics
set xtics
set xrange[*:*]
set yrange[*:*]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics
#set samples 1000000
set key top right
set dummy x

plot 'DataAveraging.dat' using 5:4 pt 7 ps 1 notitle

reset

set terminal postscript eps enhanced monochrome
set output 'DataAveraging_Mdot_DeltaNu.eps'
#set size 1.5,0.50
set xlabel 'M (10^{18} g s^{-1})' font 'Courier Bold,18'
set ylabel '{/Symbol Dn}' rotate by 0 font 'Courier Bold,18'
set ytics
set xtics
set xrange[*:*]
set yrange[*:*]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics
#set samples 1000000
set key top right
set dummy x

plot 'DataAveraging.dat' using 1:4 pt 7 ps 1 notitle

reset

set terminal postscript eps enhanced monochrome
set output 'DataAveraging_Mdot_Nu1.eps'
#set size 1.5,0.50
set xlabel 'M (10^{18} g s^{-1})' font 'Courier Bold,18'
set ylabel '{/Symbol n}_1' rotate by 0 font 'Courier Bold,18'
set ytics
set xtics
set xrange[*:*]
set yrange[*:*]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics
#set samples 1000000
set key top right
set dummy x

plot 'DataAveraging.dat' using 1:5 pt 7 ps 1 notitle
