program main
implicit none

! under r_in = r_Alfven assumption program calculates all possible eps 
! values that satisfy parallel track data

integer :: i_read,Tip,i_write,Number_of_Lines,N,i,Data_Read,onur,DataLineCounter
real(8), dimension(5000) :: Mdot,Count_Rate,Flux,Luminosity,Lower_QPO,Upper_QPO_Frequency
real(8), dimension(5000) :: rin,Omega_rin,Omega_Kepler_rin,Constant,ABL,Fastness,Epsilon,Delta
real(8) :: Magnetic_Field,Alpha_BL,Mass,Radius,Nustar,Epsilon_Cycle,Omega_Star,Distance,Kiloparsec,Parsec,pi,Mdot_Eddington,A_1,A_2
real(8) :: Gravitational_Constant,Mass_Solar,Mass_Star,Mdot_max,Mdot_min,Speed_of_Light,Magnetic_Moment,Delta_Nu,Conversion_Factor
real(8) :: Magnetic_Field_min,Magnetic_Field_max,Magnetic_Field_step,Magnetic_Field_min_Alfven,Magnetic_Field_min_ISCO
character*100 :: frmt,x ! format descriptor
character(len=50) :: filename,SourceName(5)

read(*,*) Data_Read

Data SourceName / '4U_1608_52.txt','4U_1636_54.txt','4U_1728_34.txt','Aql_X_1_Mendez.txt','Aql_X_1_Barret.txt' /

frmt = '(I100)' ! an integer of width 5 with zeros at the left
write (x,frmt) Data_Read ! converting integer to string using a 'internal file'
filename='Mass_'//trim(adjustl(x))//'.dat'
open(18,file=filename)

N=3
Tip=1
Delta_Nu=300.0

