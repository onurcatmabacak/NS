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
set xrange [-2:50]
set yrange [-0.5:2]
set xtics 0,5,45 mirror
set ytics 0,0.5,1.5 nomirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1608-52 3.6 kpc" at 0.0,1.7

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
set xrange [-2:35]
set yrange [-0.5:2]
set xtics 0,5,30 mirror
set ytics 0,0.5,1.5 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1608-52 4.22 kpc" at 0.0,1.7

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
set xrange [-2:25]
set yrange [-0.5:2]
set xtics 0,5,20 nomirror
set ytics 0,0.5,1.5 nomirror
set mxtics
set mytics 
set key bottom right

set label "4U 1608-52 5.0 kpc" at 0.0,1.7

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
set xrange [-2:10]
set yrange [-0.2:1]
set xtics 0,2,8 nomirror
set ytics 0,0.2,0.8 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1636-54 5.5 kpc" at -0.18,0.82

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
set xrange [-0.5:6]
set yrange [-0.2:1]
set xtics 0,1,5 mirror
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
set xrange [-2:50]
set yrange [-20:15]
set xtics 0,5,45 mirror
set ytics -15,5,10 mirror
set mxtics 
set mytics 
set key bottom right

set label "4U 1728-34 4.5 kpc" at 0.0,12

plot '4U_1728_34_4.5_kpc.dat' using 11:($12/1e5) pt 7 ps 1 notitle

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
set xrange [-5:130]
set yrange [-1:4]
set xtics 0,20,120 nomirror
set ytics 0.0,1,3 nomirror
set mxtics
set mytics 
set key bottom right

set label "Aql X-1 2.5 kpc Barret" at -0.5,3.25

plot 'Aql_X_1_2.5_kpc_Barret.dat' using 11:($12/1e5) pt 7 ps 1 notitle

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
set xrange [-5:55]
set yrange [-1:2]
set xtics 0,5,50 nomirror
set ytics -1,0.5,1 mirror
set mxtics 
set mytics 
set key bottom right

set label "Aql X-1 5.2 kpc Barret" at -0.225,1.6

plot 'Aql_X_1_5.2_kpc_Barret.dat' using 11:($12/1e5) pt 7 ps 1 notitle

unset multiplot

reset

# a vs H_0 3
set terminal postscript eps enhanced monochrome font ", 20"
set out "a_vs_H0_3.eps"
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

set xlabel "a" font ", 30"
set ylabel "H_0 (km)" font ", 30"
set xrange [-0.5:10]
set yrange [-2:3.5]
set xtics 0,1,9 mirror
set ytics -1.5,0.5,3.0 nomirror
set mxtics 
set mytics 
set key bottom right

set label "Aql X-1 2.5 kpc Mendez" at -0.25,3

plot 'Aql_X_1_2.5_kpc_Mendez.dat' using 11:($12/1e5) pt 7 ps 1 notitle

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

set xlabel "a" font ", 30"
set xrange [-2:16]
set yrange [-3.5:5]
set xtics 0,2,14 mirror
set ytics -3,1.0,4 mirror
set mxtics 
set mytics 
set key bottom right

set label "Aql X-1 5.2 kpc Mendez" at -1,4.25

plot 'Aql_X_1_5.2_kpc_Mendez.dat' using 11:($12/1e5) pt 7 ps 1 notitle

unset multiplot

