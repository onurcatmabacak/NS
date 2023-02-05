program EOS
implicit none

integer :: Number_of_Lines,io,i
real(8) :: a,b,C
real(8), dimension(10000) :: Radius,Mass,Mass_min,Compactness

open(10,file='AP3.dat')
Number_of_Lines=0
do
read(10,*,iostat=io) a,b
if(io .gt. 0) then
write(*,*) "Houston we have a problem!!!",io
exit
else if(io .lt. 0) then
write(*,*) "End of File, Bitch!!!"
exit
else if(io .eq. 0) then
Number_of_Lines=Number_of_Lines+1
end if
end do
close(10)

open(10,file='AP3.dat')
open(11,file='AP3_new.dat')

C=1.08

do i=1,Number_of_Lines

read(10,*) Radius(i),Mass(i)
Compactness(i)=10.0*Mass(i)/Radius(i)
Mass_min(i)=((Radius(i)/10.0)**(3.0))*((C)**(-2.0))*(0.619**2.0)

if(Mass(i) .gt. Mass_min(i)) then
write(11,100) Radius(i)/10.0,Mass(i),Compactness(i)
100 format(3e15.5)
end if

end do

close(10)
close(11)
end program EOS
