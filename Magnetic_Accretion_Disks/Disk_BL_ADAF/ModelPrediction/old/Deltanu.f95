program main
implicit none

integer :: i,j,k,Number_of_Lines,Constant_Int(2),DataLineCounter
real(8) :: Mass,Radius,Magnetic_Field,Alpha_BL,D_BL,Gravitational_Constant,Mass_Solar,Mass_Star,pi,Kappa_es
real(8) :: ret,Omega_Kepler_rin,Radius_Sch,H_SS,A,B,C,Nustar,Radius_Corotation,Speed_of_Light,Radius_Alfven
real(8), dimension(5000) :: Luminosity,Lower_QPO,Mdot,Epsilon,GammaPhi,Delta_Nu_1,Delta_Nu_2
real(8), dimension(5000) :: Average_Delta_Nu_1,Average_Delta_Nu_2,Average_Lower_QPO,Flux,Count_Rate,Delta
real(8) :: Frequency,Frequency_Range,Total_Delta_Nu_1,Total_Delta_Nu_2,Total_Lower_QPO,Conversion_Factor
real(8) :: Total_Mdot,Dummy_1,Dummy_2,Dummy_3,Radius_ISCO,Parsec,Distance,Kiloparsec,Omega_rin,Fastness
real(8) :: Constant_Real(10000000,2),Constant(8),Keplerian_Frequency
character*30 :: filename
filename='4U_1608_52.txt'
! 1.200E+00 1.150E+06 5.774E+07 9.800E+00

Number_of_Lines=DataLineCounter(filename)
Mass=1.2
Radius=1.150E+06
Magnetic_Field=5.774E+07
Alpha_BL=9.8
D_BL=2.0*Alpha_BL
Parsec=3.6
Nustar=619.0
Conversion_Factor=1.5671875000000002E-9/800.3585849719102

open(10,file=filename)
do i=1,Number_of_Lines
read(10,*) Count_Rate(i),Lower_QPO(i)
Flux(i)=Count_Rate(i)*Conversion_Factor
end do
close(10)

open(11,file='Delta_Nu.dat')
write(11,102) 'Mdot','Nu_1','Eps','Delta','GammaPhi','DeltaNu +','DeltaNu -','R*','R_ISCO','R_Alfven','R_Co','R*/R_Alfven',&
'R_ISCO/R_Alfven','R_Aflven/R_Co'
102 format(20a15)
open(12,file='Delta_Nu_vs_Nu_1_Average.dat')

Kiloparsec=3.08567758E+21
Distance=Parsec*Kiloparsec
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
pi=4.0*atan(1.0)
Kappa_es=0.4
Speed_of_Light=3.0E+10
Frequency_Range=35.0

do i=1,Number_of_Lines
Luminosity(i)=4.0*pi*(Distance**2.0)*Flux(i)
Mdot(i)=(Luminosity(i)*Radius)/(Gravitational_Constant*Mass_Star)
Radius_Alfven=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(i))**(-2.0/7.0))*&
((Magnetic_Field)**(4.0/7.0))*((Radius)**(12.0/7.0))
Omega_rin=2.0*pi*300.0
Omega_Kepler_rin=(Gravitational_Constant*Mass_Star/(Radius_Alfven**3.0))**(1.0/2.0)
Keplerian_Frequency=Omega_Kepler_rin/(2.0*pi)
Fastness=Omega_rin/Omega_Kepler_rin
Radius_Sch=2.0*Gravitational_Constant*Mass_Star/(Speed_of_Light**2.0)
Radius_Corotation=(Gravitational_Constant*Mass_Star/((2.0*pi*Nustar)**(2.0)))**(1.0/3.0)

H_SS=(3.0*Kappa_es*Mdot(i))/(8.0*pi*Speed_of_Light)*(1.0-sqrt(3.0*Radius_Sch/Radius_Alfven))
Epsilon(i)=H_SS/Radius_Alfven
Delta(i)=Epsilon(i)*Alpha_BL
GammaPhi(i)=(1.0-Fastness)/Alpha_BL
! Delta_Nu=(-B+-sqrt(B^2-4AC))/(2A)
A=(3)-(4/(Epsilon(i)*D_BL))
B=-A*Keplerian_Frequency-2.0*Lower_QPO(i)
 C=-(Lower_QPO(i)**2.0)
