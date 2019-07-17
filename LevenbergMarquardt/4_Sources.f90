program Epsilon_Square
implicit none

integer :: i_read,Tip,i_write,Number_of_Lines,N,i,Data_Read
real(8), dimension(5000) :: Mdot,Luminosity,Lower_QPO_Frequency,Upper_QPO_Frequency
real(8), dimension(5000) :: rin,Omega_Kepler_rin,Constant,ABL
real(8) :: Magnetic_Field,Alpha_BL,Mass,Radius,Nustar,Omega_Star
real(8) :: Gravitational_Constant,Mass_Solar,Mass_Star,Mdot_max,Mdot_min,Speed_of_Light,Magnetic_Moment
real(8) :: Magnetic_Field_min,Magnetic_Field_max,Magnetic_Field_step,Magnetic_Field_min_Alfven,Magnetic_Field_min_ISCO
real(8) :: pi,Omega_rin,Delta_Nu

read(*,*) Data_Read

N=3
Tip=1
Delta_Nu=300.0

open(unit=16,file='4_Sources_M_R.dat',position='append')
do i_read=9,15
i_write=500
!::::::::::::::::::::::::::::::::::::: Data Read From File ::::::::::::::::::::::::::::::::::::::::!
if(i_read .eq. 9) then
Number_of_Lines=2560
Nustar=619.0
open(unit=9,file='4U_1608_52_4.22_kpc.dat')
else if(i_read .eq. 10) then
Number_of_Lines=2560
Nustar=619.0
open(unit=10,file='4U_1608_52_5.0_kpc.dat')
else if(i_read .eq. 11) then
Number_of_Lines=3706
Nustar=582.0
open(unit=11,file='4U_1636_54_5.5_kpc.dat')
else if(i_read .eq. 12) then
Number_of_Lines=3706
Nustar=582.0
open(unit=12,file='4U_1636_54_7.0_kpc.dat')
else if(i_read .eq. 13) then
Number_of_Lines=1399
Nustar=363.0
open(unit=13,file='4U_1728_34_4.5_kpc.dat')
else if(i_read .eq. 14) then
Number_of_Lines=1789
Nustar=549.0
open(unit=14,file='Aql_X_1_2.5_kpc.dat')
else if(i_read .eq. 15) then
Number_of_Lines=1789
Nustar=549.0
open(unit=15,file='Aql_X_1_5.2_kpc.dat')
end if
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

do i=1,5000
Mdot(i)=0.0
Upper_QPO_Frequency(i)=0.0
Luminosity(i)=0.0
Lower_QPO_Frequency(i)=0.0
end do

100 format(2e15.5)
do i=1,Number_of_Lines
read(i_read,100) Luminosity(i),Lower_QPO_Frequency(i)
end do
close(i_read)


!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
Mass=Data_Read/100.0

Radius=0.7E+06
do while(Radius .le. 1.6E+06)

Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Speed_of_Light=3.0E+10
Mass_Star=Mass*Mass_Solar
pi=4.0*ATAN(1.0)

do i=1,Number_of_Lines
Mdot(i)=(Luminosity(i)*Radius)/(Gravitational_Constant*Mass_Star*1.0E+18)
Upper_QPO_Frequency(i)=Lower_QPO_Frequency(i)+Delta_Nu 
end do

Mdot_min=minval(Mdot,(Mdot .gt. 0.0))
Mdot_max=maxval(Mdot,(Mdot .gt. 0.0))

! Alfven radius is bigger than neutron star's radius
Magnetic_Field_min_Alfven=((Gravitational_Constant*Mass_Star)**(1.0/4.0))*((Mdot_max*1.0E+18)**(1.0/2.0))*&
((Radius)**(-5.0/4.0))
! Alfven radius is bigger than marginally stable orbit
Magnetic_Field_min_ISCO=((Gravitational_Constant*Mass_Star)**(2.0))*((Mdot_max*1.0E+18)**(1.0/2.0))*&
((Radius)**(-3.0))*(((Speed_of_Light**2.0)/6.0)**(-7.0/4.0))

if(Magnetic_Field_min_Alfven .gt. Magnetic_Field_min_ISCO) then
Magnetic_Field_min=Magnetic_Field_min_Alfven
else if(Magnetic_Field_min_Alfven .lt. Magnetic_Field_min_ISCO) then
Magnetic_Field_min=Magnetic_Field_min_ISCO
end if

Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min*1.0E+18)**(1.0/2.0))*&
((Radius)**(-3.0))*((2.0*pi*Nustar)**(-7.0/6.0))

if(Magnetic_Field_max .gt. Magnetic_Field_min) then

Magnetic_Field_step=(Magnetic_Field_max-Magnetic_Field_min)/10.0

Magnetic_Field=Magnetic_Field_min
do while(Magnetic_Field .lt. Magnetic_Field_max)

ABL=0.0
Magnetic_Moment=Magnetic_Field*(Radius**3.0)
Omega_Star=2.0*pi*Nustar
Omega_rin=2.0*pi*Delta_Nu

do i=1,Number_of_Lines

