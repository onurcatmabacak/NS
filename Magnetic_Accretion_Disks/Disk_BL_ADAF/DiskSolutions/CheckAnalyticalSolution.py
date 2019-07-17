#!/usr/bin/python3
import numpy as np
import math
import scipy

mass_solar = 2e33
grav_cons = 6.67e-8
light_speed = 3e10
mdot_t = 1e18
rad_cons = 7.56e-15
k_es = 0.4
c_sb = 5.67e-5
mass = 1.4 * mass_solar
radius = 1e6
#mag_field = 1e8
#mdot = 0.1
#i= input("Enter an integer")
#mass = float(i) * mass_solar / 100.0
filename = 'SODE.txt'
result = open(filename,'w')

#for radius in range(700,1601):
# radius = radius*1e3
for mag_field in range(1,101):
  mag_field = mag_field*1e7
  for mdot in range(1,1001):
   mdot = mdot/1e3
   for deltanu in range(200,401):
    for b_0 in range(1,11): 
     b_0 = b_0/10.0
     for d_bl in range(1,51):
      d_bl = d_bl/10.0
 
      r_a = pow((grav_cons*mass),(-1.0/7.0))*pow(mdot_t,(-2.0/7.0))*pow(mag_field,(4.0/7.0))*pow(radius,(12.0/7.0))
      a = 12.0
      b = 3.0 - ((pow((k_es*c_sb*mdot_t*pow(mdot,(12.0/7.0))),2))/(pow((math.pi*rad_cons*light_speed*math.sqrt(r_a)),2)))
      c = -3.0*d_bl*(b -3.0)
      constant_1 = 1.0 - ((2.0*math.pi*deltanu*pow(r_a,1.5)*pow(mdot,(-3.0/7.0))) / (math.sqrt(grav_cons*mass)))
      d = (12.0*pow(b_0,4)*pow(d_bl,2)) / (pow(constant_1,2))

      delta_0 = pow(b,2) - (3.0*a*c)
      delta_1 = (2.0*pow(b,3)) - (9.0*a*b*c) + (27.0*pow(a,2)*d)
      delta_2 = pow(delta_1,2)-4.0*pow(delta_0,3)
      constant_2 = (3.0*math.sqrt(grav_cons*mass)*rad_cons*light_speed)/(4.0*k_es*pow(c_sb,2)*pow(r_a,1.5))
     
      if delta_2 > 0.0:
       if (math.sqrt(delta_2)+delta_1) > 0.0: 
        solution_1 = pow((0.5*(delta_1+math.sqrt(delta_2))),(1.0/3.0))
        temperature_1 = pow((constant_2*solution_1),(1.0/4.0))
        result.write('%12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e \n' % (mass,radius,mag_field,mdot*mdot_t,deltanu,b_0,d_bl,temperature_1))
      
      if delta_2 > 0.0:
       if (delta_1-math.sqrt(delta_2)) > 0.0:
        solution_2 = pow(0.5*(delta_1-math.sqrt(delta_2)),(1.0/3.0))
        temperature_2 = pow((constant_2*solution_2),0.25)
        result.write('%12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e \n' % (mass,radius,mag_field,mdot*mdot_t,deltanu,b_0,d_bl,temperature_2))

result.close()