do i_read=14,17
  i_write=500
  !::::::::::::::::::::::::::::::::::::: Data Read From File ::::::::::::::::::::::::::::::::::::::::!
  if(i_read .eq. 8) then
    Number_of_Lines=DataLineCounter(SourceName(1))
    Nustar=619.0
    Parsec=3.6
    Conversion_Factor=4.49754E-12
    open(unit=8,file=SourceName(1))
  else if(i_read .eq. 9) then
    Number_of_Lines=DataLineCounter(SourceName(1))
    Nustar=619.0
    Parsec=4.22
    Conversion_Factor=4.49754E-12
    open(unit=9,file=SourceName(1))
  else if(i_read .eq. 10) then
    Number_of_Lines=DataLineCounter(SourceName(1))
    Nustar=619.0
    Parsec=5.0
    Conversion_Factor=4.49754E-12
    open(unit=10,file=SourceName(1))
  else if(i_read .eq. 11) then
    Number_of_Lines=DataLineCounter(SourceName(2))
    Nustar=581.0
    Parsec=5.5
    Conversion_Factor=4.6E-12
    open(unit=11,file=SourceName(2))
  else if(i_read .eq. 12) then
    Number_of_Lines=DataLineCounter(SourceName(2))
    Nustar=581.0
    Parsec=7.0
    Conversion_Factor=4.6E-12
    open(unit=12,file=SourceName(2))
  else if(i_read .eq. 13) then
    Number_of_Lines=DataLineCounter(SourceName(3))
    Nustar=363.0
    Parsec=4.5
    Conversion_Factor=3.95E-12
    open(unit=13,file=SourceName(3))
  else if(i_read .eq. 14) then
    Number_of_Lines=DataLineCounter(SourceName(4))
    Nustar=549.0
    Parsec=2.5
    Conversion_Factor=2.3E-12
    open(unit=14,file=SourceName(4))
  else if(i_read .eq. 15) then
    Number_of_Lines=DataLineCounter(SourceName(4))
    Nustar=549.0
    Parsec=5.2
    Conversion_Factor=2.3E-12
    open(unit=15,file=SourceName(4))
  else if(i_read .eq. 16) then
    Number_of_Lines=DataLineCounter(SourceName(5))
    Nustar=549.0
    Parsec=2.5
    Conversion_Factor=10.0E-12
    open(unit=16,file=SourceName(5))
  else if(i_read .eq. 17) then
    Number_of_Lines=DataLineCounter(SourceName(5))
    Nustar=549.0
    Parsec=5.2
    Conversion_Factor=10.0E-12
    open(unit=17,file=SourceName(5))
 
  end if
  !::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
  Kiloparsec=3.08567758E+21
  Distance=Parsec*Kiloparsec
  pi=4.0*ATAN(1.0)
  
  do i=1,Number_of_Lines
    read(i_read,*) Count_Rate(i),Lower_QPO(i)
    Flux(i)=Count_Rate(i)*Conversion_Factor
    Luminosity(i)=4.0*pi*(Distance**2.0)*Flux(i)
    Upper_QPO_Frequency(i)=Lower_QPO(i)+Delta_Nu
  end do
  close(i_read)
  
  !::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
  Mass=Data_Read/100.0
  
  Radius=0.7E+06
  do while(Radius .le. 1.6E+06)
    Epsilon_Cycle=0.01
    do while(Epsilon_Cycle .le. 0.1)
      
      Gravitational_Constant=6.67E-08
      Mass_Solar=2.0E+33
      Speed_of_Light=3.0E+10
      Mass_Star=Mass*Mass_Solar
      Mdot_Eddington=1.0E+18
      
      Mdot=0.0
      
      do i=1,Number_of_Lines
        Mdot(i)=(Luminosity(i)*Radius)/(Gravitational_Constant*Mass_Star*Mdot_Eddington) 
      end do
      
      Mdot_min=minval(Mdot,(Mdot .gt. 0.0))
      Mdot_max=maxval(Mdot,(Mdot .gt. 0.0))
      
      ! Alfven radius is bigger than neutron star's radius
      Magnetic_Field_min_Alfven=((Gravitational_Constant*Mass_Star)**(1.0/4.0))*((Mdot_max*Mdot_Eddington)**(1.0/2.0))*&
      ((Radius)**(-5.0/4.0))
      ! Alfven radius is bigger than marginally stable orbit
      Magnetic_Field_min_ISCO=((Gravitational_Constant*Mass_Star)**(2.0))*((Mdot_max*Mdot_Eddington)**(1.0/2.0))*&
      ((Radius)**(-3.0))*(((Speed_of_Light**2.0)/6.0)**(-7.0/4.0))
      
      if(Magnetic_Field_min_Alfven .gt. Magnetic_Field_min_ISCO) then
        Magnetic_Field_min=Magnetic_Field_min_Alfven
      else if(Magnetic_Field_min_Alfven .lt. Magnetic_Field_min_ISCO) then
        Magnetic_Field_min=Magnetic_Field_min_ISCO
      end if
      
      !Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min*Mdot_Eddington)**(1.0/2.0))*&
      !((Radius)**(-3.0))*((2.0*pi*Nustar)**(-7.0/6.0))
      
      ! If inner radius is determined with light cylinder radius instead of corotation radius
      
      Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min*Mdot_Eddington)**(1.0/2.0))*&
      ((Radius)**(-3.0))*((2.0*pi*Delta_Nu)**(-7.0/6.0))
      
      if(Magnetic_Field_max .gt. Magnetic_Field_min) then
      
        Magnetic_Field_step=(Magnetic_Field_max-Magnetic_Field_min)/10.0
        
        Magnetic_Field=Magnetic_Field_min
        do while(Magnetic_Field .lt. Magnetic_Field_max)
        
          ! Find the minimum Alpha_BL that makes it guarantee to satisfy all parallel track data
          Epsilon=0.0          
          ABL=0.0
          onur=0
          Magnetic_Moment=Magnetic_Field*(Radius**3.0)
          Omega_Star=2.0*pi*Nustar
          
          do i=1,Number_of_Lines
            
            Omega_rin(i)=2.0*pi*Delta_Nu
            
            rin(i)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*&
            ((Mdot(i)*Mdot_Eddington)**(-2.0/7.0))*((Magnetic_Moment)**(4.0/7.0))
            
            Omega_Kepler_rin(i)=sqrt((Gravitational_Constant*Mass_Star)/(rin(i)**3.0))
            
            if(Tip .eq. 1) then
              Constant(i)=(((2.0*pi*Upper_QPO_Frequency(i))**(2.0))/(2.0*Omega_rin(i)))-&
              (2.0*Omega_rin(i))+(1.5*Omega_Kepler_rin(i))
            else if(Tip .eq. 2) then
              Constant(i)=(((2.0*pi*Lower_QPO(i))**(2.0))/(2.0*Omega_rin(i)))-&
              (2.0*Omega_rin(i))+(1.5*Omega_Kepler_rin(i))
            end if
                        
            ABL(i)=(Omega_Kepler_rin(i)-Omega_rin(i))/(Epsilon_Cycle*Constant(i))
            
          end do
          
          Alpha_BL=maxval(ABL,(ABL .gt. 0.0))
          
          !:::::::::::::::: Calculating new epsilon and omega values using parallel track data:::::::::::!
          do i=1,Number_of_Lines
            Magnetic_Moment=(Magnetic_Field)*(Radius**3.0)
            rin(i)=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot(i)*Mdot_Eddington)**(-2.0/7.0))*&
            ((Magnetic_Moment)**(4.0/7.0))
            Omega_rin(i)=2.0*pi*Delta_Nu
            Omega_Kepler_rin(i)=((Gravitational_Constant*Mass_Star)**(0.5))*((rin(i))**(-1.5))
            Fastness(i)=Omega_rin(i)/Omega_Kepler_rin(i)
            if(Tip .eq. 1) then
              A_1=2.0*pi*Upper_QPO_Frequency(i)/Omega_Kepler_rin(i)   ! Upper_QPO_Frequency frekansı epsilonun fonksiyonu olduğundan
            else if(Tip .eq. 2) then                                  ! dolayı tip 1 de Upper_QPO_Frequencytip2
                                                                      ! Upper_QPO_Frequency-omega frekansları
              A_1=2.0*pi*Lower_QPO(i)/Omega_Kepler_rin(i)             ! Upper_QPO_Frequency tanımına denk gelmektedir.
            end if
            
            A_2=((A_1**2.0)/(2.0*Fastness(i)))-(2.0*Fastness(i))+1.5
            
            Epsilon(i)=(1.0-Fastness(i))/((Alpha_BL)*(A_2))
            Delta(i)=Epsilon(i)*Alpha_BL
            if(Delta(i) .gt. 0.01 .and. Delta(i) .lt. 0.6) then 
              onur=onur+1
            end if
          end do
          
          !::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
          if(onur .eq. Number_of_Lines) then
            call Fit(Mass,Magnetic_Field,Radius,Alpha_BL,Delta,i_read,i_write,Number_of_Lines,N,Mdot)
          end if
          Magnetic_Field=Magnetic_Field+Magnetic_Field_step
        end do
        
      end if
  
      Epsilon_Cycle=Epsilon_Cycle+0.01
    end do  
    Radius=Radius+1.0E+04
  end do