rin(i)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(i)*1.0E+18)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))

Omega_Kepler_rin(i)=sqrt((Gravitational_Constant*Mass_Star)/(rin(i)**3.0))

Constant(i)=(((2.0*pi*Upper_QPO_Frequency(i))**(2.0))/(2.0*Omega_rin))-(2.0*Omega_rin)+(1.5*Omega_Kepler_rin(i))
ABL(i)=10.0*(Omega_Kepler_rin(i)-Omega_rin)/Constant(i)

end do

Alpha_BL=maxval(ABL,(ABL .gt. 0.0))

call Fit(Mass,Magnetic_Field,Radius,Alpha_BL,i_read,i_write,Tip,Number_of_Lines,N,Mdot,Lower_QPO_Frequency,Upper_QPO_Frequency)

Magnetic_Field=Magnetic_Field+Magnetic_Field_step
end do

end if

Radius=Radius+1.0E+03
end do

end do

close(16)
end program Epsilon_Square

subroutine Fit(Mass,Magnetic_Field,Radius,Alpha_BL,i_read,i_write,Tip,Number_of_Lines,&
N,Mdot,Lower_QPO_Frequency,Upper_QPO_Frequency)
implicit none
! f(x)= z(1) * (x^(2/7)) + z(2) * (x^(9/7)) + z(3) * (x^(10/7)) fonksiyonuna fit için

!::::::::::::::::::::::::::::::::::: Parameters Used ::::::::::::::::::::::::::::::::::::::::::::::!
integer :: i,j,k,N,Number_of_Lines,i_read,i_write,Tip,onur

real(8), dimension(5000) :: Mdot,Epsilon,Epsilon_Fit_Function,rin,Omega_Kepler_rin,Small_Omega
real(8), dimension(5000) :: Lower_QPO_Frequency,Upper_QPO_Frequency,Epsilon_Fit_Function_new
real(8) :: x(3),z(3),oran,top,Magnetic_Field,Alpha_BL,Mass,Radius,Omega_rin
real(8) :: pi,Gravitational_Constant,Mass_Solar,Mass_Star,Mdot_Eddington,A_1,A_2,Magnetic_Moment
real(8) :: ChiSquare,ChiSquare_new,lambda,TOL,power(3),delta_x(3),ChiSquare_min,Delta_Nu
real(8) :: A_Matrix(Number_of_Lines,N),B_Vector(Number_of_Lines),B_Vector_new(Number_of_Lines)
real(8) :: Alpha(N,N),Alpha_Prime(N,N),Beta(N),dif(Number_of_Lines),dif_new(Number_of_Lines)
real(8) :: Speed_of_Light,Alfven_Radius_18,Radius_Sch,Capital_A,C,H_0,Small_a,k_es,B
character*20, dimension(7) :: Source_Name

data Source_Name / '4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::: Initial Values of Parameters ::::::::::::::::::::::::::::::::::::::!
pi=4.0*ATAN(1.0)
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
Mdot_Eddington=1.0E+18
Speed_of_Light=3.0E+10
k_es=0.4
Delta_Nu=300.0

Epsilon=0.0
lambda=1.0E+01
TOL=1.0E-10

data power / 0.28571428571428570,1.2857142857142858,1.4285714285714286 /

do i=1,3
z(i)=0.0
delta_x(i)=0.0
end do

data x / 1.0,1.0,-1.0 /

top=0.0
oran=0.0

ChiSquare=0.0
ChiSquare_new=0.0
ChiSquare_min=0.0

do i=1,N
do j=1,N
A_Matrix(i,j)=0.0
Alpha(i,j)=0.0
Alpha_Prime(i,j)=0.0
end do
Beta(i)=0.0
B_Vector(i)=0.0
B_Vector_new(i)=0.0
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::: Calculating new epsilon and omega values using parallel track data:::::::::::!
do i=1,Number_of_Lines
Magnetic_Moment=(Magnetic_Field)*(Radius**3.0)
rin(i)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(i)*Mdot_Eddington)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
Omega_rin=2.0*pi*Delta_Nu
Omega_Kepler_rin(i)=((Gravitational_Constant*Mass_Star)**(0.5))*((rin(i))**(-1.5))
Small_Omega(i)=Omega_rin/Omega_Kepler_rin(i)
if(Tip .eq. 1) then
A_1=2.0*pi*Upper_QPO_Frequency(i)/Omega_Kepler_rin(i)   ! Upper_QPO_Frequency frekansı epsilonun fonksiyonu olduğundan
else if(Tip .eq. 2) then                                ! dolayı tip 1 de Upper_QPO_Frequency tip2 de Upper_QPO_Frequency-omega frekansları
A_1=2.0*pi*Lower_QPO_Frequency(i)/Omega_Kepler_rin(i)   ! Upper_QPO_Frequency tanımına denk gelmektedir.
end if

A_2=((A_1**2.0)/(2.0*Small_Omega(i)))-(2.0*Small_Omega(i))+1.5

Epsilon(i)=(1.0-Small_Omega(i))/((Alpha_BL)*(A_2))
end do

