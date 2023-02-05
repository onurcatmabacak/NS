program ParallelTrackDataSeparation
implicit none

real, dimension(2) :: a_1,a_2,a_3,H_1,H_2,H_3

data a_1 / 0.01, 0.01 /
data a_2 / 0.1, 0.01 /
data a_3 / 0.1, 0.01 /
data H_1 / 0.01, 0.01 /
data H_2 / 0.05, 0.01 /
data H_3 / 0.05, 0.01 /

call Fit_Parameters_Manipulation_1608_1636_abl
!call Fit_Parameters_Manipulation_1608_1728_abl
!call Fit_Parameters_Manipulation_1608_Aql_abl
call PT_1608_1636_abl(a_1,H_1)
!call PT_1608_1728_abl(a_2,H_2)
!call PT_1608_Aql_abl(a_3,H_3)
!call PT_1608_M_R

end program ParallelTrackDataSeparation

subroutine Fit_Parameters_Manipulation_1608_1636_abl
implicit none

integer :: i,M,io
real, dimension(1000000) :: Mass,R,B_value,abl_value,a,b,c,d,e,f,g,x_1,x_2,x_3
character*15, dimension(1000000) :: Source
integer, dimension(1000000) :: FileNo,Tip
real :: A1,A2,pi,Mdot_min,Mdot_max,Mdot_18,Alfven_radius_18,r_in_min,r_in_max
real :: H_typical_min,H_typical_max,Grav_cons,Msolar,c_light,kappa_es,Sch_radius

open(10,file='ParallelTrack_M_R_1608_1636_abl.dat')
open(11,file='Data1_4U_1608_52_abl_Tip1.dat')
open(12,file='Data1_4U_1636_54_abl_Tip1.dat')
open(13,file='Data1_4U_1608_52_abl_Tip2.dat')
open(14,file='Data1_4U_1636_54_abl_Tip2.dat')

