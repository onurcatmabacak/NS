program main
implicit none

integer :: i,j,Number_of_Lines,DataLineCounter
real(8) :: Mass_Star,Radius,Kiloparsec,Gravitational_Constant
real(8) :: Radius_Alfven_min,Radius_Alfven_max,Radius_Corotation,Radius_ISCO,Speed_of_Light,pi,Nustar,Mdot_min,Mdot_max
real(8), dimension(5) :: Magnetic_Field,Distance,Conversion_Factor
real(8),dimension(10000) :: Count_Rate,Lower_QPO,Flux,Mdot,Luminosity
character*30, dimension(5) :: Filename,Filename_new

100 format(5es15.3)

Mass_Star=1.4*2.0E+33
Radius=1.0E+06

Kiloparsec=3.086E+21
Gravitational_Constant=6.67E-08
Speed_of_Light=3.0E+10
pi=4.0*atan(1.0)

Nustar=300.0

Data Filename_new / '4U_1608_52_Flux_QPO.dat','4U_1636_54_Flux_QPO.dat','4U_1728_34_Flux_QPO.dat',&
'Aql_X_1_Flux_QPO_Mendez.dat','Aql_X_1_Flux_QPO_Barret.dat' /
Data Filename / '4U_1608_52.txt','4U_1636_54.txt','4U_1728_34.txt','Aql_X_1_Mendez.txt','Aql_X_1_Barret.txt' /
Data Distance / 4.22,5.5,4.5,2.5,2.5 /
Distance=Distance*Kiloparsec
Data Magnetic_Field / 1.0,1.0,1.0,0.3,0.4 /
Data Conversion_Factor / 4.49754,4.6,3.95,2.3,10.0 /
Magnetic_Field=Magnetic_Field*1.0E+08
Conversion_Factor=Conversion_Factor*1.0E-12

do j=1,5

    Count_Rate=0.0
    Lower_QPO=0.0
    Flux=0.0
    Mdot=0.0
    Number_of_Lines=DataLineCounter(Filename(j))
    open(j+10,file=Filename(j))
    open(j+20,file=Filename_new(j))

    do i=1,Number_of_Lines
        read(j+10,*) Count_Rate(i),Lower_QPO(i)
        Upper_QPO(i)=Lower_QPO(i)
        Flux(i)=Count_Rate(i)*Conversion_Factor(j)
        Luminosity(i)=4.0*pi*(Distance(j)**2.0)*Flux(i)
        Mdot(i)=(Luminosity(i)*Radius)/(Gravitational_Constant*Mass_Star)
    end do

    Mdot_max=maxval(Mdot,(Mdot .gt. 0.0))
    Mdot_min=minval(Mdot,(Mdot .gt. 0.0))

    Radius_ISCO=(6.0*Gravitational_Constant*Mass)/(Speed_of_Light**2.0)
    Radius_Alfven_min=((Gravitational_Constant*Mass)**(-1.0/7.0))*&
    ((Mdot_max)**(-2.0/7.0))*((Magnetic_Field(j))**(4.0/7.0))*((Radius)**(12.0/7.0))
    Radius_Alfven_max=((Gravitational_Constant*Mass)**(-1.0/7.0))*&
    ((Mdot_min)**(-2.0/7.0))*((Magnetic_Field(j))**(4.0/7.0))*((Radius)**(12.0/7.0))
    Radius_Corotation=((Gravitational_Constant*Mass)/((2.0*pi*Nustar)**(2.0)))**(1.0/3.0)

    write(*,100) Radius_ISCO,Radius_Alfven_min,Radius_Alfven_max,Radius_Corotation

    close(j+10)
    close(j+20)
end do

end program main

function DataLineCounter(Filename) result(M)
integer :: M
character*30 :: FileName

open(1,file=FileName)
M=0
do
    read(1,*,iostat=io)
    
    if(io .gt. 0) then
        exit
    else if(io .lt. 0) then
        exit
    else if(io .eq. 0) then
    
    M=M+1
    end if

end do
close(1)
end function

