set terminal postscript eps color enhanced
set out "pulsar.eps"
set xlabel "P" font "Courier Bold, 20"
set ylabel "P"  rotate by 0 font "Courier Bold, 20"
set xrange [*:*]
set yrange [*:*]
set xtics auto
set ytics auto
set log xy
set format y "10^{%L}"
set format x "10^{%L}"
set key bottom right

plot "pulsar.txt" using 6:9 pt 7 ps 1 title 'title', \
"" using 6:9:2 with labels offset 2, char 2 notitle
