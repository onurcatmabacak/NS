program main
implicit none

integer :: i,Number_of_Lines
real(8) :: Mass,Radius,Magnetic_Field,Alpha_BL,Nustar,Parsec,Kiloparsec,Distance,Gravitational_Constant,Mass_Solar,Mass_Star
real(8) :: Speed_of_Light,pi,A_1,A_2,Magnetic_Moment,ret
real(8), dimension(5000) :: Mdot,Flux,Luminosity,Delta_Nu,Lower_QPO_Frequency,Upper_QPO_Frequency,rin,Omega_rin,Omega_Kepler_rin
real(8), dimension(5000) :: Small_Omega,Epsilon

open(unit=9,file='4U_1728_34_Flux_QPO_DeltaNu.dat')
open(10,file='Mdot_vs_Epsilon.dat')
Number_of_Lines=1399

do i=1,Number_of_Lines
    read(9,*) Flux(i),Delta_Nu(i),Lower_QPO_Frequency(i),Upper_QPO_Frequency(i)
end do
close(9)

Mass=1.44000E+00    
Radius=1.13000E+06        
Magnetic_Field=9.13694E+07            
Alpha_BL=3.66813E+00

Nustar=363.0
Parsec=4.5
Kiloparsec=3.08567758E+21
Distance=Parsec*Kiloparsec
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Speed_of_Light=3.0E+10
Mass_Star=Mass*Mass_Solar
pi=4.0*ATAN(1.0)

do i=1,Number_of_Lines
    Luminosity(i)=Flux(i)*1.0E-07*((2.0*sqrt(pi)*Distance)**2.0)
    Mdot(i)=(Luminosity(i)*Radius)/(Gravitational_Constant*Mass_Star) 
    
    Magnetic_Moment=(Magnetic_Field)*(Radius**3.0)
    rin(i)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(i))**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
    Omega_rin(i)=2.0*pi*Delta_Nu(i)
    Omega_Kepler_rin(i)=((Gravitational_Constant*Mass_Star)**(0.5))*((rin(i))**(-1.5))
    Small_Omega(i)=Omega_rin(i)/Omega_Kepler_rin(i)
    A_1=2.0*pi*Upper_QPO_Frequency(i)/Omega_Kepler_rin(i)
    A_2=((A_1**2.0)/(2.0*Small_Omega(i)))-(2.0*Small_Omega(i))+1.5
    Epsilon(i)=(1.0-Small_Omega(i))/((Alpha_BL)*(A_2))
    
    write(10,101) Mdot(i)*1.0E-18,Epsilon(i),Delta_Nu(i),Lower_QPO_Frequency(i),Upper_QPO_Frequency(i),Epsilon(i)*Alpha_BL
    101 format(6es15.5)
end do

close(10)

ret=system('gnuplot Mdot_vs_Epsilon.gp')
end program main
