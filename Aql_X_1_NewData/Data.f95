program main
implicit none

integer :: i,Number_of_Lines,DataLineCounter
real(8),dimension(10000) :: Count_Rate,Frequency,Flux,Luminosity,Mdot
real(8) :: pi,Kiloparsec,Distance,Gravitational_Constant,Mass_Solar,Mass_Star,Speed_of_Light,Nustar,Mdot_max,Mdot_min
real(8) :: Mass,Magnetic_Field,Radius,Radius_ISCO,Radius_Alfven_max,Radius_Alfven_min
real(8) :: Radius_Corotation,Conversion_Factor
character*30 :: Filename

Mass=1.4
Radius=1.0E+06
Magnetic_Field=3.0E+07

Conversion_Factor=2.2E-12
pi=4.0*atan(1.0)
Nustar=300.0
Kiloparsec=3.086E+21
Distance=2.5*Kiloparsec
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Speed_of_Light=3.0E+10
Mass_Star=Mass*Mass_Solar

Filename='Aql_X_1_CR_QPO.dat'
Number_of_Lines=DataLineCounter(Filename)

open(10,file=Filename)
do i=1,Number_of_Lines
    read(10,*) Count_Rate(i),Frequency(i)
    Flux(i)=Count_Rate(i)*Conversion_Factor
    Luminosity(i)=Flux(i)*4.0*pi*(Distance**2.0)
    Mdot(i)=(Luminosity(i)*Radius)/(Mass_Star*Gravitational_Constant)
end do
close(10)

Mdot_min=minval(Mdot,(Mdot .gt. 0.0))
Mdot_max=maxval(Mdot,(Mdot .gt. 0.0))

Radius_ISCO=(6.0*Gravitational_Constant*Mass_Star)/(Speed_of_Light**2.0)
Radius_Alfven_min=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*&
((Mdot_max)**(-2.0/7.0))*((Magnetic_Field)**(4.0/7.0))*((Radius)**(12.0/7.0))
Radius_Alfven_max=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*&
((Mdot_min)**(-2.0/7.0))*((Magnetic_Field)**(4.0/7.0))*((Radius)**(12.0/7.0))
Radius_Corotation=((Gravitational_Constant*Mass_Star)/((2.0*pi*Nustar)**(2.0)))**(1.0/3.0)

100 format(10es15.5)

write(*,100) Radius_ISCO,Radius,Radius_Alfven_min,Radius_Alfven_max,Radius_Corotation
end program main

function DataLineCounter(Filename) result(M)

integer :: M
character*30 :: FileName

open(10,file=FileName)
M=0
do
    read(10,*,iostat=io)
    
    if(io .gt. 0) then
        exit
    else if(io .lt. 0) then
        exit
    else if(io .eq. 0) then
    
    M=M+1
    end if

end do
close(10)
end function

