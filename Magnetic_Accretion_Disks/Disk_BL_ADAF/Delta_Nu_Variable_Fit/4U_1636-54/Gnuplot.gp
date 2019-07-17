set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1636-54_Gaussian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[600:1100]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A=1.626936362068560e+04
xc=6.803744020477360e+02
w=1.433975375340228e+02
y0=2.462170905411685e+02

#Gaussian
f(x)=y0+A*sqrt(2/pi)/w*exp(-2*((x-xc)/w)**2)
fit f(x) '1636-54_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A,xc,w

#set label sprintf("SSR=%3.1f",FIT_WSSR) at 610,390
#set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 610,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 610,370
#set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 910,350
#set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 910,340
#set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 910,330
#set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 910,320

plot '4U_1636_54_Gaussian_1.dat' using 3:2 pt 1 ps 1 lc rgb "red" title 'Generated {/Symbol Dn}',\
'1636-54_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1636-54',\
f(x) lt 1 lw 3 lc rgb "black" title 'Gaussian_1 Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1636-54_Lorentzian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[600:1100]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A=3.317021970315855e+04
xc=6.796131819155004e+02
w=1.917214340016956e+02 
y0=2.286797237725680e+02

#Lorentzian
f(x)=y0+2*A/pi*w/(4*(x-xc)**2+w**2)
fit f(x) '1636-54_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A,w,xc

set label sprintf("SSR=%3.1f",FIT_WSSR) at 610,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 610,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 610,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 910,350
set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 910,340
set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 910,330
set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 910,320

plot \
'1636-54_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1636-54',\
f(x) lt 1 lw 3 lc rgb "black" title 'Lorentzian_1 Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1636-54_Gaussian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[600:1100]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415

#Gaussian
A1=1.520162813167712e+04
xc1=6.810574440382873e+02
w1=1.294273702841440e+02
A2=3.765560477144296e+02
xc2=8.469380274981839e+02
w2=2.239863022228313e+01
y0=2.458223935486387e+02

f(x)=y0+sqrt(2/pi)*A1/w1*exp(-2*(x-xc1)**2/w1**2)+sqrt(2/pi)*A2/w2*exp(-2*(x-xc2)**2/w2**2)
fit f(x) '1636-54_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A1,w1,xc1,A2,w2,xc2

set label sprintf("SSR=%3.1f",FIT_WSSR) at 610,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 610,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 610,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 910,350
set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 910,340
set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 910,330
set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 910,320
set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 910,310
set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 910,300
set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 910,290

plot \
'1636-54_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1636-54',\
f(x) lt 1 lw 3 lc rgb "black" title 'Gaussian_2 Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1636-54_Lorentzian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[600:1100]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A1=4.915606660782303e+04
xc1=6.832394673888299e+02
w1=2.581068126726799e+02
A2=1.556125868805255e+03
xc2=7.972422411261796e+02
w2=3.412048356333533e+01
y0=2.150697826702018e+02

#Lorentzian
f(x)=y0+2*A1/pi*w1/(4*(x-xc1)**2+w1**2)+2*A2/pi*w2/(4*(x-xc2)**2+w2**2)
fit f(x) '1636-54_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A1,w1,xc1,A2,w2,xc2

set label sprintf("SSR=%3.1f",FIT_WSSR) at 610,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 610,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 610,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 910,350
set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 910,340
set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 910,330
set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 910,320
set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 910,310
set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 910,300
set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 910,290

plot \
'1636-54_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1636-54',\
f(x) lt 1 lw 3 lc rgb "black" title 'Lorentzian_2 Fit'
