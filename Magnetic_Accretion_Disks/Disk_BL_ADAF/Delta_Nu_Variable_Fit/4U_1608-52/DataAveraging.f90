program main
implicit none

integer :: i,j
real(8), dimension(5000) :: Mdot,Eps,Delta_Nu,Lower_QPO,Upper_QPO
real(8) :: Total_Mdot,Total_Epsilon,Total_Delta_Nu,Total_Lower_QPO,Total_Upper_QPO
real(8) :: Average_Mdot,Average_Epsilon,Average_Delta_Nu,Average_Lower_QPO,Average_Upper_QPO
real(8) :: Frequency,Epsilon,ret,Mass,Radius,Magnetic_Field,Alpha_BL,Magnetic_Moment,Gravitational_Constant,Speed_of_Light
real(8) :: Mass_Solar,Mass_Star,pi,rin,Omega_rin,Omega_Kepler_rin,Fastness,A_1,A_2,Frequency_Range,Mdot_Eddington
real(8) :: H_SS,A,Radius_Sch,Radius_Alfven,Kappa_es,H_0

open(10,file='Mdot_vs_Epsilon.dat')
ret=system('rm DataAveraging.dat')
open(11,file='DataAveraging.dat',position='append')

do i=1,2560
    read(10,*) Mdot(i),Eps(i),Delta_Nu(i),Lower_QPO(i),Upper_QPO(i)
end do
close(10)

Frequency_Range=20.0

Mass=1.35000E+00    
Radius=1.12000E+06        
Magnetic_Field=3.85143E+07
Alpha_BL=6.00010E+00   

Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
pi=4.0*ATAN(1.0)
Mdot_Eddington=1.0E+18
Speed_of_Light=3.0E+10
Kappa_es=0.4

Frequency=minval(Lower_QPO,(Lower_QPO .gt. 0.0))
do while(Frequency .le. maxval(Lower_QPO))
    Total_Mdot=0.0
    Total_Epsilon=0.0
    Total_Delta_Nu=0.0
    Total_Lower_QPO=0.0
    Total_Upper_QPO=0.0
    j=0
    do i=1,2560
        if(Lower_QPO(i) .ge. Frequency .and. Lower_QPO(i) .le. Frequency+Frequency_Range) then
            Total_Mdot=Total_Mdot+Mdot(i)
            Total_Epsilon=Total_Epsilon+(Eps(i)*Mdot(i))
            Total_Delta_Nu=Total_Delta_Nu+(Delta_Nu(i)*Mdot(i))
            Total_Lower_QPO=Total_Lower_QPO+(Lower_QPO(i)*Mdot(i))
            Total_Upper_QPO=Total_Upper_QPO+(Upper_QPO(i)*Mdot(i))
            j=j+1
        end if
    end do
    
    Average_Mdot=Total_Mdot*1.0E+18/j
    Average_Epsilon=Total_Epsilon/Total_Mdot
    Average_Delta_Nu=Total_Delta_Nu/Total_Mdot
    Average_Lower_QPO=Total_Lower_QPO/Total_Mdot
    Average_Upper_QPO=Total_Upper_QPO/Total_Mdot
    
    Magnetic_Moment=(Magnetic_Field)*(Radius**3.0)
    rin=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Average_Mdot)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
    Omega_rin=2.0*pi*Average_Delta_Nu
    Omega_Kepler_rin=((Gravitational_Constant*Mass_Star)**(0.5))*((rin)**(-1.5))
    Fastness=Omega_rin/Omega_Kepler_rin
    A_1=2.0*pi*Average_Upper_QPO/Omega_Kepler_rin
    A_2=((A_1**2.0)/(2.0*Fastness))-(2.0*Fastness)+1.5
    Epsilon=(1.0-Fastness)/((Alpha_BL)*(A_2))
    
    Radius_Sch=6.0*Gravitational_Constant*Mass_Star/(Speed_of_Light**2.0)
    Radius_Alfven=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot_Eddington)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
    
    H_SS=(3.0*Kappa_es*Mdot_Eddington)/(8.0*pi*Speed_of_Light)
    A=0.00043*Radius_Alfven/H_SS
    H_0=0.15227*Radius_Alfven
    
    write(11,101) Average_Mdot*1.0E-18,Average_Epsilon,Epsilon,Average_Delta_Nu,Average_Lower_QPO,&
    Average_Upper_QPO,A,H_0
    101 format(8es15.5)
    Frequency=Frequency+Frequency_Range
end do
    
close(11)
ret=system('gnuplot DataAveraging.gp')

end program main
