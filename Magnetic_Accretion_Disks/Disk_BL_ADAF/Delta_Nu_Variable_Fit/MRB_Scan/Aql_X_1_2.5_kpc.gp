set terminal postscript eps enhanced monochrome font "Courier Bold, 20"
set out "Aql_X_1_2.5_kpc_Mdot_Epsilon_GammaPhi.eps"
set size 1.9,4.3
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 4,2 

# Sample 1 Mdot-Epsilon
unset label
unset xlabel
unset ylabel
set size 0.8,0.8
set format x "%g"
set format y "%g"
set origin 0.2,3.2

set ylabel "{/Symbol d}"  rotate by 0 font "Courier Bold, 30"
set xrange [0:0.04]
set yrange [0:0.3]
set xtics 0.01,0.01,0.03
set ytics 0.05,0.05,0.25
set key bottom right

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))+c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Sample_1.dat' using 5:8 via a,b,c

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.01,0.08
set label "a=44" at 0.01,0.065
set label "H_0=3.68x10^3 cm" at 0.01,0.05
set label "C=1.2" at 0.01,0.035
set label "M:1.0M_{sun} R:13km B:1.45x10^7G {D}_{BL}:5" at 0.002,0.25
set label "a)" at -0.005,0.35 font "Courier Bold, 40"
set label "b)" at -0.005,-0.43  font "Courier Bold, 40"

plot 'Aql_X_1_2.5_kpc_Sample_1.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 2 Mdot-Epsilon
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 1,3.2
set xrange [0:0.016]
set xtics 0.005,0.005,0.015

set key bottom right

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))+c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Sample_2.dat' using 5:8 via a,b,c

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.004,0.08
set label "a=111" at 0.004,0.065
set label "H_0=2.9x10^3cm" at 0.004,0.05
set label "C=1.05" at 0.004,0.035
set label "M:1.5M_{sun} R:8km B:5.6x10^7G {D}_{BL}:5.68" at 0.001,0.25

plot 'Aql_X_1_2.5_kpc_Sample_2.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 3 Mdot-Epsilon
unset label
unset xlabel
unset ylabel

set ylabel "{/Symbol d}"  rotate by 0 font "Courier Bold, 30"

set size 0.8,0.8
set format x "%g"
set format y "%g"
set xrange [0:0.025]
set yrange [0:0.27]
set xtics 0.005,0.005,0.02
set origin 0.2,1
set key bottom right

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))+c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Sample_3.dat' using 5:8 via a,b,c

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.005,0.08
set label "a=101" at 0.005,0.065
set label "H_0=3.63x10^3cm" at 0.005,0.05
set label "C=1.05" at 0.005,0.035
set label "M:1.5M_{sun} R:11km B:2.53x10^7G {D}_{BL}:4.54" at 0.002,0.25

plot 'Aql_X_1_2.5_kpc_Sample_3.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-Epsilon
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.02]
set yrange [0:0.27]
set xtics 0.005,0.005,0.015
set origin 1,1

set key bottom right

f(x)=a*(x**(2.0/7.0))+b*(x**(9.0/7.0))+c*(x**(10.0/7.0))
fit f(x) 'Aql_X_1_2.5_kpc_Sample_4.dat' using 5:8 via a,b,c

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.006,0.08
set label "a=115" at 0.006,0.065
set label "H_0=1.03x10^2cm" at 0.006,0.05
set label "C=0.96" at 0.006,0.035
set label "M:2M_{sun} R:13km B:1.86x10^7G {D}_{BL}:5" at 0.002,0.25

plot 'Aql_X_1_2.5_kpc_Sample_4.dat' using 5:8 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 1 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set origin 0.2,2.4

set xlabel "~M{.8.} (10^{18} g s^{-1}})" 
set ylabel "|{/Symbol g}_{/Symbol f}|" rotate by 0 font "Courier Bold, 30"
set xrange [0:0.035]
set yrange [0:0.35]
set xtics 0.01,0.01,0.03 nomirror
set ytics 0.05,0.05,0.3 nomirror
set key bottom right

f(x)=a*(x**(3.0/7.0))+b
fit f(x) 'Aql_X_1_2.5_kpc_Sample_1.dat' using 5:7 via a,b

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.01,0.15
set label sprintf("b=%3.2f",a) at 0.01,0.13
set label sprintf("d=%3.2f",b) at 0.01,0.11

plot "Aql_X_1_2.5_kpc_Sample_1.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 2 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.016]
set xtics 0.005,0.005,0.015 nomirror
set yrange [0:0.35]
set ytics 0.05,0.05,0.3 mirror
set origin 1,2.4

set xlabel "~M{.8.} (10^{18} g s^{-1}})"
set key bottom right

f(x)=a*(x**(3.0/7.0))+b
fit f(x) 'Aql_X_1_2.5_kpc_Sample_2.dat' using 5:7 via a,b

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.003,0.14
set label sprintf("b=%3.2f",a) at 0.003,0.12
set label sprintf("d=%3.2f",b) at 0.003,0.1

