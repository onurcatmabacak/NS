# a vs H_0 1
set terminal postscript eps enhanced monochrome font ", 20"
set out "a_vs_H0_1.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set ylabel "H_0 (km)" font ", 30"
set xrange [-2:30]
set yrange [-0.5:2]
set xtics 0,5,25 mirror
set ytics 0,0.5,1.5 nomirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1608-52 3.6 kpc" at -0.25,1.7

plot '4U_1608_52_3.6_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

# Sample 2 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [-1:20]
set yrange [-0.5:2]
set xtics 0,5,15 mirror
set ytics 0,0.5,1.5 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1608-52 4.22 kpc" at -0.5,1.7

plot '4U_1608_52_4.22_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

# Sample 3 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "a" font ", 30"
set ylabel "H_0 (km)" font ", 30"

set origin 0.15,0.15
set xrange [-0.5:15]
set yrange [-0.5:2]
set xtics 0,2,14 nomirror
set ytics 0,0.5,1.5 nomirror
set mxtics
set mytics 
set key bottom right

set label "4U 1608-52 5.0 kpc" at -0.25,1.7

plot '4U_1608_52_5.0_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

# Sample 4 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xlabel "a" font ", 30"

set origin 0.95,0.15
set xrange [-0.5:8]
set yrange [-0.2:1]
set xtics 0,2,8 nomirror
set ytics 0,0.2,0.8 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1636-54 5.5 kpc" at -0.25,0.82

plot '4U_1636_54_5.5_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

unset multiplot

reset

# a vs H_0 2
set terminal postscript eps enhanced monochrome font ", 20"
set out "a_vs_H0_2.eps"
set size 1.77,1.77
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2

# Sample 1 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.15,0.95

set ylabel "H_0 (km)" font ", 30"
set xrange [-0.5:4.5]
set yrange [-0.2:1]
set xtics 0,1,4 mirror
set ytics 0,0.2,0.8 nomirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1636-54 7.0 kpc" at -0.25,0.9

plot '4U_1636_54_7.0_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

# Sample 2 
unset label
unset xlabel
unset ylabel
unset xtics
unset ytics

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.95,0.95
set xrange [-10:135]
set yrange [-40:20]
set xtics 0,25,125 mirror
set ytics -30,10,10 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1728-34 4.5 kpc" at -5,15

plot '4U_1728_34_4.5_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

unset multiplot
