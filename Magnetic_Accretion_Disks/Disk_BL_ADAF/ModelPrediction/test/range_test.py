import numpy as np

mass = np.arange(0.1,3.1,0.1)
radius = np.arange(0.7,1.6,0.01)
mag_field = np.arange(0.1,10.1,0.1)

va_min = []
va_max = []

for m in mass:
	for r in radius:
		for b in mag_field:

			va_min.append(268.0 * (m**(5.0/7.0)) * (b**(-6.0/7.0)) * (r**(-18.0/7.0)))
			va_max.append(720.0 * (m**(5.0/7.0)) * (b**(-6.0/7.0)) * (r**(-18.0/7.0)))

print 'V_a min and max values for left part'
print np.min(va_min), np.max(va_min)			

print 'V_a min and max values for right part'
print np.min(va_max), np.max(va_max)			