M=0
do
read(10,100,iostat=io) FileNo(1),Source(1),Tip(1),Mass(1),R(1),B_value(1),abl_value(1),a(1),b(1),c(1),d(1),e(1),f(1),g(1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
M=M+1
end if
end do
close(10)

open(10,file='ParallelTrack_M_R_1608_1636_abl.dat')
100 format(1i15,1a15,1i15,11e15.5)
110 format(11e15.5)
do i=1,M
read(10,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),a(i),b(i),c(i),d(i),e(i),f(i),g(i)

Grav_cons=6.67*(10**(-8.0))
Msolar=2.0*(10**33.0)
Mdot_18=10**18.0
c_light=3.0*(10**10.0)
kappa_es=0.4
pi=4.0*ATAN(1.0)
Mdot_min=0.4
Mdot_max=0.65

Alfven_radius_18=((Mdot_18)**(-2.0/7.0))*((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
Sch_radius=2.0*Grav_cons*Mass(i)*Msolar/(c_light**2.0)
A1=(3.0*kappa_es*Mdot_18)/(8.0*pi*c_light*Alfven_radius_18)
x_1(i)=b(i)/A1
x_2(i)=-c(i)*sqrt(Alfven_radius_18/(3.0*Sch_radius))/b(i)
x_3(i)=a(i)*Alfven_radius_18/(10**6.0)
A2=A1*x_2(i)*sqrt(3.0*Sch_radius/Alfven_radius_18)
r_in_min=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_max*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
r_in_max=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_min*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
H_typical_min=r_in_min*((b(i)*(Mdot_min**(9.0/7.0)))+(c(i)*(Mdot_min**(10.0/7.0)))+(a(i)*(Mdot_min**(2.0/7.0))))
H_typical_max=r_in_max*((b(i)*(Mdot_max**(9.0/7.0)))+(c(i)*(Mdot_max**(10.0/7.0)))+(a(i)*(Mdot_max**(2.0/7.0))))

if(Tip(i) .eq. 1) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(11,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '     4U 1636-54') then
write(12,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

else if(Tip(i) .eq. 2) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(13,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '     4U 1636-54') then
write(14,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

end if
end do

do i=10,14
close(i)
end do

end subroutine

subroutine Fit_Parameters_Manipulation_1608_1728_abl
implicit none

integer :: i,M,io
real, dimension(1000000) :: Mass,R,B_value,abl_value,a,b,c,d,e,f,g,x_1,x_2,x_3
character*15, dimension(1000000) :: Source
integer, dimension(1000000) :: FileNo,Tip
real :: A1,A2,pi,Mdot_min,Mdot_max,Mdot_18,Alfven_radius_18,r_in_min,r_in_max
real :: H_typical_min,H_typical_max,Grav_cons,Msolar,c_light,kappa_es,Sch_radius

open(10,file='ParallelTrack_M_R_1608_1728_abl.dat')
open(11,file='Data2_4U_1608_52_abl_Tip1.dat')
open(12,file='Data2_4U_1728_34_abl_Tip1.dat')
open(13,file='Data2_4U_1608_52_abl_Tip2.dat')
open(14,file='Data2_4U_1728_34_abl_Tip2.dat')

M=0
do
read(10,100,iostat=io) FileNo(1),Source(1),Tip(1),Mass(1),R(1),B_value(1),abl_value(1),a(1),b(1),c(1),d(1),e(1),f(1),g(1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
M=M+1
end if
end do
close(10)

open(10,file='ParallelTrack_M_R_1608_1728_abl.dat')
100 format(1i15,1a15,1i15,11e15.5)
110 format(11e15.5)
do i=1,M
read(10,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),a(i),b(i),c(i),d(i),e(i),f(i),g(i)

Grav_cons=6.67*(10**(-8.0))
Msolar=2.0*(10**33.0)
Mdot_18=10**18.0
c_light=3.0*(10**10.0)
kappa_es=0.4
pi=4.0*ATAN(1.0)
Mdot_min=0.35
Mdot_max=0.55

Alfven_radius_18=((Mdot_18)**(-2.0/7.0))*((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
Sch_radius=2.0*Grav_cons*Mass(i)*Msolar/(c_light**2.0)
A1=(3.0*kappa_es*Mdot_18)/(8.0*pi*c_light*Alfven_radius_18)
x_1(i)=b(i)/A1
x_2(i)=-c(i)*sqrt(Alfven_radius_18/(3.0*Sch_radius))/b(i)
x_3(i)=a(i)*Alfven_radius_18/(10**6.0)
A2=A1*x_2(i)*sqrt(3.0*Sch_radius/Alfven_radius_18)
r_in_min=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_max*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
r_in_max=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_min*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
H_typical_min=r_in_min*((b(i)*(Mdot_min**(9.0/7.0)))+(c(i)*(Mdot_min**(10.0/7.0)))+(a(i)*(Mdot_min**(2.0/7.0))))
H_typical_max=r_in_max*((b(i)*(Mdot_max**(9.0/7.0)))+(c(i)*(Mdot_max**(10.0/7.0)))+(a(i)*(Mdot_max**(2.0/7.0))))

if(Tip(i) .eq. 1) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(11,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '     4U 1728-34') then
write(12,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

else if(Tip(i) .eq. 2) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(13,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '     4U 1728-34') then
write(14,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

end if
end do

do i=10,14
close(i)
end do

end subroutine

subroutine Fit_Parameters_Manipulation_1608_Aql_abl
implicit none

integer :: i,M,io
real, dimension(1000000) :: Mass,R,B_value,abl_value,a,b,c,d,e,f,g,x_1,x_2,x_3
character*15, dimension(1000000) :: Source
integer, dimension(1000000) :: FileNo,Tip
real :: A1,A2,pi,Mdot_min,Mdot_max,Mdot_18,Alfven_radius_18,r_in_min,r_in_max
real :: H_typical_min,H_typical_max,Grav_cons,Msolar,c_light,kappa_es,Sch_radius

open(10,file='ParallelTrack_M_R_1608_Aql_abl.dat')
open(11,file='Data3_4U_1608_52_abl_Tip1.dat')
open(12,file='Data3_Aql_X_1_abl_Tip1.dat')
open(13,file='Data3_4U_1608_52_abl_Tip2.dat')
open(14,file='Data3_Aql_X_1_abl_Tip2.dat')

M=0
do
read(10,100,iostat=io) FileNo(1),Source(1),Tip(1),Mass(1),R(1),B_value(1),abl_value(1),a(1),b(1),c(1),d(1),e(1),f(1),g(1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
M=M+1
end if
end do
close(10)

open(10,file='ParallelTrack_M_R_1608_Aql_abl.dat')
100 format(1i15,1a15,1i15,11e15.5)
110 format(11e15.5)
do i=1,M
read(10,100) FileNo(i),Source(i),Tip(i),Mass(i),R(i),B_value(i),abl_value(i),a(i),b(i),c(i),d(i),e(i),f(i),g(i)

Grav_cons=6.67*(10**(-8.0))
Msolar=2.0*(10**33.0)
Mdot_18=10**18.0
c_light=3.0*(10**10.0)
kappa_es=0.4
pi=4.0*ATAN(1.0)
Mdot_min=0.15
Mdot_max=0.4

Alfven_radius_18=((Mdot_18)**(-2.0/7.0))*((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
Sch_radius=2.0*Grav_cons*Mass(i)*Msolar/(c_light**2.0)
A1=(3.0*kappa_es*Mdot_18)/(8.0*pi*c_light*Alfven_radius_18)
x_1(i)=b(i)/A1
x_2(i)=-c(i)*sqrt(Alfven_radius_18/(3.0*Sch_radius))/b(i)
x_3(i)=a(i)*Alfven_radius_18/(10**6.0)
A2=A1*x_2(i)*sqrt(3.0*Sch_radius/Alfven_radius_18)
r_in_min=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_max*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
r_in_max=((Grav_cons*Mass(i)*Msolar)**(-1.0/7.0))*((Mdot_min*(10**18.0))**(-2.0/7.0))*((B_value(i)*(R(i)**3.0))**(4.0/7.0))
H_typical_min=r_in_min*((b(i)*(Mdot_min**(9.0/7.0)))+(c(i)*(Mdot_min**(10.0/7.0)))+(a(i)*(Mdot_min**(2.0/7.0))))
H_typical_max=r_in_max*((b(i)*(Mdot_max**(9.0/7.0)))+(c(i)*(Mdot_max**(10.0/7.0)))+(a(i)*(Mdot_max**(2.0/7.0))))

if(Tip(i) .eq. 1) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(11,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '        Aql X-1') then
write(12,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

else if(Tip(i) .eq. 2) then

if(Source(i) .eq. '     4U 1608-52' .and. Mass(i) .ge. 1.0 .and. Mass(i) .le. 2.2) then
write(13,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

else if(Source(i) .eq. '        Aql X-1') then
write(14,110) Mass(i),R(i)/(10**5.0),B_value(i),x_1(i),x_2(i),-x_3(i),3.0*Sch_radius,r_in_min,r_in_max,H_typical_min,H_typical_max

end if

end if
end do

do i=10,14
close(i)
end do

end subroutine

subroutine PT_1608_1636_abl(a_1,H_1)
implicit none

integer :: i,j,k,l=1,m,io,onur(2),sayac(2)
real, dimension(2,5000000) :: Mass,Radius,B_field,x_1,x_2,x_3,r_isco,r_in_min,r_in_max,H_typical_min,H_typical_max
real, dimension(2,5000000) :: y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11
real, dimension(2,5000000) :: z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11
real, dimension(2) :: a_1,H_1

110 format(11e15.5)

!!!!!!!! Counting Number of Lines !!!!!!!!!!!

open(11,file='Data1_4U_1608_52_abl_Tip1.dat')
open(12,file='Data1_4U_1636_54_abl_Tip1.dat')

do i=1,2
onur(i)=0
do
read(i+10,110,iostat=io) Mass(1,1),Radius(1,1),B_field(1,1),x_1(1,1),x_2(1,1),x_3(1,1),&
r_isco(1,1),r_in_min(1,1),r_in_max(1,1),H_typical_min(1,1),H_typical_max(1,1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
onur(i)=onur(i)+1
end if
end do
close(i+10)
end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

open(11,file='Data1_4U_1608_52_abl_Tip1.dat')
open(12,file='Data1_4U_1636_54_abl_Tip1.dat')

open(13,file='Data1_4U_1608_52_abl_Tip1_a_H0.dat')
open(14,file='Data1_4U_1636_54_abl_Tip1_a_H0.dat')

do j=1,2
do i=1,onur(j)
read(j+10,110) Mass(j,i),Radius(j,i),B_field(j,i),x_1(j,i),x_2(j,i),x_3(j,i),&
r_isco(j,i),r_in_min(j,i),r_in_max(j,i),H_typical_min(j,i),H_typical_max(j,i)
end do
end do

! 4U 1608-52 & 4U 1636-54 Type 1
do i=1,onur(1)
do j=1,onur(2)
if(abs(x_1(1,i)-x_1(2,j)) .le. a_1(1) .and. abs(x_3(1,i)-x_3(2,j)) .le. H_1(1)) then

y1(1,l)=Mass(1,i)
y2(1,l)=Radius(1,i)
y3(1,l)=B_field(1,i)
y4(1,l)=x_1(1,i)
y5(1,l)=x_2(1,i)
y6(1,l)=x_3(1,i)
y7(1,l)=r_isco(1,i)
y8(1,l)=r_in_min(1,i)
y9(1,l)=r_in_max(1,i)
y10(1,l)=H_typical_min(1,i)
y11(1,l)=H_typical_max(1,i)

y1(2,l)=Mass(2,j)
y2(2,l)=Radius(2,j)
y3(2,l)=B_field(2,j)
y4(2,l)=x_1(2,j)
y5(2,l)=x_2(2,j)
y6(2,l)=x_3(2,j)
y7(2,l)=r_isco(2,j)
y8(2,l)=r_in_min(2,j)
y9(2,l)=r_in_max(2,j)
y10(2,l)=H_typical_min(2,j)
y11(2,l)=H_typical_max(2,j)

l=l+1
sayac(1)=l
end if
end do
end do

do j=1,2
l=1
do i=1,sayac(1)

if(i .eq. 1) then

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

else if(i .gt. 1) then

m=0
do k=1,i-1
if(y1(j,i) .eq. y1(j,i-k) .and. y2(j,i) .eq. y2(j,i-k) .and. y3(j,i) .eq. y3(j,i-k)) then
m=m+1
end if
end do

if(m .eq. 0) then 
l=l+1

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

sayac(2)=l

end if

end if

end do
end do

do j=1,2
do l=1,sayac(2)
write(j+12,110) z1(j,l),z2(j,l),z3(j,l),z4(j,l),z5(j,l),z6(j,l),z7(j,l),z8(j,l),z9(j,l),z10(j,l),z11(j,l)
end do
end do

do i=11,14
close(i)
end do

end subroutine PT_1608_1636_abl

subroutine PT_1608_1728_abl(a_2,H_2)
implicit none

integer :: i,j,k,l=1,m,io,onur(2),sayac(2)
real, dimension(2,5000000) :: Mass,Radius,B_field,x_1,x_2,x_3,r_isco,r_in_min,r_in_max,H_typical_min,H_typical_max
real, dimension(2,5000000) :: y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11
real, dimension(2,5000000) :: z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11
real, dimension(2) :: a_2,H_2

110 format(11e15.5)

!!!!!!!! Counting Number of Lines !!!!!!!!!!!

open(11,file='Data2_4U_1608_52_abl_Tip1.dat')
open(12,file='Data2_4U_1728_34_abl_Tip1.dat')

do i=1,2
onur(i)=0
do
read(i+10,110,iostat=io) Mass(1,1),Radius(1,1),B_field(1,1),x_1(1,1),x_2(1,1),x_3(1,1),&
r_isco(1,1),r_in_min(1,1),r_in_max(1,1),H_typical_min(1,1),H_typical_max(1,1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
onur(i)=onur(i)+1
end if
end do
close(i+10)
end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

open(11,file='Data2_4U_1608_52_abl_Tip1.dat')
open(12,file='Data2_4U_1728_34_abl_Tip1.dat')

open(13,file='Data2_4U_1608_52_abl_Tip1_a_H0_raw.dat')
open(14,file='Data2_4U_1728_34_abl_Tip1_a_H0_raw.dat')

do j=1,2
do i=1,onur(j)
read(j+10,110) Mass(j,i),Radius(j,i),B_field(j,i),x_1(j,i),x_2(j,i),x_3(j,i),&
r_isco(j,i),r_in_min(j,i),r_in_max(j,i),H_typical_min(j,i),H_typical_max(j,i)
end do
end do

! 4U 1608-52 & 4U 1728-34 Type 1
do i=1,onur(1)
do j=1,onur(2)
if(abs(x_1(1,i)-x_1(2,j)) .le. a_2(1) .and. abs(x_3(1,i)-x_3(2,j)) .le. H_2(1)) then

y1(1,l)=Mass(1,i)
y2(1,l)=Radius(1,i)
y3(1,l)=B_field(1,i)
y4(1,l)=x_1(1,i)
y5(1,l)=x_2(1,i)
y6(1,l)=x_3(1,i)
y7(1,l)=r_isco(1,i)
y8(1,l)=r_in_min(1,i)
y9(1,l)=r_in_max(1,i)
y10(1,l)=H_typical_min(1,i)
y11(1,l)=H_typical_max(1,i)

y1(2,l)=Mass(2,j)
y2(2,l)=Radius(2,j)
y3(2,l)=B_field(2,j)
y4(2,l)=x_1(2,j)
y5(2,l)=x_2(2,j)
y6(2,l)=x_3(2,j)
y7(2,l)=r_isco(2,j)
y8(2,l)=r_in_min(2,j)
y9(2,l)=r_in_max(2,j)
y10(2,l)=H_typical_min(2,j)
y11(2,l)=H_typical_max(2,j)

l=l+1
sayac(1)=l
end if
end do
end do

do j=1,2
l=1
do i=1,sayac(1)

if(i .eq. 1) then

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

else if(i .gt. 1) then

m=0
do k=1,i-1
if(y1(j,i) .eq. y1(j,i-k) .and. y2(j,i) .eq. y2(j,i-k) .and. y3(j,i) .eq. y3(j,i-k)) then
m=m+1
end if
end do

if(m .eq. 0) then 
l=l+1

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

sayac(2)=l

end if

end if

end do
end do

do j=1,2
do l=1,sayac(2)
write(j+12,110) z1(j,l),z2(j,l),z3(j,l),z4(j,l),z5(j,l),z6(j,l),z7(j,l),z8(j,l),z9(j,l),z10(j,l),z11(j,l)
end do
end do

do i=11,14
close(i)
end do

end subroutine PT_1608_1728_abl

subroutine PT_1608_Aql_abl(a_3,H_3)
implicit none

integer :: i,j,k,l=1,m,io,onur(2),sayac(2)
real, dimension(2,5000000) :: Mass,Radius,B_field,x_1,x_2,x_3,r_isco,r_in_min,r_in_max,H_typical_min,H_typical_max
real, dimension(2,5000000) :: y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11
real, dimension(2,5000000) :: z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11
real, dimension(2) :: a_3,H_3

110 format(11e15.5)

!!!!!!!! Counting Number of Lines !!!!!!!!!!!

open(11,file='Data3_4U_1608_52_abl_Tip1.dat')
open(12,file='Data3_Aql_X_1_abl_Tip1.dat')

do i=1,2
onur(i)=0
do
read(i+10,110,iostat=io) Mass(1,1),Radius(1,1),B_field(1,1),x_1(1,1),x_2(1,1),x_3(1,1),&
r_isco(1,1),r_in_min(1,1),r_in_max(1,1),H_typical_min(1,1),H_typical_max(1,1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
onur(i)=onur(i)+1
end if
end do
close(i+10)
end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

open(11,file='Data3_4U_1608_52_abl_Tip1.dat')
open(12,file='Data3_Aql_X_1_abl_Tip1.dat')

open(13,file='Data3_4U_1608_52_abl_Tip1_a_H0.dat')
open(14,file='Data3_Aql_X_1_abl_Tip1_a_H0.dat')

do j=1,2
do i=1,onur(j)
read(j+10,110) Mass(j,i),Radius(j,i),B_field(j,i),x_1(j,i),x_2(j,i),x_3(j,i),&
r_isco(j,i),r_in_min(j,i),r_in_max(j,i),H_typical_min(j,i),H_typical_max(j,i)
end do
end do

! 4U 1608-52 & Aql X-1 Type 1
do i=1,onur(1)
do j=1,onur(2)
if(abs(x_1(1,i)-x_1(2,j)) .le. a_3(1) .and. abs(x_3(1,i)-x_3(2,j)) .le. H_3(1)) then

y1(1,l)=Mass(1,i)
y2(1,l)=Radius(1,i)
y3(1,l)=B_field(1,i)
y4(1,l)=x_1(1,i)
y5(1,l)=x_2(1,i)
y6(1,l)=x_3(1,i)
y7(1,l)=r_isco(1,i)
y8(1,l)=r_in_min(1,i)
y9(1,l)=r_in_max(1,i)
y10(1,l)=H_typical_min(1,i)
y11(1,l)=H_typical_max(1,i)

y1(2,l)=Mass(2,j)
y2(2,l)=Radius(2,j)
y3(2,l)=B_field(2,j)
y4(2,l)=x_1(2,j)
y5(2,l)=x_2(2,j)
y6(2,l)=x_3(2,j)
y7(2,l)=r_isco(2,j)
y8(2,l)=r_in_min(2,j)
y9(2,l)=r_in_max(2,j)
y10(2,l)=H_typical_min(2,j)
y11(2,l)=H_typical_max(2,j)

l=l+1
sayac(1)=l
end if
end do
end do


do j=1,2
l=1
do i=1,sayac(1)

if(i .eq. 1) then

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

else if(i .gt. 1) then

m=0
do k=1,i-1
if(y1(j,i) .eq. y1(j,i-k) .and. y2(j,i) .eq. y2(j,i-k) .and. y3(j,i) .eq. y3(j,i-k)) then
m=m+1
end if
end do

if(m .eq. 0) then 
l=l+1

z1(j,l)=y1(j,i)
z2(j,l)=y2(j,i)
z3(j,l)=y3(j,i)
z4(j,l)=y4(j,i)
z5(j,l)=y5(j,i)
z6(j,l)=y6(j,i)
z7(j,l)=y7(j,i)
z8(j,l)=y8(j,i)
z9(j,l)=y9(j,i)
z10(j,l)=y10(j,i)
z11(j,l)=y11(j,i)

sayac(2)=l

end if

end if

end do
end do

do j=1,2
do l=1,sayac(2)
write(j+12,110) z1(j,l),z2(j,l),z3(j,l),z4(j,l),z5(j,l),z6(j,l),z7(j,l),z8(j,l),z9(j,l),z10(j,l),z11(j,l)
end do
end do

do i=11,14
close(i)
end do

end subroutine PT_1608_Aql_abl
