program Arrange
implicit none

integer :: i,j,io,Number_of_Lines
real, dimension(5000) :: Mass,Radius,Sum_Mass_Radius
real :: Constant_Mass,Constant_Radius,Constant

open(10,file='Arrange.dat')
open(11,file='AP4.dat')

100 format(2e15.5)

Number_of_Lines=0
do
read(11,100,iostat=io) Radius(1),Mass(1) 

if(io .gt. 0) then
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
Number_of_Lines=Number_of_Lines+1
end if
end do
close(11)

open(11,file='AP4.dat')
do i=1,Number_of_Lines
read(11,100) Radius(i),Mass(i)
Sum_Mass_Radius(i)=Mass(i)+Radius(i)
end do
close(11)

do i=1,Number_of_Lines
do j=i+1,Number_of_Lines

if(Sum_Mass_Radius(i) .le. Sum_Mass_Radius(j)) then
Constant_Mass=Mass(i)
Constant_Radius=Radius(i)
Constant=Sum_Mass_Radius(i)
Mass(i)=Mass(j)
Radius(i)=Radius(j)
Sum_Mass_Radius(i)=Sum_Mass_Radius(j)
Mass(j)=Constant_Mass
Radius(j)=Constant_Radius
Sum_Mass_Radius(j)=Constant
end if

end do
end do

do i=1,Number_of_Lines
write(10,110) Mass(i),Radius(i),Sum_Mass_Radius(i)
110 format(3e15.5)
end do

close(10)
end program Arrange