end do

close(18)
end program main

subroutine Fit(Mass,Magnetic_Field,Radius,Alpha_BL,Delta,i_read,i_write,Number_of_Lines,N,Mdot)
implicit none
! f(x)= z(1) * (x^(2/7)) + z(2) * (x^(9/7)) + z(3) * (x^(10/7)) fonksiyonuna fit için

!::::::::::::::::::::::::::::::::::: Parameters Used ::::::::::::::::::::::::::::::::::::::::::::::!
integer :: i,j,k,N,Number_of_Lines,i_read,i_write,onur

real(8), dimension(5000) :: Mdot,Delta,Delta_Fit_Function,Delta_Fit_Function_new
real(8) :: x(3),z(3),oran,top,Magnetic_Field,Alpha_BL,Mass,Radius
real(8) :: pi,Gravitational_Constant,Mass_Solar,Mass_Star,Mdot_Eddington,Magnetic_Moment
real(8) :: ChiSquare,ChiSquare_new,lambda,TOL,power(3),delta_x(3),ChiSquare_min
real(8) :: A_Matrix(Number_of_Lines,N),B_Vector(Number_of_Lines),B_Vector_new(Number_of_Lines)
real(8) :: Alpha(N,N),Alpha_Prime(N,N),Beta(N),dif(Number_of_Lines),dif_new(Number_of_Lines)
real(8) :: Speed_of_Light,Alfven_Radius_18,Radius_Sch,Capital_A,C,H_0,Small_a,k_es
character*30, dimension(10) :: Source_Name

