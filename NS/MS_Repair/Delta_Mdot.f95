program main
implicit none

integer :: i,k,DataLineCounter,Number_of_Lines
real(8), dimension(1000) :: Luminosity,Lower_QPO,Luminosity_Error_Left,Luminosity_Error_Right
real(8), dimension(1000) :: Mdot,Kepler_Frequency,Radius_Alfven,Delta_min,Delta_max
real(8) :: Luminosity_Eddington,Gravitational_Constant,pi
real(8), dimension(10) :: Mass,Radius,Magnetic_Field,Deltanu_min,Deltanu_max
character*30, dimension(10) :: Filename,File_name

Data Mass / 1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0 /
Data Radius / 1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1,1.1 /
Data Magnetic_Field / 0.87,1.09,0.58,1.3,3.3,0.35,9.85,16.0,8.5,1.75 /
Data Deltanu_min / 231.0,224.0,217.0,298.0,233.0,260.0,280.0,232.0,230.0,232.0 / !232 344 gx5-1
Data Deltanu_max / 404.0,327.0,329.0,298.0,296.0,297.0,380.0,344.0,380.0,337.0 /
Data Filename / '0614+09 nu_1.txt','1608-52 nu_1.txt','1636-54 nu_1.txt','1705-44 nu_1.txt','1820-30 nu_1.txt',&
'Aql X-1 nu_1.txt','CygX-2 nu_1.txt','GX5-1 nu_1.txt','GX17+2 nu_1.txt','XTE J1701-462 nu_1.txt' /
Data File_name / '0614+09_new.txt','1608-52_new.txt','1636-54_new.txt','1705-44_new.txt','1820-30_new.txt',&
'Aql X-1_new.txt','CygX-2_new.txt','GX5-1_new.txt','GX17+2_new.txt','XTE J1701-462_new.txt' /

Luminosity_Eddington=2.5E+38
Gravitational_Constant=6.67E-08
Mass=Mass*2.0E+33
Radius=Radius*1.0E+06
Magnetic_Field=Magnetic_Field*1.0E+08
pi=4.0*atan(1.0)

do k=1,10
  
  Number_of_Lines=DataLineCounter(Filename(k))
  open(10,file=Filename(k))
  open(11,file=File_name(k))
  do i=1,Number_of_Lines
    read(10,*) Luminosity(i),Lower_QPO(i),Luminosity_Error_Left(i),Luminosity_Error_Right(i)
    Luminosity(i)=Luminosity(i)*Luminosity_Eddington
    Mdot(i)=(Luminosity(i)*Radius(k))/(Gravitational_Constant*Mass(k))
    Radius_Alfven(i)=((Gravitational_Constant*Mass(k))**(-1.0/7.0))*((Mdot(i))**(-2.0/7.0))*&
    ((Magnetic_Field(k))**(4.0/7.0))*((Radius(k))**(12.0/7.0))
    Kepler_Frequency(i)=(sqrt((Gravitational_Constant*Mass(k))/(Radius_Alfven(i)**3.0)))/(2.0*pi)
    !Delta_min(i)=(2.0*((Kepler_Frequency(i)/Deltanu_min(k))-1.0))/((((Lower_QPO(i)/Deltanu_min(k))+1.0)**(2.0))-4.0)
    !Delta_max(i)=(2.0*((Kepler_Frequency(i)/Deltanu_max(k))-1.0))/((((Lower_QPO(i)/Deltanu_max(k))+1.0)**(2.0))-4.0)
    Delta_min(i)=(2.0*((Kepler_Frequency(i)/Deltanu_min(k))-1.0))/((((Lower_QPO(i)/Deltanu_min(k))+1.0)**(2.0))-4.0+&
    (3.0*Kepler_Frequency(i)/Deltanu_min(k)))
    Delta_max(i)=(2.0*((Kepler_Frequency(i)/Deltanu_max(k))-1.0))/((((Lower_QPO(i)/Deltanu_max(k))+1.0)**(2.0))-4.0+&
    (3.0*Kepler_Frequency(i)/Deltanu_max(k)))
    write(11,100) Luminosity(i),Mdot(i),Radius_Alfven(i),Kepler_Frequency(i),Delta_min(i),Delta_max(i)
    100 format(10es15.5)
  end do
  close(10) 
  close(11)
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
