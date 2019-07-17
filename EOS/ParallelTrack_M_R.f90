program ParallelTrackMasterpiece
implicit none

integer :: i_read,Tip,i_write,M,N,i,B_abl_choose,i_Mass,i_B,i_R,i_abl
real(8), dimension(4000) :: Mtipik,eps_old,eps_fit_old,omegastar_old,kappa_minus,kappa,F_old,F_fit_old,S_A_old,S_A_old_fit
real(8) :: B_value,abl_value,Mass,R,Marginally_Stable_Orbit,Alfven_Radius
real(8) :: G,Msolar,Mstar,Mdot,c,mu

!::::::::::::::::::::::::::: File Recorded Deatiled Information ::::::::::::::::::::::::::::::::!
open(unit=8,file='Summary.txt')
120 format(15a15)
write(8,*) '1.0-3.0 M_solar, 5-20 km yarıçaplı, 10^8 - 10^9 G manyetik alanlı'
write(8,*) 'Dünyalar güzeli nötron yıldızlarımızın, parallel track üretecek şekilde'
write(8,*) 'serbest parametreleri hesaplandı ve epsilon, S_A gibi parametrelere fit yapıldı'
write(8,*) ' '
write(8,*) 'Yapılan fitler :'
write(8,*) 'Epsilon : f ( x ) = a * x ^ (2/7) + b * x ^ (9/7) + c * x ^ (10/7) '
write(8,*) 'S_A : S_A(F) = e * F + d '
write(8,*) 'S_A_fit : S_A_fit(F_fit) = g * F_fit + f '
write(8,*) ' '
write(8,*) ' '
write(8,120) 'Dosya ismi','Kaynak','Tip','Mass(M_solar)','Radius(cm)','Mag Field (G)','abl','a','b','c','ChiSquare','d','e','f','g'
close(8)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

open(unit=14,file='ParallelTrack_M_R.dat',position='append')

i_write=500
N=3

do Tip=1,1
do i_read=9,12

!::::::::::::::::::::::::::::::::::::: Data Read From File ::::::::::::::::::::::::::::::::::::::::!
if(i_read .eq. 9) then
M=2560
Mdot=8.0*(10**17.0)
open(unit=9,file='4U_1608_52_Observation.dat',status='old',access='sequential',action='read')

else if(i_read .eq. 10) then
M=3706
Mdot=6.5*(10**17.0)
open(unit=10,file='4U_1636_54_Observation.dat',status='old',access='sequential',action='read')

else if(i_read .eq. 11) then
M=1399
Mdot=5.5*(10**17.0)
open(unit=11,file='4U_1728_34_Observation.dat',status='old',access='sequential',action='read')

else if(i_read .eq. 12) then
M=1789
Mdot=4.0*(10**17.0)
open(unit=12,file='Aql_X_1_Observation.dat',status='old',access='sequential',action='read')

end if

100 format(10e15.5)
do i=1,M
read(i_read,100) Mtipik(i),eps_old(i),eps_fit_old(i),omegastar_old(i),kappa_minus(i),kappa(i),&
F_old(i),F_fit_old(i),S_A_old(i),S_A_old_fit(i)
end do
close(i_read)

!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
!$omp parallel
!$omp do
do i_Mass=10,300
Mass=i_Mass/100.0
do i_R=700,1600
R=i_R*(10**3.0)
do i_B=10,100
B_value=i_B*(10**7.0)
do i_abl=1,250
abl_value=i_abl/10.0

G=6.67*(10**(-8.0))
Msolar=2.0*(10**(33.0))
Mstar=Mass*Msolar
c=3.0*(10**10.0)
mu=B_value*(R**3.0)

Alfven_Radius=((Mdot)**(-2.0/7.0))*((G*Mstar)**(-1.0/7.0))*((mu)**(4.0/7.0))
Marginally_Stable_Orbit=6.0*G*Mstar*(c**(-2.0))

if(Alfven_Radius .gt. R .and. Alfven_Radius .gt. Marginally_Stable_Orbit) then

if(B_abl_choose(M,Tip,Mass,R,B_value,abl_value,Mtipik,kappa,kappa_minus) .lt. M-1) then
else if(B_abl_choose(M,Tip,Mass,R,B_value,abl_value,Mtipik,kappa,kappa_minus) .ge. M-1) then
call Fit(Mass,B_value,R,abl_value,i_read,i_write,Tip,M,N,Mtipik,kappa_minus,kappa,S_A_old)
exit
end if

