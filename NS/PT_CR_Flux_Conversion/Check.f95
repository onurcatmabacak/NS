program main
implicit none

integer :: i,j,k,m,Number_of_Lines(2),DataLineCounter
real(8), dimension(1000) :: Count_Rate,Luminosity,Frequency_1,Frequency_2
real(8) :: Distance,top,Conversion_Factor,pi,Kiloparsec,Dummy(2),Luminosity_Eddington,Onur
character*30 :: Filename(3)

pi=4.0*atan(1.0)
Kiloparsec=3.086E+21
Luminosity_Eddington=2.5E+38

do m=1,4

if(m .eq. 1) then
Onur=1.0
Distance=3.6*Kiloparsec
Distance=Distance**2.0
Filename(1)='4U_1608_52.txt'
Filename(2)='1608_52_nu_1.txt'
Filename(3)='1608_52.txt'

else if(m .eq. 2) then
Onur=1.0
Distance=5.5*Kiloparsec
Distance=Distance**2.0
Filename(1)='4U_1636_54.txt'
Filename(2)='1636_54_nu_1.txt'
Filename(3)='1636_54.txt'

else if(m .eq. 3) then
Onur=5.0
Distance=4.3*Kiloparsec
Distance=Distance**2.0
Filename(1)='4U_1728_34.txt'
Filename(2)='1728_34_nu_1.txt'
Filename(3)='1728_34.txt'

else if(m .eq. 4) then
Onur=5.0
Distance=3.4*Kiloparsec
Distance=Distance**2.0
Filename(1)='Aql_X_1.txt'
Filename(2)='Aql_X_1_nu_1.txt'
Filename(3)='Aql.txt'

end if

100 format(10es15.5)
101 format(10a15)

write(12,101) 'Count_Rate','F_1','Lum','F_2','Con. Fac.'

Number_of_Lines(1)=DataLineCounter(Filename(1))
Number_of_Lines(2)=DataLineCounter(Filename(2))

open(10,file=Filename(1))
do i=1,Number_of_Lines(1)
  read(10,*) Count_Rate(i),Frequency_1(i)
end do

open(11,file=Filename(2))
do j=1,Number_of_Lines(2)
  read(11,*) Luminosity(j),Frequency_2(j),Dummy(1),Dummy(2)
  Luminosity(j)=Luminosity(j)*Luminosity_Eddington
end do

open(12,file=Filename(3))

k=0
top=0.0

do i=1,Number_of_Lines(1)
  do j=1,Number_of_Lines(2)
  
    if(abs(Frequency_1(i)-Frequency_2(j)) .lt. Onur) then
      k=k+1
      Conversion_Factor=(Luminosity(j))/(4.0*pi*Distance*Count_Rate(i))
      top=top+Conversion_Factor
      write(12,100) Count_Rate(i),Frequency_1(i),Luminosity(j)/Luminosity_Eddington,Frequency_2(j),Conversion_Factor
    end if
  
  end do
end do

close(10)
close(11)
close(12)

write(*,100) top/k

end do
end program main

function DataLineCounter(Filename) result(M)

integer :: M
character*30 :: FileName

open(1,file=FileName)
M=0
do
  read(1,*,iostat=io)
  
  if(io .gt. 0) then
    exit
  else if(io .lt. 0) then
    exit
  else if(io .eq. 0) then
  
  M=M+1
  end if

end do
close(1)
end function
