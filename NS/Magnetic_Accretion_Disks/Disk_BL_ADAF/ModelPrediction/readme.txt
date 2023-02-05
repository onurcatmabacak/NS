1- Try to reconstrcut nu1 vs deltanu using delta values from previous analysis

answer 1 : solution changes sign after a unspecific value, it is never one kind of solution but a superposition of roots of the second order equation. 

2- Come up with a similar behaving delta for the model prediction, rescale delta not D_BL to decrease the amount of computation.

3- do not forget : delta = eps * D_BL / 2

4- use all the other folders and what is in it to write two new codes to test 1 and 2

answer 2 : test is done, combined solution works. Everything is awesome.

do not forget to calculate roots as:

a * x**2 + b * x + c = 0
q = -1/2 * [ b + sign(b) * sqrt(b**2 - 4ac) ]
x1 = q  /a
x2 = c / q
