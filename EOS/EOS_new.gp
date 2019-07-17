set terminal postscript eps enhanced color
set out "EOS_mass.eps"

set xlabel 'Compactness'
set ylabel 'M (M_{solar})'
set xrange [0:2.5]
set yrange [0:3]
set xtics auto
set ytics auto
set mxtics 5
set mytics 5
set key top right

set dummy x
C_1=1.08
M_1(x)=((x/10.0)**(3.0))*((C_1)**(-2.0))*(0.619**2.0)
C_2=1.15
M_2(x)=((x/10.0)**(3.0))*((C_2)**(-2.0))*(0.619**2.0)

set label "AP4" at 9.95,2.25 font ",6"
set label "AP3" at 10.55,2.4 font ",6"
set label "BSk19" at 8.45,1.85 font ",6"
set label "BSk20" at 9.65,2.17 font ",6"
set label "BSk21" at 10.2,2.3 font ",6"
set label "ENG" at 10.2,2.25 font ",6"
set label "FPS" at 9.1,1.8 font ",6"
set label "FSU" at 10.75,1.72 font ",6"
set label "GM3" at 10.7,1.57 font ",6"
set label "GS1" at 8.1,1.38 font ",6"
set label "MPA1" at 11.1,2.47 font ",6"
set label "MS0" at 14.6,2.5 font ",6"
set label "MS1" at 11.5,1.81 font ",6"
set label "MS2" at 14.2,2.4 font ",6"
set label "PAL1" at 11.35,2.38 font ",6"
set label "PAL6" at 9.02,1.48 font ",6"
set label "PCL2" at 9.9,1.51 font ",6"
set label "PS" at 11.27,1.75 font ",6"
set label "SLy4" at 9.3,2.05 font ",6"
set label "SQM1" at 8.3,1.56 font ",6"
set label "SQM3" at 10.3,1.94 font ",6"
set label "WFF1" at 9.3,2.13 font ",6"
set label "WFF2" at 9.68,2.22 font ",6"
set label "WFF3" at 9.3,1.9 font ",6"
set label "Causality" at 8,2.5 font ",10"

plot \
"AP4_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"AP3_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"BSk19_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"BSk20_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"BSk21_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"ENG_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"FPS_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"FSU_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"GM3_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"GS1_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"MPA1_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"MS0_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"MS1_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"MS2_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"PAL1_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"PAL6_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"PCL2_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"PS_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"SLy4_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"SQM1_new.dat" using 3:2 w l lc rgb 'green' notitle, \
"SQM3_new.dat" using 3:2 w l lc rgb 'green' notitle, \
"WFF1_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"WFF2_new.dat" using 3:2 w l lc rgb 'red' notitle, \
"WFF3_new.dat" using 3:2 w l lc rgb 'blue' notitle, \
"Causality_new.dat" using 1:2 w l lc rgb 'black' notitle, \
M_1(x) lc rgb 'black' title "Hadronic", M_2(x) lc rgb 'black' title "Strange"

reset

set terminal postscript eps enhanced color
set out "EOS_radius.eps"

set xlabel 'Compactness'
set ylabel 'R (10 km)'
set xrange [0:2.5]
set yrange [0.7:1.6]
set xtics auto
set ytics auto
set mxtics 5
set mytics 5
set key top right

set dummy x
C_1=1.08
M_1(x)=((x/10.0)**(3.0))*((C_1)**(-2.0))*(0.619**2.0)
C_2=1.15
M_2(x)=((x/10.0)**(3.0))*((C_2)**(-2.0))*(0.619**2.0)

set label "AP4" at 9.95,2.25 font ",6"
set label "AP3" at 10.55,2.4 font ",6"
set label "BSk19" at 8.45,1.85 font ",6"
set label "BSk20" at 9.65,2.17 font ",6"
set label "BSk21" at 10.2,2.3 font ",6"
set label "ENG" at 10.2,2.25 font ",6"
set label "FPS" at 9.1,1.8 font ",6"
set label "FSU" at 10.75,1.72 font ",6"
set label "GM3" at 10.7,1.57 font ",6"
set label "GS1" at 8.1,1.38 font ",6"
set label "MPA1" at 11.1,2.47 font ",6"
set label "MS0" at 14.6,2.5 font ",6"
set label "MS1" at 11.5,1.81 font ",6"
set label "MS2" at 14.2,2.4 font ",6"
set label "PAL1" at 11.35,2.38 font ",6"
set label "PAL6" at 9.02,1.48 font ",6"
set label "PCL2" at 9.9,1.51 font ",6"
set label "PS" at 11.27,1.75 font ",6"
set label "SLy4" at 9.3,2.05 font ",6"
set label "SQM1" at 8.3,1.56 font ",6"
set label "SQM3" at 10.3,1.94 font ",6"
set label "WFF1" at 9.3,2.13 font ",6"
set label "WFF2" at 9.68,2.22 font ",6"
set label "WFF3" at 9.3,1.9 font ",6"
set label "Causality" at 8,2.5 font ",10"

plot \
"AP4_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"AP3_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"BSk19_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"BSk20_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"BSk21_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"ENG_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"FPS_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"FSU_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"GM3_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"GS1_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"MPA1_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"MS0_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"MS1_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"MS2_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"PAL1_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"PAL6_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"PCL2_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"PS_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"SLy4_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"SQM1_new.dat" using 3:1 w l lc rgb 'green' notitle, \
"SQM3_new.dat" using 3:1 w l lc rgb 'green' notitle, \
"WFF1_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"WFF2_new.dat" using 3:1 w l lc rgb 'red' notitle, \
"WFF3_new.dat" using 3:1 w l lc rgb 'blue' notitle, \
"Causality_new.dat" using 1:2 w l lc rgb 'black' notitle, \
M_1(x) lc rgb 'black' title "Hadronic", M_2(x) lc rgb 'black' title "Strange"

