program main
implicit none

integer :: i,Number_of_Lines,DataLineCounter
real(8), dimension(2000) :: Upper_QPO,Lower_QPO,Flux,Delta_Nu,Count_Rate
real(8) :: ret,Conversion_Factor,pi
real(8) :: y0,A1,A2,w1,w2,xc1,xc2
Character*50 :: Filename(2)

Data Filename / '4U_1608_52.txt','4U_1608_52_Gaussian.dat' /

Conversion_Factor=4.49754E-12
Number_of_Lines=DataLineCounter(Filename(1))

open(10,file=Filename(1))
open(11,file=Filename(2))
100 format(10es15.5)

pi=4.0*atan(1.0)
y0=117.9
A1=215993.1
w1=815.3
xc1=395.5
A2=3906.0
w2=63.9
xc2=717.5

do i=1,Number_of_Lines
 read(10,*) Count_Rate(i),Lower_QPO(i)
 Flux(i)=Count_Rate(i)*Conversion_Factor
 Delta_Nu(i)=y0+sqrt(2.0/pi)*A1/w1*exp(-2.0*(Lower_QPO(i)-xc1)**2.0/w1**2.0)+&
 &sqrt(2.0/pi)*A2/w2*exp(-2.0*(Lower_QPO(i)-xc2)**2.0/w2**2.0)
 Upper_QPO(i)=Lower_QPO(i)+Delta_Nu(i)
 write(11,100) Count_Rate(i),Delta_Nu(i)+(rand(0)-0.5)*30.0,Lower_QPO(i),Upper_QPO(i)
end do
close(10)
close(11)
ret=system('gnuplot Gnuplot.gp')
end program main

function DataLineCounter(Filename) result(M)

integer :: M
character*30 :: FileName

open(10,file=FileName)
M=0
do
    read(10,*,iostat=io)
    
    if(io .gt. 0) then
        exit
    else if(io .lt. 0) then
        exit
    else if(io .eq. 0) then
    
    M=M+1
    end if

end do
close(10)
end function

