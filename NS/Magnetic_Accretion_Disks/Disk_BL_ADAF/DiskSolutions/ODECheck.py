#!/usr/bin/python3
import math

mass_solar = 2.0e+33
grav_cons = 6.67e-8
c_sb = 5.67e-5  
light_speed = 3e10
rad_cons = 7.56e-15
k_es = 0.4

i = input("Enter an integer")
mass = float(i) * mass_solar / 100.0

filename = 'ODECheck_'+str(i)+'.txt' 
result = open(filename,'w')

#maybe we can try 1.4 solar mass 10 km 1e8 G magnetic field and 1e17 g/s mass acctretion rate
#canonical values colud be nice since there is so much possible solutions
#for the range of parameters below

for r in range(70,161):
 r = r * 1e4
 for b in range(1,101):
  b = b * 1e7
  for mdot in range(1,1001):
   mdot  = mdot * 1e15   
   for t_t in range(1,101):
    t_t = t_t * 1e5    
    for delta in range(1,61):
     delta = delta / 100.0   
     for d_bl in range(1,51):
      d_bl = d_bl / 10.0
      for gamma_phi in range(1,21):
       gamma_phi = gamma_phi / 20.0
       for b_0 in range(1,11):
        b_0 = b_0 / 10.0
        for x in range(1,101):
         
         r_in = pow((grav_cons*mass),(-1.0/7.0))*pow((mdot),(-2.0/7.0))*pow(b,(4.0/7.0))*pow(r,(12.0/7.0))
         h_t = 2.0 * delta *r_in / d_bl
         omega_k = math.sqrt((grav_cons*mass)/(pow(r_in,3)))
         c_st = omega_k * h_t
         rho_t = (4.0 * c_sb * pow(t_t,4))/(3.0 * pow(c_st,2) * light_speed)
         mu = mdot / (2.0*math.pi*r_in*rho_t*c_st*h_t)
         omega_0 = 1.0-((pow(b_0,2)*gamma_phi*d_bl)/(mu) * math.exp(-2.0 * x / d_bl))
         f_t = (4.0 * rad_cons * light_speed * pow(t_t,4.0))/(3.0 * k_es * rho_t * h_t)/(rho_t * pow(c_st,3))
         
         if abs(f_t) < 10.0:
          if omega_0 > 0.0:
           result.write('%12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e %12.3e' % (r_in,h_t,omega_k,c_st,rho_t,mu,omega_0,f_t))

result.close()