end if

end do
end do
end do
end do
!$omp end do
!$omp end parallel
end do
end do

close(14)

call DataManipulation
end program ParallelTrackMasterpiece

subroutine Fit(Mass,B_value,R,abl_value,i_read,i_write,Tip,M,N,Mtipik,kappa_minus,kappa,S_A_old)
implicit none
! f(x)= a * (x^(2/7)) + b * (x^(9/7)) + c * (x^(10/7)) fonksiyonuna fit için

!::::::::::::::::::::::::::::::::::: Parameters Used ::::::::::::::::::::::::::::::::::::::::::::::!
integer :: i,j,k,N,M,i_read,i_write,Tip,kedi,onur

real(8), dimension(4000) :: Mtipik,eps,omegastar,eps_fit_function,S_A_old
real(8), dimension(4000) :: kappa_minus,kappa,S_A,omega_k,F,F_fit,eps_fit,S_A_fit,eps_fit_function_new
real(8) :: x(3),y(2),t(2),z(3),oran,top,B_value,abl_value,Mass,R
real(8) :: pi,G,Msolar,Mstar,Medd,S_A_top,F_top1,F_top2,A,A1,A_1,A_2,mu,nustar
real(8) :: Katsayi_1,Katsayi_2,Katsayi_3,Katsayi_4,Katsayi_5,Katsayi_6,Katsayi_7,Katsayi_8
real(8) :: ChiSquare,ChiSquare_new,lambda,TOL,power(3),delta_x(3),ChiSquare_min
real(8) :: A_Matrix(M,N),B_Vector(M),B_Vector_new(M),Alpha(N,N),Alpha_Prime(N,N),Beta(N),dif(M),dif_new(M)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::: Initial Values of Parameters ::::::::::::::::::::::::::::::::::::::!
pi=4.0*ATAN(1.0)
G=6.67*(10.0**(-8.0))
Msolar=2.0*(10**(33.0))
Mstar=Mass*Msolar
Medd=10**18.0
nustar=300.0

lambda=0.001
TOL=0.00001

data power / 0.28571428571428570,1.2857142857142858,1.4285714285714286 /

do i=1,3
z(i)=0.0
delta_x(i)=0.0
end do

data x / 1.0,1.0,1.0 /

kedi=0

Katsayi_1=0.0
Katsayi_2=0.0
Katsayi_3=0.0
Katsayi_4=0.0
Katsayi_5=0.0
Katsayi_6=0.0
Katsayi_7=0.0
Katsayi_8=0.0

S_A_top=0.0
F_top1=0.0
F_top2=0.0

top=0.0
oran=0.0

ChiSquare=0.0
ChiSquare_new=0.0
ChiSquare_min=0.0

t(1)=0.0
t(2)=0.0

y(1)=0.0
y(2)=0.0

do i=1,N
do j=1,N
A_Matrix(i,j)=0.0
Alpha(i,j)=0.0
Alpha_Prime(i,j)=0.0
end do
Beta(i)=0.0
B_Vector(i)=0.0
B_Vector_new(i)=0.0
S_A(i)=0.0
S_A_fit(i)=0.0
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!::::::::::::::::::::::::::::: Writing Formats :::::::::::::::::::::::!
130 format(1i15,1a15,1i15,13e15.5)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::: Calculating new epsilon and omegastar values using parallel track data:::::::::::!
do i=1, M
mu=(B_value)*(R**3.0)
omegastar(i)=((G*Mstar)**((-5.0)/7.0))*(2.0*pi*nustar)*((Mtipik(i)*Medd)**((-3.0)/7.0))*(mu**(6.0/7.0))
omega_k(i)=2.0*pi*nustar/omegastar(i)

if(Tip .eq. 1) then
A_1=2.0*pi*kappa(i)/omega_k(i)
else if(Tip .eq. 2) then
A_1=2.0*pi*kappa_minus(i)/omega_k(i)
end if

A_2=((A_1**2.0)/(2.0*omegastar(i)))-(2.0*omegastar(i))+1.5

eps(i)=sqrt((1.0-omegastar(i))/((abl_value)*(A_2)))
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::: Nonlinear Least Square Fit To Data Using Levenberg-Marquardt Method :::::::::::::::!

