program main
implicit none

integer :: Number_of_Lines,i,j,k,l,m(1),Line_Number,DataLineCounter,onur(3000000)
real(8), dimension(3000000) :: Mass,Radius,Magnetic_Field,Magnetic_Moment,Alpha_BL,Eps_max,Eps_min,Delta_max,Delta_min,x1,x2,x3,x4
real(8), dimension(3000000) :: Mdot,Luminosity,Lower_QPO_Frequency,Upper_QPO_Frequency,Epsilon,Omega_Kepler_Alfven
real(8), dimension(3000000) :: Omega_Fastness,Gamma_Phi,Count_Rate,Flux,R_in,Small_a,H_0,C,Delta,Delta_Nu,Omega_R_in,BL_Thickness
real(8) :: Nustar,Gravitational_Constant,Mass_Solar,Mass_star,Speed_of_Light,Conversion_Factor,R_ISCO
real(8) :: pi,Parsec,Kiloparsec,Distance,A_1,A_2
real(8), dimension(4) :: Mass_Select,Radius_Select,Eps_Select
character*100 :: Sample_File(6),Source,Filename(8),SourceName(3000000)

Data Filename / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /

Data Mass_Select / 1.0,1.5,1.5,2.0 /
Data Radius_Select / 1.3E+06,0.8E+06,1.1E+06,1.3E+06 /
Data Eps_Select / 0.09,0.08,0.1,0.09 /

