program main
implicit none

integer :: i,Number_of_Lines,DataLineCounter
real(8), dimension(2000) :: Lower_QPO,Flux,Count_Rate,Upper_QPO,Delta_Nu
real(8) :: ret,Conversion_Factor,pi,y0,A1,A2,w1,w2,xc1,xc2
Character*50 :: Filename(2)

Data Filename / '4U_1728_34.txt','4U_1728_34_Gaussian.dat' /

Conversion_Factor=3.95E-12
Number_of_Lines=DataLineCounter(Filename(1))

open(10,file=Filename(1))
open(11,file=Filename(2))
100 format(4es15.5)

pi=4.0*atan(1.0)
!Gaussian
A1=1.855371051892497e+07
xc1=6.501312071483153e+02
w1=2.805306705892856e+03
A2=3.843595532021556e+03
xc2=8.225521243149955e+02
w2=6.731730114846604e+01
y0=-4.923612783963851e+03

do i=1,Number_of_Lines
    read(10,*) Count_Rate(i),Lower_QPO(i)
    Flux(i)=Count_Rate(i)*Conversion_Factor
!Gaussian
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

