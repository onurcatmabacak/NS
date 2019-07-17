set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1728-34_Gaussian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics 200,50,400
set xtics 
set xrange[500:950]
set yrange[200:420]
set ytics 200,50,420
set mytics 5
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A = 4.277025249129360e+07 
xc = 6.669911202308085e+02 
w = 4.150924894710807e+03 
y0 = -7.868062898756207e+03

#Gaussian
f(x)=y0+A*sqrt(2/pi)/w*exp(-2*((x-xc)/w)**2)
fit f(x) '1728-34_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A,w,xc

set label sprintf("SSR=%3.1f",FIT_WSSR) at 510,410
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 510,400
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 510,390
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 510,320
set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 510,310
set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 510,300
set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 510,290

plot \
'1728-34_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1728-34',\
f(x) lt 1 lw 3 lc rgb "black" title 'Gaussian Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1728-34_Lorentzian_1.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics 200,50,400
set xtics 
set xrange[500:950]
set yrange[200:450]
set ytics 200,50,450
set mytics 5
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A = 1.051938354149608e+08 
xc = 6.669885150530207e+02
w = 6.545291606589480e+03 
y0 = -9.878378341307163e+03 

#Lorentzian
f(x)=y0+2*A/pi*w/(4*(x-xc)**2+w**2)
fit f(x) '1728-34_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A,w,xc

set label sprintf("SSR=%3.1f",FIT_WSSR) at 510,410
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 510,400
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 510,390
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 510,320
set label sprintf("A=%3.1f\261%3.1f",A,A_err) at 510,310
set label sprintf("w=%3.1f\261%3.1f",w,w_err) at 510,300
set label sprintf("xc=%3.1f\261%3.1f",xc,xc_err) at 510,290

plot \
'1728-34_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1728-34',\
f(x) lt 1 lw 3 lc rgb "black" title 'Lorentzian Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1728-34_Gaussian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics 200,50,400
set xtics
set xrange[500:950]
set yrange[200:420]
set ytics 200,50,420
set mytics 5
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A1 = 1.855371051892497e+07 
xc1 = 6.501312071483153e+02 
w1 = 2.805306705892856e+03 
A2 = 3.843595532021556e+03 
xc2 = 8.225521243149955e+02
w2 = 6.731730114846604e+01 
y0 = -4.923612783963851e+03 

#Gaussian
f(x)=y0+sqrt(2/pi)*A1/w1*exp(-2*(x-xc1)**2/w1**2)+sqrt(2/pi)*A2/w2*exp(-2*(x-xc2)**2/w2**2)
fit f(x) '1728-34_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A1,w1,xc1,A2,w2,xc2

#set label sprintf("SSR=%3.1f",FIT_WSSR) at 510,410
#set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 510,400
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 510,390
#set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 510,320
#set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 510,310
#set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 510,300
#set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 510,290
#set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 510,280
#set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 510,270
#set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 510,260

plot '4U_1728_34_Gaussian.dat' using 3:2 pt 1 ps 1 lc rgb "red" title 'Generated {/Symbol Dn}',\
'1728-34_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1728-34',\
f(x) lt 1 lw 3 lc rgb "black" title 'Gaussian Fit'

reset

set terminal postscript eps enhanced color font 'Courier Bold,18'
set output '4U_1728-34_Lorentzian_2.eps'
#set size 1.5,0.50
set encoding iso_8859_1
set xlabel '{/Symbol n}_1 (Hz)' font 'Courier Bold,18'
set ylabel '{/Symbol Dn} (Hz)' font 'Courier Bold,18'
set ytics 200,50,400
set xtics
set xrange[500:950]
set yrange[200:450]
set ytics 200,50,450
set mytics 5
#set logscale x 10
#set logscale y 10
set mxtics
set mytics 5
set samples 1000000
#set label "." at 0.00275,0.035 font 'Courier Bold,18'
set key top right
set dummy x

pi=3.1415
A1=3.693767511240543e+07
xc1=6.385442711207485e+02
w1=4.181965822033387e+03
A2=6.987785728870787e+03
xc2=8.226819277427415e+02
w2=5.067731481319055e+01
y0=-5.271793886032292e+03

#Lorentzian
f(x)=y0+2*A1/pi*w1/(4*(x-xc1)**2+w1**2)+2*A2/pi*w2/(4*(x-xc2)**2+w2**2)
fit f(x) '1728-34_DNu_Nu1.dat' using 1:2:($3-$4)/2.0 yerrors via y0,A1,w1,xc1,A2,w2,xc2

set label sprintf("SSR=%3.1f",FIT_WSSR) at 510,410
set label sprintf("rms of rez=%3.1f",FIT_STDFIT) at 510,400
set label sprintf("red {/Symbol c}^2=%3.1f",FIT_STDFIT*FIT_STDFIT) at 510,390
set label sprintf("y0=%3.1f\261%3.1f",y0,y0_err) at 510,320
set label sprintf("A1=%3.1f\261%3.1f",A1,A1_err) at 510,310
set label sprintf("w1=%3.1f\261%3.1f",w1,w1_err) at 510,300
set label sprintf("xc1=%3.1f\261%3.1f",xc1,xc1_err) at 510,290
set label sprintf("A2=%3.1f\261%3.1f",A2,A2_err) at 510,280
set label sprintf("w2=%3.1f\261%3.1f",w2,w2_err) at 510,270
set label sprintf("xc2=%3.1f\261%3.1f",xc2,xc2_err) at 510,260

plot \
'1728-34_DNu_Nu1.dat' using 1:2:3:4 with yerrorbar pt 7 ps 1 lc rgb "black" title '4U 1728-34',\
f(x) lt 1 lw 3 lc rgb "black" title 'Lorentzian Fit'

