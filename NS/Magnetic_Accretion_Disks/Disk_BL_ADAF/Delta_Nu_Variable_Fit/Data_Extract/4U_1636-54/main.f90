program main
implicit none

integer :: i
real(8), dimension(20) :: Upper_1,Upper_2,Lower_1,Lower_2,Data_1,Data_2


open(10,file='Upper.csv')
open(11,file='Lower.csv')
open(12,file='Data.csv')
open(13,file='Data.dat')
101 format(4es15.5)
do i=1,11

read(10,*) Upper_1(i),Upper_2(i)
read(11,*) Lower_1(i),Lower_2(i)
read(12,*) Data_1(i),Data_2(i)

write(13,101) Data_1(i),Data_2(i),Upper_2(i),Lower_2(i)
end do

close(10)
close(11)
close(12)
close(13)
end program main