data Source_Name / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc_Mendez','Aql_X_1_5.2_kpc_Mendez','Aql_X_1_2.5_kpc_Barret','Aql_X_1_5.2_kpc_Barret' /
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::: Initial Values of Parameters ::::::::::::::::::::::::::::::::::::::!
pi=4.0*ATAN(1.0)
Gravitational_Constant=6.67E-08
Mass_Solar=2.0E+33
Mass_Star=Mass*Mass_Solar
Mdot_Eddington=1.0E+18
Speed_of_Light=3.0E+10
k_es=0.4

lambda=1.0E+01
TOL=1.0E-10

data power / 0.28571428571428570,1.2857142857142858,1.4285714285714286 /

do i=1,3
  z(i)=0.0
  delta_x(i)=0.0
end do

data x / 1.0,1.0,-1.0 /

top=0.0
oran=0.0

ChiSquare=0.0
ChiSquare_new=0.0
ChiSquare_min=0.0

do i=1,N
  do j=1,N
    A_Matrix(i,j)=0.0
    Alpha(i,j)=0.0
    Alpha_Prime(i,j)=0.0
  end do
  Beta(i)=0.0
  B_Vector(i)=0.0
  B_Vector_new(i)=0.0
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::: Nonlinear Least Square Fit To Data Using Levenberg-Marquardt Method :::::::::::::::!

! Standard error of every data
do i=1,Number_of_Lines
  Delta_Fit_Function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+(abs(x(2))*(Mdot(i)**(9.0/7.0)))-(abs(x(3))*(Mdot(i)**(10.0/7.0)))
  dif(i)=Delta(i)-Delta_Fit_Function(i)
  B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
ChiSquare_min=ChiSquare