! Standard error of every data
do i=1,M
eps_fit_function(i)=(x(1)*(Mtipik(i)**(2.0/7.0)))+(x(2)*(Mtipik(i)**(9.0/7.0)))+(x(3)*(Mtipik(i)**(10.0/7.0)))
dif(i)=eps(i)-eps_fit_function(i)
B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
ChiSquare_min=ChiSquare

! Let the iterations begin HAHAHAHAHA
do onur=1,100

! Standard error of every data
do i=1,M
eps_fit_function(i)=(x(1)*(Mtipik(i)**(2.0/7.0)))+(x(2)*(Mtipik(i)**(9.0/7.0)))+(x(3)*(Mtipik(i)**(10.0/7.0)))
dif(i)=eps(i)-eps_fit_function(i)
B_Vector(i)=dif(i)
do j=1,N
A_Matrix(i,j)=Mtipik(i)**(power(j))
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
do i=1,M
eps_fit_function_new(i)=((x(1)+delta_x(1))*(Mtipik(i)**(2.0/7.0)))+((x(2)+delta_x(2))*(Mtipik(i)**(9.0/7.0)))&
+((x(3)+delta_x(3))*(Mtipik(i)**(10.0/7.0)))
dif_new(i)=eps(i)-eps_fit_function_new(i)
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


!::::::::::::::::::::::::: Linear Regression Coefficient Calculations :::::::::::::::::::::::::::::!
do i=1,M

A=2.0*((G*Mstar)**(-5.0/7.0))*((mu)**(6.0/7.0))*(2.0*pi*nustar)
A1=(Medd**(-3.0/7.0))*(A)*((Mtipik(i))**(-3.0/7.0))
F(i)=((Mtipik(i))**(3.0/14.0))*sqrt(A1-1.5+((1.0-(A1/2.0))/((eps(i)**2.0)*(abl_value))))

eps_fit(i)=z(1)*((Mtipik(i))**(2.0/7.0))+z(2)*((Mtipik(i))**(9.0/7.0))+z(3)*((Mtipik(i))**(10.0/7.0))
F_fit(i)=((Mtipik(i))**(3.0/14.0))*sqrt(A1-1.5+((1.0-(A1/2.0))/((eps_fit(i)**2.0)*(abl_value))))

Katsayi_1=Katsayi_1+(S_A_old(i)*F(i))
Katsayi_2=Katsayi_2+S_A_old(i)
Katsayi_3=Katsayi_3+F(i)
Katsayi_4=Katsayi_4+((F(i))**(2.0))

Katsayi_5=Katsayi_5+(S_A_old(i)*F_fit(i))
Katsayi_6=Katsayi_6+S_A_old(i)
Katsayi_7=Katsayi_7+F_fit(i)
Katsayi_8=Katsayi_8+((F_fit(i))**(2.0))

S_A_top=S_A_top+S_A_old(i)
F_top1=F_top1+F(i)
F_top2=F_top2+F_fit(i)
end do

y(2)=((M*Katsayi_1)-(Katsayi_2*Katsayi_3))/((M*Katsayi_4)-((Katsayi_3)**(2.0)))
y(1)=(S_A_top/M)-(y(2)*F_top1/M)

t(2)=((M*Katsayi_5)-(Katsayi_6*Katsayi_7))/((M*Katsayi_8)-((Katsayi_7)**(2.0)))
t(1)=(S_A_top/M)-(t(2)*F_top2/M)

!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::: eps_Fit fonksiyonunun ve S_A parametresine fit değer dizisi :::::::::::::::::::::!
do i=1, M
S_A(i)=y(1)+y(2)*F(i)
S_A_fit(i)=t(1)+t(2)*F_fit(i)
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::::::Calculation of ChiSquare:::::::::::::::::::::::::::::::::::::::::!
! Standard error of every data
do i=1,M
eps_fit_function(i)=(z(1)*(Mtipik(i)**(2.0/7.0)))+(z(2)*(Mtipik(i)**(9.0/7.0)))+(z(3)*(Mtipik(i)**(10.0/7.0)))
dif(i)=eps(i)-eps_fit_function(i)
B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!::::::::::::::::::::::::::::: Writing Values of Parameters To Data File ::::::::::::::::::::::::::!

if(z(2) .gt. 0.0 .and. z(3) .lt. 0.0) then

