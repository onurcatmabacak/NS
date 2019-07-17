set terminal postscript eps enhanced monochrome font ",20"
set out "1608_1.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=4.49754E-12

plot "1608_52.txt" using 1:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle

reset 

set terminal postscript eps enhanced monochrome font ",20"
set out "1608_2.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=4.49754E-12

plot "1608_52.txt" using 2:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle

reset 

set terminal postscript eps enhanced monochrome font ",20"
set out "1636.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=4.02162E-12

plot "1636_54.txt" using 2:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle

reset 

set terminal postscript eps enhanced monochrome font ",20"
set out "1636_.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=4.02162E-12

plot "1636_54.txt" using 1:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle

reset

set terminal postscript eps enhanced monochrome font ",20"
set out "1728.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=4.80204E-12

plot "1728_34.txt" using 2:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle

reset

set terminal postscript eps enhanced monochrome font ",20"
set out "Aql_X_1.eps"
set format x "%g"
set format y "%g"
set key bottom right

f(x)=3.41344E-12

plot "Aql.txt" using 2:5 pt 7 ps 1 notitle,f(x) lt 1 lw 1 notitle