! Let the iterations begin HAHAHAHAHA
do onur=1,1000
  
  ! Standard error of every data
  do i=1,Number_of_Lines
    Delta_Fit_Function(i)=(x(1)*(Mdot(i)**(2.0/7.0)))+(abs(x(2))*(Mdot(i)**(9.0/7.0)))-(abs(x(3))*(Mdot(i)**(10.0/7.0)))
    dif(i)=Delta(i)-Delta_Fit_Function(i)
    B_Vector(i)=dif(i)
    do j=1,N
      A_Matrix(i,j)=Mdot(i)**(power(j))
    end do
  end do
  
  ! Calculations of Gradient (Beta) and Approximated Hessian (Alpha) Matrices
  Alpha=0.5*matmul(transpose(A_Matrix),A_Matrix)
  Beta=0.5*matmul(transpose(A_Matrix),B_Vector)
  
  do i=1,N
    do j=1,N
      
      if(i .eq. j) then
        Alpha_Prime(i,j)=Alpha(i,j)*(1.0+lambda)
      else if(i .ne. j) then
        Alpha_Prime(i,j)=Alpha(i,j)
      end if
      
    end do
  end do
  
  !!!!!!!!!!!!!!!!!!!!!
  !!Gauss Elimination!!
  !!!!!!!!!!!!!!!!!!!!!
  
  ! Diagonalization of the matrix
  do i=1, N-1
    do k=i+1, N
      oran=Alpha_Prime(k,i)/Alpha_Prime(i,i)
      Beta(k)=Beta(k)-(Beta(i)*oran)
      do j=i, N
        Alpha_Prime(k,j)=Alpha_Prime(k,j)-(Alpha_Prime(i,j)*oran)
      end do
    end do
  end do
  
  ! Solution of coefficients in the diagonalized matrix
  do i=N, 1, -1
    top=0.0
    if(i .eq. N) then
      top=0.0
    else if(i .ne. N) then
      do j=i+1,N
        top=top+(Alpha_Prime(i,j)*delta_x(j))
      end do
    end if
    delta_x(i)=(Beta(i)-top)/Alpha_Prime(i,i)
  end do
  
  do i=1,N
    z(i)=x(i)+delta_x(i)
  end do
  
  !:::::::::::::::::::::::::::::::::::::::: ChiSquare_new calculation :::::::::::::::::::::::::::::::!
  do i=1,Number_of_Lines
    Delta_Fit_Function_new(i)=((z(1))*(Mdot(i)**(2.0/7.0)))+(abs(z(2))*(Mdot(i)**(9.0/7.0)))&
    -(abs(z(3))*(Mdot(i)**(10.0/7.0)))
    dif_new(i)=Delta(i)-Delta_Fit_Function_new(i)
    B_Vector_new(i)=dif_new(i)
  end do
  ChiSquare_new=dot_product(B_Vector_new,B_Vector_new)
  
  if(ChiSquare_new .ge. ChiSquare_min) then
    
    if(ChiSquare_new-ChiSquare_min .lt. TOL) then
      exit
    else if(ChiSquare_new-ChiSquare_min .ge. TOL) then
      lambda=lambda*10.0
    end if
    
  else if(ChiSquare_new .lt. ChiSquare_min) then
    lambda=lambda/10.0
    ChiSquare_min=ChiSquare_new
  end if
  !::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
  
end do
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!:::::::::::::::::::::::::::::::::Calculation of ChiSquare:::::::::::::::::::::::::::::::::::::::::!
! Standard error of every data
do i=1,Number_of_Lines
  Delta_Fit_Function(i)=(z(1)*(Mdot(i)**(2.0/7.0)))+(abs(z(2))*(Mdot(i)**(9.0/7.0)))-(abs(z(3))*(Mdot(i)**(10.0/7.0)))
  dif(i)=Delta(i)-Delta_Fit_Function(i)
  B_Vector(i)=dif(i)
end do

! Calculation of ChiSquare
ChiSquare=dot_product(B_Vector,B_Vector)
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!

!::::::::::::::::::::::::::::: Writing Values of Parameters To Data File ::::::::::::::::::::::::::!

130 format(1i5,4x,1a30,20es15.5)
Magnetic_Moment=Magnetic_Field*(Radius**3.0)
Alfven_Radius_18=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*(Mdot_Eddington**(-2.0/7.0))*(Magnetic_Moment**(4.0/7.0))
Radius_Sch=2.0*Gravitational_Constant*Mass_Star/(Speed_of_Light**2.0)
Capital_A=(3.0*k_es*Mdot_Eddington)/(8.0*pi*Speed_of_Light*Alfven_Radius_18)

Small_a=abs(z(2))/(Capital_A*Alpha_BL)
C=sqrt(Alfven_Radius_18/(3.0*Radius_Sch))*(abs(z(3))/abs(z(2)))
H_0=z(1)*Alfven_Radius_18/Alpha_BL

write(18,130) i_write-499,Source_Name(i_read-7),Mass,Radius,Magnetic_Field,Alpha_BL,ChiSquare,z(1),abs(z(2)),-abs(z(3)),&
Small_a,H_0,C,maxval(Delta,(Delta .gt. 0.0))/Alpha_BL,minval(Delta,(Delta .gt. 0.0))/Alpha_BL,maxval(Delta,(Delta .gt. 0.0)),&
minval(Delta,(Delta .gt. 0.0))
i_write=i_write+1
!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
end subroutine 

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