if(i_read .eq. 9) then
write(14,130) i_write,'4U 1608-52',Tip,Mass,R,B_value,abl_value,z(1),z(2),z(3),ChiSquare,y(1),y(2),t(1),t(2)
else if(i_read .eq. 10) then
write(14,130) i_write,'4U 1636-54',Tip,Mass,R,B_value,abl_value,z(1),z(2),z(3),ChiSquare,y(1),y(2),t(1),t(2)
else if(i_read .eq. 11) then
write(14,130) i_write,'4U 1728-34',Tip,Mass,R,B_value,abl_value,z(1),z(2),z(3),ChiSquare,y(1),y(2),t(1),t(2)
else if(i_read .eq. 12) then
write(14,130) i_write,'Aql X-1',Tip,Mass,R,B_value,abl_value,z(1),z(2),z(3),ChiSquare,y(1),y(2),t(1),t(2)
end if

close(i_read)
close(i_write)
i_write=i_write+1
end if
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

end subroutine

function B_abl_choose(M,Tip,Mass,R,B_value,abl_value,Mtipik,kappa,kappa_minus) result(kedi)
implicit none

integer :: i,M,Tip,kedi
real(8) :: mu,B_value,Mass,R,pi,nustar,G,Mstar,Medd,Msolar,A_1,A_2,abl_value
real(8), dimension(4000) :: omegastar,omega_k,kappa,kappa_minus,eps,Mtipik

kedi=0
pi=4.0*ATAN(1.0)
G=6.67*(10.0**(-8.0))
Msolar=2.0*(10**(33.0))
Mstar=Mass*Msolar
Medd=10**18.0
nustar=300.0

!:::::::::::::::: Finding the B-abl Couple To Imitate the Parallel Track Data :::::::::::::::::::::!
do i=1,M

mu=(B_value)*(R**3.0)
omegastar(i)=((G*Mstar)**((-5.0)/7.0))*(2.0*pi*nustar)*((Mtipik(i)*Medd)**((-3.0)/7.0))*(mu**(6.0/7.0))
omega_k(i)=2.0*pi*nustar/omegastar(i)

if(Tip .eq. 1) then
A_1=2.0*pi*kappa(i)/omega_k(i)
else if(Tip .eq. 2) then
A_1=2.0*pi*kappa_minus(i)/omega_k(i)
end if

A_2=((A_1**2.0)/(2.0*omegastar(i)))-(2.0*omegastar(i))+1.5

eps(i)=sqrt((1.0-omegastar(i))/((abl_value)*(A_2)))

if(eps(i) .lt. 0.1 .and. omegastar(i) .lt. 1.0) then
kedi=kedi+1
end if

end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

end function 

subroutine DataManipulation
implicit none

integer :: i,io,say
real, dimension(10000000) :: Mass,R,B_value,abl_value,a,b,c,d,e,f,g,ChiSquare
character*15, dimension(10000000) :: Source
integer, dimension(10000000) :: FileNo,Tip

open(unit=8,file='ParallelTrack_M_R.dat')

100 format(1i15,1a15,1i15,13e15.5)

say=0
do
read(8,100,iostat=io) FileNo(1),Source(1),Tip(1),Mass(1),R(1),B_value(1),&
abl_value(1),a(1),b(1),c(1),ChiSquare(1),d(1),e(1),f(1),g(1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
say=say+1
end if
end do
close(8)

open(unit=8,file='ParallelTrack_M_R.dat')
open(unit=9,file='ParallelTrack_M_R_1608.dat')
open(unit=10,file='ParallelTrack_M_R_1636.dat')
open(unit=11,file='ParallelTrack_M_R_1728.dat')
open(unit=12,file='ParallelTrack_M_R_Aql.dat')

do i=1,say
read(8,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),&
a(i),b(i),c(i),ChiSquare(i),d(i),e(i),f(i),g(i)

if(Tip(i) .eq. 1) then

if(Source(i) .eq. '     4U 1608-52') then
write(9,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),&
a(i),b(i),c(i),ChiSquare(i),d(i),e(i),f(i),g(i)

else if(Source(i) .eq. '     4U 1636-54') then
write(10,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),&
a(i),b(i),c(i),ChiSquare(i),d(i),e(i),f(i),g(i)

else if(Source(i) .eq. '     4U 1728-34') then
write(11,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),&
a(i),b(i),c(i),ChiSquare(i),d(i),e(i),f(i),g(i)

else if(Source(i) .eq. '        Aql X-1') then
write(12,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),&
a(i),b(i),c(i),ChiSquare(i),d(i),e(i),f(i),g(i)

end if
end if
end do

do i=1,5
close(i+7)
end do
end subroutine