plot "Aql_X_1_2.5_kpc_Sample_2.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 3 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.025]
set xtics 0.005,0.005,0.02 nomirror
set yrange [0:0.4]
set ytics 0.05,0.05,0.35 nomirror
set origin 0.2,0.2

set xlabel "~M{.8.} (10^{18} g s^{-1}})"
set ylabel "|{/Symbol g}_{/Symbol f}|"  rotate by 0 font "Courier Bold, 30"

set key bottom right

f(x)=a*(x**(3.0/7.0))+b
fit f(x) 'Aql_X_1_2.5_kpc_Sample_3.dat' using 5:7 via a,b

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.004,0.14
set label sprintf("b=%3.2f",a) at 0.004,0.12
set label sprintf("d=%3.2f",b) at 0.004,0.1

plot "Aql_X_1_2.5_kpc_Sample_3.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

# Sample 4 Mdot-GammaPhi
unset label
unset xlabel
unset ylabel

set size 0.8,0.8
set format x "%g"
set format y "%g"

set xrange [0:0.02]
set xtics 0.005,0.005,0.015 nomirror
set yrange [0:0.4]
set ytics 0.05,0.05,0.35 mirror
set origin 1,0.2

set xlabel "~M{.8.} (10^{18} g s^{-1}})"
set key bottom right

f(x)=a*(x**(3.0/7.0))+b
fit f(x) 'Aql_X_1_2.5_kpc_Sample_4.dat' using 5:7 via a,b

set label sprintf("SSE=%3.2f",FIT_WSSR) at 0.004,0.15
set label sprintf("b=%3.2f",a) at 0.004,0.13
set label sprintf("d=%3.2f",b) at 0.004,0.11

plot "Aql_X_1_2.5_kpc_Sample_4.dat" using 5:7 pt 7 ps 1 notitle, f(x) lt 1 lw 2 notitle

unset multiplot

reset

set terminal postscript eps enhanced monochrome font "Courier Bold, 20"
set out "Aql_X_1_2.5_kpc_GammaPhi_Delta.eps"
set size 2.4,2.4
set key bottom
set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set multiplot layout 2,2 

# Sample 1 GammaPhi-Delta
unset label
unset xlabel
unset ylabel
set size 1,1
set format x "%g"
set format y "%g"
set origin 0.2,1.2

set ylabel "|{/Symbol g}_{/Symbol f}|"  rotate by 0 font "Courier Bold, 30"
set xrange [0:0.25]
set yrange [0:0.35]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.05,0.05,0.3 nomirror
set key bottom right

set label "M:1.0M_{sun} R:13km B:1.45x10^7G {D}_{BL}:5" at 0.02,0.3

plot 'Aql_X_1_2.5_kpc_Sample_1.dat' using 8:7 pt 7 ps 1 notitle

# Sample 2 GammaPhi-Delta
unset label
unset xlabel
unset ylabel

set size 1,1
set format x "%g"
set format y "%g"

set origin 1.2,1.2
set xrange [0:0.25]
set yrange [0:0.35]
set xtics 0.05,0.05,0.2 mirror
set ytics 0.05,0.05,0.3 mirror

set key bottom right

set label "M:1.5M_{sun} R:8km B:5.6x10^7G {D}_{BL}:5.68" at 0.02,0.3

plot 'Aql_X_1_2.5_kpc_Sample_2.dat' using 8:7 pt 7 ps 1 notitle

# Sample 3 GammaPhi-Delta
unset label
unset xlabel
unset ylabel

set xlabel "{/Symbol d}" font "Courier Bold, 30"
set ylabel "|{/Symbol g}_{/Symbol f}|"  rotate by 0 font "Courier Bold, 30"

set size 1,1
set format x "%g"
set format y "%g"

set origin 1.2,1.2
set xrange [0:0.25]
set yrange [0:0.4]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.05,0.05,0.35 nomirror
set origin 0.2,0.2
set key bottom right

set label "M:1.5M_{sun} R:11km B:2.53x10^7G {D}_{BL}:4.54" at 0.02,0.33

plot 'Aql_X_1_2.5_kpc_Sample_3.dat' using 8:7 pt 7 ps 1 notitle

# Sample 4 GammaPhi-Delta
unset label
unset xlabel
unset ylabel

set size 1,1
set format x "%g"
set format y "%g"

set xlabel "{/Symbol d}" font "Courier Bold, 30"

set origin 1.2,0.2
set xrange [0:0.25]
set yrange [0:0.4]
set xtics 0.05,0.05,0.2 nomirror
set ytics 0.05,0.05,0.35 mirror
set key bottom right

set label "M:2M_{sun} R:13km B:1.86x10^7G {D}_{BL}:5" at 0.02,0.325

plot 'Aql_X_1_2.5_kpc_Sample_4.dat' using 8:7 pt 7 ps 1 notitle

unset multiplot
