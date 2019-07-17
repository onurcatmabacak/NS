program main
implicit none

integer :: i,j,dummy,Line_Number,DataLineCounter
real(8) :: Mass,Radius,Magnetic_Field,Alpha_BL,Chisquare,A1,A2,A3,a,H_0,C,Eps_max,Eps_min,Delta_max,Delta_min,Delta_Nu
real(8) :: Gravitational_Constant,Mass_Solar,Speed_of_Light,Mass_Star,pi,Magnetic_Moment,A_1,A_2,Kiloparsec
real(8), dimension(5000) ::Count_Rate,Lower_QPO,Luminosity,Flux,Upper_QPO,Mdot,rin,Omega_rin,Omega_Kepler_rin,Fastness,Epsilon,Delta
real(8), dimension(4) :: Distance,Conversion_Factor
character(len=50), dimension(4) :: Filename,Source
character*50 :: Sourcename
Data Filename / '4U_1608_52_4.22kpc_Delta.dat','4U_1636_54_5.5kpc_Delta.dat','Aql_X_1_Mendez_2.5kpc_Delta.dat',&
'Aql_X_1_Barret_2.5kpc_Delta.dat'  /

Data Distance / 4.22, 5.5, 2.5, 2.5 /
Kiloparsec=3.08567758E+21
Distance=Distance*Kiloparsec
Data Source / '4U_1608_52.txt', '4U_1636_54.txt', 'Aql_X_1_Mendez.txt', 'Aql_X_1_Barret.txt'/

Data Conversion_Factor / 4.49754,4.6,2.3,10.0 /
Conversion_Factor=Conversion_Factor*1.0E-12
Delta_Nu=300.0
pi=4.0*atan(1.0)
open(10,file='Mass_140.dat')

do i=1,4
    open(12,file=Filename(i))

    read(10,100) dummy,Sourcename,Mass,Radius,Magnetic_Field,Alpha_BL,Chisquare,A1,A2,A3,a,H_0,C,Eps_max,Eps_min,Delta_max,Delta_min
    100 format(1i5,4x,1a30,20es15.5)
 
    Gravitational_Constant=6.67E-08
    Mass_Solar=2.0E+33
    Speed_of_Light=3.0E+10
    Mass_Star=Mass*Mass_Solar
 
    Line_Number=DataLineCounter(Source(i))

    open(11,file=Source(i))

    do j=1,Line_Number
    

        read(11,*) Count_Rate(j), Lower_QPO(j)
        Flux(j)=Count_Rate(j)*Conversion_Factor(i)
        Luminosity(j)=4.0*pi*(Distance(i)*Distance(i))*Flux(j)
        Upper_QPO(j)=Lower_QPO(j)+Delta_Nu

        Mdot(j)=(Luminosity(j)*Radius)/(Gravitational_Constant*Mass_Star)
        Magnetic_Moment=(Magnetic_Field)*(Radius**3.0)
        rin(j)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*(Mdot(j)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
        Omega_rin(j)=2.0*pi*Delta_Nu
        Omega_Kepler_rin(j)=((Gravitational_Constant*Mass_Star)**(0.5))*((rin(j))**(-1.5))
        Fastness(j)=Omega_rin(j)/Omega_Kepler_rin(j)
        A_1=2.0*pi*Upper_QPO(j)/Omega_Kepler_rin(j)
        A_2=((A_1**2.0)/(2.0*Fastness(j)))-(2.0*Fastness(j))+1.5
        Epsilon(j)=(1.0-Fastness(j))/((Alpha_BL)*(A_2))
        Delta(j)=Epsilon(j)*Alpha_BL
        write(12,200) Mdot(j),Flux(j),Delta(j)
        200 format(3es15.5)
    end do

    close(12)
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
