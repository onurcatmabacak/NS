program main
implicit none

integer :: a,i,j,k,io,Number_of_Lines
real(8), dimension(1000) :: Lower_kHz_QPO_Frequency,Mdot,Luminosity,Luminosity_Error_Left
real(8), dimension(1000) :: Luminosity_Error_Right,Mdot_Error_Left,Mdot_Error_Right,MdotoverBSquare
real(8), dimension(15) :: Magnetic_Field,Nustar
integer, dimension(15) :: Selected_Line
real(8) :: Gravitational_Constant,Mass,Radius,Compactness,Mass_Solar,Mdot_Eddington,Luminosity_Eddington,ret
real(8) :: Radius_ISCO,Speed_of_Light,Mdot_min,Mdot_max,pi
real(8) :: Radius_Alfven_min,Radius_Alfven_max,Radius_Corotation,Mass_Star
character*50, dimension(15) :: Source_Name,Mdot_vs_Nu1
character*50, dimension(2) :: EOS_Data_File,EOS_Data_File_Name
character*50, dimension(3) :: Source_State 

Data Source_Name / '0614+09 nu_1.txt','1608-52 nu_1.txt','1636-53 nu_1.txt','1702-42 nu_1.txt','1705-44 nu_1.txt',&
'1728-34 nu_1.txt','1735-44 nu_1.txt','1820-30 nu_1.txt','Aql X-1 nu_1.txt','CygX-2 nu_1.txt','GX5-1 nu_1.txt',&
'GX17+2 nu_1.txt','KS1731-260 nu_1.txt','ScoX-1 nu_1.txt','XTE J1701-462 nu_1.txt' /

Data EOS_Data_File / 'FPS.dat','SQM3.dat' /
Data EOS_Data_File_Name / 'FPS_','SQM3_' /
Data Source_State / 'SubKepler','SuperKepler','Between' /

ret=system('rm Fit.dat')
ret=system('rm All_Sources.dat')

open(1,file='Fit.dat',position='append')

!:::::::::::::::::: ACHTUNG!!!!!!! ::::::::::::::::!
! These values cannot exceed the values given below
! a=  1        2
!    FPS: 44, SMQ3: 27
a=1
Data Selected_Line / 36,25,24,33,33,30,35,33,33,33,38,38,33,33,20 /

Data Magnetic_Field / 0.49,0.46,0.67,0.9,1.0,0.64,0.8,1.5,0.3,4.4,9.0,7.0,0.8,3.8,1.7  /

Data Nustar / 415.0,619.0,581.0,330.0,298.0,363.0,313.0,273.0,549.0,324.0,318.0,282.0,524.0,287.0,258.0 /

Magnetic_Field=Magnetic_Field*1.0E+08
!::::::::::::::::::::::::::::::::::::::::::::::::::!

Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mdot_Eddington=1.0E+18
Luminosity_Eddington=2.5E+38
Speed_of_Light=3.0E+10
pi=4.0*atan(1.0)

100 format(4es15.5)

!:::::::::::::::::::::::::::::Parameters of all sources written in:::::::::::::::::::::::::!

open(500,file='All_Sources.dat',position='append')
write(500,150) 'Source','State','Mass','Radius','Mag Field','Nustar','R_ISCO','R_Alfven_min',&
'R_Alfven_max','R_CO','Fastness_min','Fastness_max'
150 format(2a15,10a15)
!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::: Calculations for Nu_1 frequency ::::::::::::::::::::!

do i=1,15
Mdot_vs_Nu1(i)=trim(adjustl(EOS_Data_File_Name(a)))//trim(adjustl(Source_Name(i)))
open(200+i,file=Mdot_vs_Nu1(i))

!::::::::: Read Mass Radius Compactness Data From EOS_DATA_FILE ::::::::::::!
open(100+a,file=EOS_Data_File(a))
do j=1,Selected_Line(i)
read(100+a,*) Radius,Mass,Compactness
Radius=Radius*1.0E+06
Mass_Star=Mass*Mass_Solar
end do
close(100+a)
!:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

