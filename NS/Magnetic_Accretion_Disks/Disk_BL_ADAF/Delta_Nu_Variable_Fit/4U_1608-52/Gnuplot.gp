set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1608-52_Gaussian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[400:1000]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
#set dummy x

pi=3.1415
A = 8.491885719437078e+07
xc = 4.040102296915450e+02
w = 6.867833299879096e+03
y0 = -9.540238113593336e+03

#Gaussian1
f(x)=y0+A*sqrt(2/pi)/w*exp(-2*((x-xc)/w)**2)
fit f(x) '1608-52_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A,w,xc

set label sprintf("SSR=%3.1f",FIT_WSSR) at 410,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 410,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 410,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 800,350
set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 800,340
set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 800,330
set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 800,320

plot \
'1608-52_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1608-52',\
f(x) lt 2 lw 1 lc rgb "black" title 'Gaussian Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1608-52_Lorentzian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[400:1000]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
#set dummy x

pi=3.1415
A = 2.073891939022858e+08
xc = 4.044249071684674e+02
w = 1.079408345771748e+04
y0 = -1.190615596594718e+04

#Lorentzian
f(x)=y0+2*A/pi*w/(4*(x-xc)**2+w**2)
fit f(x) '1608-52_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A,w,xc

set label sprintf("SSR=%3.1f",FIT_WSSR) at 410,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 410,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 410,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 800,350
set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 800,340
set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 800,330
set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 800,320

plot \
'1608-52_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1608-52',\
f(x) lt 2 lw 1 lc rgb "black" title 'Lorentzian Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1608-52_Gaussian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[400:1000]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
#set dummy x

pi=3.1415
A1 = 2.159945706190917e+05
xc1 = 3.954952792190337e+02
w1 = 8.152595078557613e+02
A2 = 3.906014700548379e+03
xc2 = 7.174730389063956e+02
w2 = 6.392654932153193e+01
y0 = 1.178634562040759e+02

#Gaussian
f(x)=y0+sqrt(2/pi)*A1/w1*exp(-2*(x-xc1)**2/w1**2)+sqrt(2/pi)*A2/w2*exp(-2*(x-xc2)**2/w2**2)
fit f(x) '1608-52_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A1,w1,xc1,A2,w2,xc2

#set label sprintf("SSR=%3.1f",FIT_WSSR) at 410,390
#set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 410,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 410,370
#set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 800,350
#set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 800,340
#set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 800,330
#set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 800,320
#set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 800,310
#set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 800,300
#set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 800,290

plot '4U_1608_52_Gaussian.dat' using 3:2 pt 1 ps 1 lc rgb "red" title 'Generated {/Symbol Dn}',\
'1608-52_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1608-52',\
f(x) lt 2 lw 1 lc rgb "black" title 'Gaussian Fit'

reset
set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1608-52_Lorentzian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics
set xtics
set xrange[400:1000]
set yrange[200:400]
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
#set dummy x

pi=3.1415
A1 = 1.149726930806848e+04
xc1 = 7.170428178716504e+02
w1 = 1.013235781879100e+02
A2 = 9.933802246682977e+04
xc2 = 4.794390344592836e+02
w2 = 4.526155103008670e+02
y0 = 1.827336838061364e+02

#Lorentzian2
f(x)=y0+2*A1/pi*w1/(4*(x-xc1)**2+w1**2)+2*A2/pi*w2/(4*(x-xc2)**2+w2**2)
fit f(x) '1608-52_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 via y0,A1,w1,xc1,A2,w2,xc2

set label sprintf("SSR=%3.1f",FIT_WSSR) at 410,390
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 410,380
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 410,370
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 800,350
set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 800,340
set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 800,330
set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 800,320
set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 800,310
set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 800,300
set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 800,290

plot \
'1608-52_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1608-52',\
f(x) lt 2 lw 1 lc rgb "black" title 'Lorentzian Fit'

