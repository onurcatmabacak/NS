#!/usr/bin/python3
from numpy import arange
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import math

def SystemODE(state, x):
  h_0, sigma_0 = state # h_0 and sigma_0
  
  mass_solar = 2.0e+33
  mass = 1.4 * mass_solar
  grav_cons = 6.67e-8
  mdot_t = 1e17
  b = 1e8
  r = 1e6
  delta = 0.1
  d_bl = 1.0
  c_sb = 5.67e-5  
  t_t = 1e7
  light_speed = 3e10
  gamma_phi = 0.25
  b_0 = 0.5
  mdot = 0.1
  rad_cons = 7.56e-15
  k_es = 0.4
  
  r_in = pow((grav_cons*mass),(-1.0/7.0))*pow((mdot_t),(-2.0/7.0))*pow(b,(4.0/7.0))*pow(r,(12.0/7.0))
  h_t = 2.0 * delta *r_in / d_bl
  omega_k = math.sqrt((grav_cons*mass)/(pow(r_in,3)))
  c_st = omega_k * h_t
  rho_t = (4.0 * c_sb * pow(t_t,4))/(3.0 * pow(c_st,2) * light_speed)
  mu = mdot_t / (2.0*math.pi*r_in*rho_t*c_st*h_t)
  omega_0 = 1.0-((pow(b_0,2)*gamma_phi*d_bl)/(mu*mdot) * math.exp(-2.0 * x / d_bl))
  f_t = (4.0 * rad_cons * light_speed * pow(t_t,4.0))/(3.0 * k_es * rho_t * h_t)
  #derivatives of h_o and sigma_0
  part_1 = (3.0 * d_bl * (1.0 + omega_0))/(4.0 * b_0 * gamma_phi)
  part_2 = sigma_0 - ((4.0 * b_0 * d_bl)/(1.0 + omega_0))*((pow((gamma_phi * d_bl),(-2.0)))+(1.0/3.0))
  d_h_0 = part_1 * part_2
  part_3 = ((2.0 * f_t)/(rho_t * pow(c_st,3.0) * d_bl))-(2.0 * mu * mdot)
  part_4 = ((2.0 * d_h_0)/(d_bl))-((4.0 * h_0)/(d_bl))-(4.0 * mu * mdot * d_bl * ((pow((gamma_phi * d_bl),(-2.0)) + (1.0/3.0))))+(1.0/h_0)-(4.0 * mu * mdot * d_bl * pow(h_0,(-2.0)))
  d_sigma_0 = part_4 / part_3 * sigma_0
  return [d_h_0, d_sigma_0] #return derivatives

x = arange(0, 10, 0.01) #time step
init_state = [0.1, 0.1] #initial conditions at zero
state = odeint(SystemODE, init_state, x)

plt.xlabel('X')
plt.ylabel('h and sigma')
plt.plot(x,state[:,0],'b-',label='h_0')
plt.plot(x,state[:,1],'r.',label='sigma_0')
plt.legend(loc='upper right')
plt.show()