100 format(20es15.5)
do k=1,6
 
  if(k .eq. 4 .or. k .eq. 5) then
  Mass_Select(4)=1.75
  else if(k .eq. 6) then
  Mass_Select(4)=2.0
  end if 
 
  Sample_File(1)=trim(adjustl(Filename(k)))//'.dat'
  Sample_File(2)=trim(adjustl(Filename(k)))//'_Sample_Fit.dat'
  Sample_File(3)=trim(adjustl(Filename(k)))//'_temp_1.dat'
  Sample_File(4)=trim(adjustl(Filename(k)))//'_temp_2.dat'
  Sample_File(5)=trim(adjustl(Filename(k)))//'_temp_3.dat'
  Sample_File(6)=trim(adjustl(Filename(k)))//'_temp_4.dat'
  
  Line_Number=DataLineCounter(Sample_File(1))
  open(10,file=Sample_File(1))
  open(12,file=Sample_File(3))
  open(13,file=Sample_File(4))
  open(14,file=Sample_File(5))
  open(15,file=Sample_File(6))
  
  read(10,*)
 
 
  do i=1,Line_Number-1
    read(10,*) onur(i),SourceName(i),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
    Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
    
    if(Mass(i) .eq. Mass_Select(1) .and. Radius(i) .eq. Radius_Select(1) .and. Eps_max(i) .lt. Eps_Select(1)+0.001 &
    .and. Eps_max(i) .gt. Eps_Select(1)-0.001) then
      write(12,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
      Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)      
    else if(Mass(i) .eq. Mass_Select(2) .and. Radius(i) .eq. Radius_Select(2) .and. Eps_max(i) .lt. Eps_Select(2)+0.001 &
    .and. Eps_max(i) .gt. Eps_Select(2)-0.001) then
      write(13,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
      Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
    else if(Mass(i) .eq. Mass_Select(3) .and. Radius(i) .eq. Radius_Select(3) .and. Eps_max(i) .lt. Eps_Select(3)+0.001 &
    .and. Eps_max(i) .gt. Eps_Select(3)-0.001) then
      write(14,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
      Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
    else if(Mass(i) .eq. Mass_Select(4) .and. Radius(i) .eq. Radius_Select(4) .and. Eps_max(i) .lt. Eps_Select(4)+0.001 &
    .and. Eps_max(i) .gt. Eps_Select(4)-0.001) then
      write(15,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
      Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
    end if
    
  end do
  close(10)
  close(12)
  close(13)
  close(14)
  close(15)
  
  open(11,file=Sample_File(2))
  do j=1,4
    Mass=0.0
    Radius=0.0
    Magnetic_Field=0.0
    Alpha_BL=0.0
    x4=0.0
    x1=0.0
    x2=0.0
    x3=0.0
    Small_a=0.0
    H_0=0.0
    C=0.0
    Eps_max=0.0
    Eps_min=0.0
    Delta_max=0.0
    Delta_min=0.0  
    
    l=DataLineCounter(Sample_File(2+j))
    open(11+j,file=Sample_File(2+j))
  
    do i=1,l
      read(11+j,*) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),&
      Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
    end do
    m=minloc(x4, (x4 .gt. 0.0))
    write(11,100) Mass(m),Radius(m),Magnetic_Field(m),Alpha_BL(m),x4(m),x1(m),x2(m),x3(m),&
    Small_a(m),H_0(m),C(m),Eps_max(m),Eps_min(m),Delta_max(m),Delta_min(m)
    
    close(11+j)
    
  end do
  
  close(11)
  
  open(21,file=trim(adjustl(Filename(k)))//'_Sample_1.dat')
  open(22,file=trim(adjustl(Filename(k)))//'_Sample_2.dat')
  open(23,file=trim(adjustl(Filename(k)))//'_Sample_3.dat')
  open(24,file=trim(adjustl(Filename(k)))//'_Sample_4.dat')
  
  if(k .eq. 1) then
    Nustar=619.0
    Source='4U_1608_52_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=3.6
    Conversion_Factor=4.49754E-12
  else if(k .eq. 2) then
    Nustar=619.0
    Source='4U_1608_52_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=4.22
    Conversion_Factor=4.49754E-12
  else if(k .eq. 3) then
    Nustar=619.0
    Source='4U_1608_52_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=5.0
    Conversion_Factor=4.49754E-12
  else if(k .eq. 4) then
    Nustar=581.0
    Source='4U_1636_54_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=5.5
    Conversion_Factor=4.6E-12
  else if(k .eq. 5) then
    Nustar=581.0
    Source='4U_1636_54_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=7.0
    Conversion_Factor=4.6E-12
  else if(k .eq. 6) then
    Nustar=363.0
    Source='4U_1728_34_Gaussian.dat'
    Line_Number=DataLineCounter(Source)
    Parsec=4.5
    Conversion_Factor=3.95E-12
  end if
  
  Kiloparsec=3.08567758E+21
  Distance=Parsec*Kiloparsec
  pi=4.0*ATAN(1.0)
  
  Number_of_Lines=DataLineCounter(Sample_File(2))
  
  open(10,file=Sample_File(2))
  do i=1,Number_of_Lines
    read(10,*) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),Small_a(i),H_0(i),C(i),&
    Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
  end do
  close(10)
  
  open(unit=11,file=Source)
  do j=1,Line_Number
    read(11,*) Count_Rate(j),Delta_Nu(j),Lower_QPO_Frequency(j),Upper_QPO_Frequency(j)
    Flux(j)=Count_Rate(j)*Conversion_Factor
    Luminosity(j)=4.0*pi*(Distance**2.0)*Flux(j)
  end do
  close(11)
  
  do i=1,Number_of_Lines
    
    !::::::::::::::::::::Constants::::::::::::::::::::!
    Gravitational_Constant=6.67E-08
    Mass_Solar=2.0E+33
    Speed_of_Light=3.0E+10
    Mass_Star=Mass(i)*Mass_Solar
    R_ISCO = 2.0 * Gravitational_Constant * Mass_Star / (Speed_of_Light**2.0)
    !::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
    
    do j=1,Line_Number
      Mdot(j)=(Luminosity(j)*Radius(i))/(Gravitational_Constant*Mass_Star)
      Upper_QPO_Frequency(j)=Lower_QPO_Frequency(j)+Delta_Nu(j)
      Omega_R_in(j)=2.0*pi*Delta_Nu(j)
      Magnetic_Moment(i)=(Magnetic_Field(i))*(Radius(i)**3.0)
      R_in(j)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(j))**(-2.0/7.0))*((Magnetic_Moment(i))**(4.0/7.0))    
      Omega_Kepler_Alfven(j)=((Gravitational_Constant*Mass_Star)**(0.5))*((R_in(j))**(-1.5))
      Omega_Fastness(j)=Omega_R_in(j)/Omega_Kepler_Alfven(j)
      A_1=2.0*pi*Upper_QPO_Frequency(j)/Omega_Kepler_Alfven(j)
      A_2=((A_1**2.0)/(2.0*Omega_Fastness(j)))-(2.0*Omega_Fastness(j))+1.5
      Epsilon(j)=(1.0-Omega_Fastness(j))/((Alpha_BL(i))*(A_2))
      Gamma_Phi(j)=(1.0-Omega_Fastness(j))/(Alpha_BL(i))
      Delta(j)=Epsilon(j)*Alpha_BL(i)
      BL_Thickness(j)=Delta(j)*R_in(j)*1.0E-06
      
      write(20+i,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Mdot(j)*1.0E-18,Epsilon(j),Gamma_Phi(j),Delta(j),&
      Delta_Nu(j)*1.0E-03,Lower_QPO_Frequency(j)*1.0E-03,Delta_Nu(j)/Lower_QPO_Frequency(j),BL_Thickness(j),R_in(j)/R_ISCO,&
      R_in(j)/Radius(i)
    end do  
  end do
  
  close(21)
  close(22)
  close(23)
  close(24)
  
end do
end program main

function DataLineCounter(Filename) result(M)

integer :: M
character*100 :: FileName

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