Delta_Nu_1(i)=(-B+sqrt((B**2.0)-(4.0*A*C)))/(2.0*A)
Delta_Nu_2(i)=(-B-sqrt((B**2.0)-(4.0*A*C)))/(2.0*A)

write(11,101) Mdot(i)*1.0E-18,Lower_QPO(i),Epsilon(i),Delta(i),GammaPhi(i),Delta_Nu_1(i),Delta_Nu_2(i),&
Radius,3.0*Radius_Sch,Radius_Alfven,Radius_Corotation,Radius/Radius_Alfven,3.0*Radius_Sch/Radius_Alfven,&
Radius_Alfven/Radius_Corotation
101 format(20es15.5)
end do
close(11)

open(11,file='Delta_Nu.dat')
read(11,*)
do i=1,Number_of_Lines
read(11,*) Mdot(i),Lower_QPO(i),Epsilon(i),Delta(i),GammaPhi(i),Delta_Nu_1(i),Delta_Nu_2(i),&
Radius,Radius_ISCO,Radius_Alfven,Radius_Corotation,Dummy_1,Dummy_2,Dummy_3
end do 
close(11)

! DeltaNu and Nu1 averaging over Mdot values
!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
k=1
Frequency=minval(Lower_QPO,(Lower_QPO .gt. 0.0))
do while(Frequency .le. maxval(Lower_QPO))
Total_Mdot=0.0
Total_Delta_Nu_1=0.0
Total_Delta_Nu_2=0.0
Total_Lower_QPO=0.0

do j=1,Number_of_Lines
if(Lower_QPO(j) .ge. Frequency .and. Lower_QPO(j) .le. Frequency+Frequency_Range) then
Total_Mdot=Total_Mdot+(Mdot(j))
Total_Delta_Nu_1=Total_Delta_Nu_1+(Delta_Nu_1(j)*Mdot(j))
Total_Delta_Nu_2=Total_Delta_Nu_2+(Delta_Nu_2(j)*Mdot(j))
Total_Lower_QPO=Total_Lower_QPO+(Lower_QPO(j)*Mdot(j))
end if
end do

Average_Delta_Nu_1(k)=Total_Delta_Nu_1/Total_Mdot
Average_Delta_Nu_2(k)=Total_Delta_Nu_2/Total_Mdot
Average_Lower_QPO(k)=Total_Lower_QPO/Total_Mdot

write(12,101) Average_Lower_QPO(k),Average_Delta_Nu_1(k),Average_Delta_Nu_2(k)

Frequency=Frequency+Frequency_Range
k=k+1
end do

filename='Deltanu_Final.dat'
Number_of_Lines=DataLineCounter(filename)

open(14,file='Mass_vs_Radius.dat')

open(13,file=filename)
read(13,*)
read(13,*) Constant_Int(1),Constant_Int(2),Constant_Real(1,1),Constant_Real(1,2),Constant(1),Constant(2),&
        Constant(3),Constant(4),Constant(5),Constant(6),Constant(7),Constant(8)

    do i=1,Number_of_Lines-2
        
        read(13,*) Constant_Int(1),Constant_Int(2),Constant_Real(i+1,1),Constant_Real(i+1,2),Constant(1),Constant(2),&
        Constant(3),Constant(4),Constant(5),Constant(6),Constant(7),Constant(8)
        
        if(Constant_Real(i+1,1) .ne. Constant_Real(i,1) .or. Constant_Real(i+1,2) .ne. Constant_Real(i,2)) then
            write(14,101) Constant_Real(i+1,1),Constant_Real(i+1,2)
        end if
        
    end do
    
close(13)
close(14)
!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

close(12)

ret=system('gnuplot Gnuplot.gp')
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