!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::: Nonlinear Least Square Fit To Data Using Levenberg-Marquardt Method :::::::::::::::!

! Standard error of every data
do i=1,Number_of_Lines
Epsilon_Fit_Function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+(abs(x(2))*(Mdot(i)**(9.0/7.0)))-(abs(x(3))*(Mdot(i)**(10.0/7.0)))
dif(i)=Epsilon(i)-Epsilon_Fit_Function(i)
B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
ChiSquare_min=ChiSquare

! Let the iterations begin HAHAHAHAHA
do onur=1,1000

! Standard error of every data
do i=1,Number_of_Lines
Epsilon_Fit_Function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+(abs(x(2))*(Mdot(i)**(9.0/7.0)))-(abs(x(3))*(Mdot(i)**(10.0/7.0)))
dif(i)=Epsilon(i)-Epsilon_Fit_Function(i)
B_Vector(i)=dif(i)
do j=1,N
A_Matrix(i,j)=Mdot(i)**(power(j))
end do
end do

! Calculations of Gradient (Beta) and Approximated Hessian (Alpha) Matrices
Alpha=0.5*matmul(transpose(A_Matrix),A_Matrix)
Beta=0.5*matmul(transpose(A_Matrix),B_Vector)

do i=1,N
do j=1,N

if(i .eq. j) then
Alpha_Prime(i,j)=Alpha(i,j)*(1.0+lambda)
else if(i .ne. j) then
Alpha_Prime(i,j)=Alpha(i,j)
end if

end do
end do

!!!!!!!!!!!!!!!!!!!!!
!!Gauss Elimination!!
!!!!!!!!!!!!!!!!!!!!!

! Diagonalization of the matrix
do i=1, N-1
do k=i+1, N
oran=Alpha_Prime(k,i)/Alpha_Prime(i,i)
Beta(k)=Beta(k)-(Beta(i)*oran)
do j=i, N
Alpha_Prime(k,j)=Alpha_Prime(k,j)-(Alpha_Prime(i,j)*oran)
end do
end do
end do

! Solution of coefficients in the diagonalized matrix
do i=N, 1, -1
top=0.0
if(i .eq. N) then
top=0.0
else if(i .ne. N) then
do j=i+1,N
top=top+(Alpha_Prime(i,j)*delta_x(j))
end do
end if
delta_x(i)=(Beta(i)-top)/Alpha_Prime(i,i)
end do

do i=1,N
z(i)=x(i)+delta_x(i)
end do

!:::::::::::::::::::::::::::::::::::::::: ChiSquare_new calculation :::::::::::::::::::::::::::::::!
do i=1,Number_of_Lines
Epsilon_Fit_Function_new(i)=((z(1))*(Mdot(i)**(2.0/7.0)))+(abs(z(2))*(Mdot(i)**(9.0/7.0)))&
-(abs(z(3))*(Mdot(i)**(10.0/7.0)))
dif_new(i)=Epsilon(i)-Epsilon_Fit_Function_new(i)
B_Vector_new(i)=dif_new(i)
end do
ChiSquare_new=dot_product(B_Vector_new,B_Vector_new)

if(ChiSquare_new .ge. ChiSquare_min) then

if(ChiSquare_new-ChiSquare_min .lt. TOL) then
exit
else if(ChiSquare_new-ChiSquare_min .ge. TOL) then
lambda=lambda*10.0
end if

else if(ChiSquare_new .lt. ChiSquare_min) then
lambda=lambda/10.0
ChiSquare_min=ChiSquare_new
end if
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::::::Calculation of ChiSquare:::::::::::::::::::::::::::::::::::::::::!
! Standard error of every data
do i=1,Number_of_Lines
Epsilon_Fit_Function(i)=(z(1)*(Mdot(i)**(2.0/7.0)))+(abs(z(2))*(Mdot(i)**(9.0/7.0)))-(abs(z(3))*(Mdot(i)**(10.0/7.0)))
dif(i)=Epsilon(i)-Epsilon_Fit_Function(i)
B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!::::::::::::::::::::::::::::: Writing Values of Parameters To Data File ::::::::::::::::::::::::::!

130 format(1i3,1a21,20es15.5)

Alfven_Radius_18=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*(Mdot_Eddington**(-2.0/7.0))*(Magnetic_Moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*Mass_Star/(Speed_of_Light**2.0)
Capital_A=(3.0*k_es*Mdot_Eddington)/(8.0*pi*Speed_of_Light*Alfven_Radius_18)

Small_a=abs(z(2))/Capital_A
B=-abs(z(3))/Small_a
C=B/Capital_A*sqrt(Alfven_Radius_18/(3.0*Radius_Sch))
H_0=z(1)*Alfven_Radius_18

write(16,130) i_write-499,Source_Name(i_read-8),Mass,Radius,Magnetic_Field,Alpha_BL,ChiSquare,z(1),abs(z(2)),-abs(z(3)),&
Small_a,H_0,C,maxval(Epsilon,(Epsilon .gt. 0.0)),minval(Epsilon,(Epsilon .gt. 0.0))
i_write=i_write+1
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
end subroutine 
