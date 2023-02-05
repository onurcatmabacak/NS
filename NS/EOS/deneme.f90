program deneme
implicit none

call number_generation
call data_manipulation

end program deneme

subroutine number_generation
implicit none

real :: i,j

open(10,file='deneme.dat')
100 format(2e15.5)

i=1.0
do while(i .le. 10.0)
j=1.0
do while(j .le. 10.0)

write(10,100) i,j

j=j+1.0
end do
i=i+1.0
end do

close(10)

end subroutine number_generation

subroutine data_manipulation
implicit none

integer :: onur,onder,m,k,i,j=1,io
real, dimension(1000) :: a,b,c,d

open(10,file='deneme.dat')
100 format(2e15.5)
110 format(1i15,2e15.5)
onur=0
do
read(10,100,iostat=io) a(1),b(1)

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
onur=onur+1
end if
end do
close(10)

open(10,file='deneme.dat')
open(11,file='deneme_1.dat')

do i=1,onur

read(10,100) a(i),b(i)
if(i .eq. 1) then
c(j)=a(i)
d(j)=b(i)
else if(i .gt. 1) then

m=0
do k=1,i-1
if(a(i) .eq. a(i-k)) then
m=m+1
end if
end do

if(m .eq. 0) then 
j=j+1
c(j)=a(i)
d(j)=b(i)

onder=j
end if
end if
end do

write(*,*) onder

do j=1,onder
write(11,110) j,c(j),d(j)
end do

close(10)
close(11)

end subroutine data_manipulation