! Count number of lines in the data file
open(10+i,file=Source_Name(i))
Number_of_Lines=0
do
read(10+i,*,iostat=io) Luminosity(1),Lower_kHz_QPO_Frequency(1),Luminosity_Error_Left(1),Luminosity_Error_Right(1)
if(io .gt. 0) then
write(*,*) "Houston we have a problem!!!",io
exit
else if(io .lt. 0) then
exit
else if(io .eq. 0) then
Number_of_Lines=Number_of_Lines+1
end if
end do
close(10+i)
!::::::::::::::::::::::::::::::::::::::::!

! Read all the data in the data file
Luminosity=0.0
Lower_kHz_QPO_Frequency=0.0
Luminosity_Error_Left=0.0
Luminosity_Error_Right=0.0
Mdot=0.0
Mdot_Error_Left=0.0
Mdot_Error_Right=0.0
MdotoverBSquare=0.0

open(10+i,file=Source_Name(i))
do j=1,Number_of_Lines
read(10+i,*) Luminosity(j),Lower_kHz_QPO_Frequency(j),Luminosity_Error_Left(j),Luminosity_Error_Right(j)
Mdot(j)=(Luminosity(j)*Luminosity_Eddington*Radius)/(Gravitational_Constant*Mass_Star)
end do
close(10+i)

Mdot_min=minval(Mdot,(Mdot .gt. 0.0))
Mdot_max=maxval(Mdot,(Mdot .gt. 0.0))

Radius_ISCO=(6.0*Gravitational_Constant*Mass_Star)/(Speed_of_Light**2.0)
Radius_Alfven_min=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*&
((Mdot_max)**(-2.0/7.0))*((Magnetic_Field(i))**(4.0/7.0))*((Radius)**(12.0/7.0))
Radius_Alfven_max=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*&
((Mdot_min)**(-2.0/7.0))*((Magnetic_Field(i))**(4.0/7.0))*((Radius)**(12.0/7.0))
Radius_Corotation=((Gravitational_Constant*Mass_Star)/((2.0*pi*Nustar(i))**(2.0)))**(1.0/3.0)

if(Radius_Alfven_min .lt. Radius_ISCO .or. Radius_Alfven_min .lt. Radius) then
write(*,*) 'Alfven radius is smaller than ISCO or R_NS',i
else
do j=1,Number_of_Lines
MdotoverBSquare(j)=Mdot(j)/(Magnetic_Field(i)**2.0)
Mdot_Error_Left(j)=(Luminosity_Error_Left(j)*Luminosity_Eddington*Radius)/&
(Gravitational_Constant*Mass_Star*(Magnetic_Field(i)**2.0))
Mdot_Error_Right(j)=(Luminosity_Error_Right(j)*Luminosity_Eddington*Radius)/&
(Gravitational_Constant*Mass_Star*(Magnetic_Field(i)**2.0))

write(200+i,100) MdotoverBSquare(j)/100.0,Lower_kHz_QPO_Frequency(j)/1000.0,Mdot_Error_Left(j)/100.0,Mdot_Error_Right(j)/100.0
write(1,100) MdotoverBSquare(j)/100.0,Lower_kHz_QPO_Frequency(j)/1000.0
end do

end if

close(200+i)

if(Radius_Alfven_max .lt. Radius_Corotation .and. Radius_Alfven_min .lt. Radius_Corotation) then
k=1
else if(Radius_Alfven_max .gt. Radius_Corotation .and. Radius_Alfven_min .gt. Radius_Corotation) then
k=2
else
k=3
end if

write(500,200) Source_Name(i),Source_State(k),Mass,Radius,Magnetic_Field(i),Nustar(i),Radius_ISCO,&
Radius_Alfven_min,Radius_Alfven_max,Radius_Corotation,Radius_Alfven_min/Radius_Corotation,Radius_Alfven_max/Radius_Corotation
200 format(1a20,1a11,10es15.5)
end do
close(1)

close(500)

!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

end program main
