program LevenbergMarquardtFit
implicit none

integer :: M,N,i_read
real(8) :: z(3),ChiS

i_read=9
N=3
M=2560
call Fit(M,N,i_read,z,ChiS)
write(*,101) z(1),z(2),z(3),ChiS
101 format(4e15.5)
end program LevenbergMarquardtFit

subroutine Fit(M,N,i_read,z,ChiS)
implicit none

integer :: i,j,k,N,M,i_read,onur
real(8), dimension(5000) :: Mdot,Epsilon,GammaPhi,eps_fit_function,eps_fit_function_new,dif,dif_new,eps_fit_func
real(8) :: Mass,Radius,Magnetic_Field,Alpha_BL,x(3),z(3),ChiSquare,ChiSquare_new,lambda,TOL,power(3)
real(8) :: A(M,N),B(M),B_new(M),Alpha(N,N),Alpha_Prime(N,N),Beta(N),oran,delta_x(3),top,ChiSquare_min,ChiS

lambda=1.0E+01
TOL=1.0E-10

data power / 2.0,9.0,10.0 /

do i=1,3
power(i)=power(i)/7.0
end do

data x / 1.0,1.0,-1.0 /

open(unit=20,file='Epsilon_Fit.dat')
200 format(3e15.5)

open(unit=i_read,file='Sample2.dat')
100 format(7e15.5)

! Readin data from file
do i=1,M
read(i_read,100) Mass,Radius,Magnetic_Field,Alpha_BL,Mdot(i),Epsilon(i),GammaPhi(i)
end do

! Standard error of every data
do i=1,M
eps_fit_function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+((x(2))*(Mdot(i)**(9.0/7.0)))+((x(3))*(Mdot(i)**(10.0/7.0)))
dif(i)=Epsilon(i)-eps_fit_function(i)
B(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B,B)
ChiSquare_min=ChiSquare

! Let the iterations begin HAHAHAHAHA
onur=1
do while(onur .le. 1000)

! Standard error of every data
do i=1,M
eps_fit_function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+((x(2))*(Mdot(i)**(9.0/7.0)))+((x(3))*(Mdot(i)**(10.0/7.0)))
dif(i)=Epsilon(i)-eps_fit_function(i)
B(i)=dif(i)
do j=1,N
A(i,j)=Mdot(i)**(power(j))
end do
end do

! Calculations of Gradient (Beta) and Approximated Hessian (Alpha) Matrices
Alpha=0.5*matmul(transpose(A),A)
Beta=0.5*matmul(transpose(A),B)

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

write(*,101) onur,z(1),(z(2)),(z(3))
101 format(1i3,3e15.5)
! ChiSquare_new calculation
do i=1,M
eps_fit_function_new(i)=((z(1))*(Mdot(i)**(2.0/7.0)))+((z(2))*(Mdot(i)**(9.0/7.0)))&
+((z(3))*(Mdot(i)**(10.0/7.0)))
dif_new(i)=Epsilon(i)-eps_fit_function_new(i)
B_new(i)=dif_new(i)
end do
ChiSquare_new=dot_product(B_new,B_new)

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

onur=onur+1
end do

do i=1,M
eps_fit_func(i)=z(1)*(Mdot(i)**(2.0/7.0))+(z(2))*(Mdot(i)**(9.0/7.0))+(z(3))*(Mdot(i)**(10.0/7.0))
write(20,200) Mdot(i),Epsilon(i),eps_fit_func(i)
end do
ChiS=ChiSquare_new
close(20)
close (i_read)
end subroutine 
