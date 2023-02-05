program main
implicit none

integer :: i,j,Number_of_Lines,DataLineCounter
real(8), dimension(2000) :: Lower_QPO,Flux,Count_Rate,Upper_QPO,Delta_Nu
real(8) :: ret,Conversion_Factor,pi
real(8) :: A,xc,w,y0
Character*50 :: Filename(2)

Data Filename / '4U_1636_54.txt','4U_1636_54_Gaussian_1.dat' /

Conversion_Factor=4.6E-12
Number_of_Lines=DataLineCounter(Filename(1))

open(10,file=Filename(1))
open(11,file=Filename(2))

100 format(4es15.5)

pi=4.0*atan(1.0)

A=1.626936362068560e+04
xc=6.803744020477360e+02
w=1.433975375340228e+02
y0=2.462170905411685e+02

do i=1,Number_of_Lines
    read(10,*) Count_Rate(i),Lower_QPO(i)
    Flux(i)=Count_Rate(i)*Conversion_Factor
!Gaussian 1
    Delta_Nu(i)=y0+A*sqrt(2.0/pi)/w*exp(-2.0*((Lower_QPO(i)-xc)/w)**2.0)
    Upper_QPO(i)=Lower_QPO(i)+Delta_Nu(i)
    write(12,100) Count_Rate(i),Delta_Nu(i)+(rand(0)-0.5)*30.0,Lower_QPO(i),Upper_QPO(i)
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

