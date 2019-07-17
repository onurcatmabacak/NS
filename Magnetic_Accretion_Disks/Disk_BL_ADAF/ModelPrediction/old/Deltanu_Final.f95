program main
implicit none

logical :: Delta_Nu_Check_1,Delta_Nu_Check_2
integer :: i,j,k,l,m(1),n(1),Onur,Number_of_Lines,Data_Read,DataLineCounter
integer :: jmass,jradius,jmag,jalpha,jeps,jamec
real(8) :: Mass,Radius,Magnetic_Field,Gravitational_Constant,Mass_Solar,Mass_Star,pi,Kappa_es,Speed_of_Light,A,B,C,Nustar
real(8), allocatable, dimension(:) :: Luminosity,Mdot,Epsilon,Delta_Nu_1,Delta_Nu_2,Flux
real(8), allocatable, dimension(:) :: Average_Delta_Nu_1,Average_Delta_Nu_2,Average_Lower_QPO,Delta,Radius_Alfven
real(8), allocatable, dimension(:) :: Omega_Kepler_rin,Keplerian_Frequency,H_SS,H_t,Count_Rate,Lower_QPO
real(8) :: Frequency,Frequency_Range,Total_Delta_Nu_1,Total_Delta_Nu_2,Total_Lower_QPO
real(8) :: Magnetic_Field_max,Magnetic_Field_min,Magnetic_Field_min_Alfven,Magnetic_Field_min_ISCO,Magnetic_Field_step
real(8) :: Mdot_max,Mdot_min,Total_Mdot,Alpha_BL,Parsec,Distance,Kiloparsec,NuCorona,Mdot_Eddington,Perturbation
real(8) :: Radius_upper,Radius_lower,Hadronic_Constant,temp,Epsilon_Cycle,Conversion_Factor,AMEC
real(8) :: Mass_min,Mass_max,Radius_min,Radius_max,Alpha_BL_min,Alpha_BL_max,Epsilon_Cycle_max,Epsilon_Cycle_min,AMEC_min,AMEC_max
real(8) :: Mass_step,Radius_step,Alpha_BL_step,Epsilon_Cycle_step,AMEC_step,a_0,H_0,Frequency_Initial,Frequency_Final
character*100 :: frmt,x ! format descriptor
character(len=30) :: filename,SourceName,Source(10)

Data Source / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc_Mendez','Aql_X_1_5.2_kpc_Mendez' ,'Aql_X_1_2.5_kpc_Barret','Aql_X_1_5.2_kpc_Barret'/

Frequency_Range=20.0
NuCorona=200.0
a_0=1.0
H_0=0.0

Mass_max=2.01
Mass_min=1.0
Mass_step=0.1
Radius_max=1.61e6
Radius_min=0.7e6
Radius_step=1.0e5
Alpha_BL_max=6.01
Alpha_BL_min=0.1
Alpha_BL_step=0.1
Epsilon_Cycle_max=0.1
Epsilon_Cycle_min=0.01
Epsilon_Cycle_step=0.01
AMEC_max=1.0
AMEC_min=0.8
AMEC_step=0.01

do l=6,6

  Data_Read=l
  frmt = '(I100)' ! an integer of width 5 with zeros at the left
  write (x,frmt) Data_Read ! converting integer to string using a 'internal file'
  filename='Mass_'//trim(adjustl(x))//'.dat'
  open(13,file=filename,position='append')
  
  write(13,101) '#','Source','Mass','Radius','Mag Field','D_BL','C','temp',&
  'Eps_max','Eps_min','Delta_max','Delta_min','Deltanu_max','Deltanu_min'

  100 format(1i5,1a30,20es15.3)
  101 format(1a5,1a30,20a15)

  select case(l)
    case(1)
    SourceName='4U_1608_52.txt'
    Parsec=3.6
    Nustar=619.0
    Conversion_Factor=4.49754e-12
    Perturbation=0.2
    case(2)
    SourceName='4U_1608_52.txt'
    Parsec=4.22
    Nustar=619.0
    Conversion_Factor=4.49754e-12
    Perturbation=0.5
    case(3)
    SourceName='4U_1608_52.txt'
    Parsec=5.0
    Nustar=619.0
    Conversion_Factor=4.49754e-12
    Perturbation=0.2
    case(4)
    SourceName='4U_1636_54.txt'
    Parsec=5.5
    Nustar=581.0
    Conversion_Factor=4.6e-12
    Perturbation=0.2                                            
    case(5)
    SourceName='4U_1636_54.txt'
    Parsec=7.0
    Nustar=581.0
    Conversion_Factor=4.6e-12
    Perturbation=0.2
    case(6)
    SourceName='4U_1728_34.txt'
    Parsec=4.5
    Nustar=363.0
    Conversion_Factor=3.95e-12
    Perturbation=0.0
    case(7)
    SourceName='Aql_X_1_Mendez.txt'
    Parsec=2.5
    Nustar=549.0
    Conversion_Factor=2.3e-12
    Perturbation=0.2
    case(8)
    SourceName='Aql_X_1_Mendez.txt'
    Parsec=5.2
    Nustar=549.0
    Conversion_Factor=2.3e-12
    Perturbation=0.2
    case(9)
    SourceName='Aql_X_1_Barret.txt'
    Parsec=2.5
    Nustar=549.0
    Conversion_Factor=10.0e-12
    Perturbation=0.2
    case(10)
    SourceName='Aql_X_1_Barret.txt'
    Parsec=5.2
    Nustar=549.0
    Conversion_Factor=10.0e-12
    Perturbation=0.2
  end select

  ! ALLOCATE ARRAYS
  Number_of_Lines=DataLineCounter(SourceName)

  allocate(Count_Rate(Number_of_Lines),Lower_QPO(Number_of_Lines),Flux(Number_of_Lines))
  allocate(Luminosity(Number_of_Lines),Mdot(Number_of_Lines),Radius_Alfven(Number_of_Lines),Keplerian_Frequency(Number_of_Lines))
  allocate(Omega_Kepler_rin(Number_of_Lines),H_SS(Number_of_Lines),H_t(Number_of_Lines),Epsilon(Number_of_Lines))
  allocate(Delta(Number_of_Lines),Delta_Nu_1(Number_of_Lines),Delta_Nu_2(Number_of_Lines))

  open(10,file=SourceName)
  do i=1,Number_of_Lines
    read(10,*) Count_Rate(i),Lower_QPO(i)
  end do
  close(10)

  j=int((maxval(Lower_QPO)-minval(Lower_QPO))/Frequency_Range)
  allocate(Average_Delta_Nu_1(j),Average_Delta_Nu_2(j),Average_Lower_QPO(j))

  Flux=Count_Rate*Conversion_Factor
  !$omp parallel private(Luminosity,Mdot,Radius_Alfven,Keplerian_Frequency,Omega_Kepler_rin,H_SS,H_t,Epsilon,Delta),&
  !$omp& private(Delta_Nu_1,Delta_Nu_2,Average_Delta_Nu_1,Average_Delta_Nu_2,Average_Lower_QPO)

  !$omp do
  do jmass=1,int((Mass_max-Mass_min)/Mass_step)
    Mass=Mass_min+(jmass-1)*Mass_step

    do jradius=1,int((Radius_max-Radius_min)/Radius_step)
      Radius=Radius_min+(jradius-1)*Radius_step
      write(*,'(2f10.2)') Mass,Radius*1e-05
      Radius_lower=(6.0*Mass+4.1)/1.7*1.0e+05
      Hadronic_Constant=1.08        
      Radius_upper=1.0e+06*((Mass)**(1.0/3.0))*((Hadronic_Constant*1000.0/Nustar)**(2.0/3.0))

      if(Radius .lt. Radius_upper .and. Radius .gt. Radius_lower) then

        Kiloparsec=3.08567758e+21
        Distance=Parsec*Kiloparsec
        Gravitational_Constant=6.67e-08
        Mass_Solar=2.0e+33
        Mass_Star=Mass*Mass_Solar
        pi=4.0*atan(1.0)
        Kappa_es=0.4
        Speed_of_Light=3.0e+10
        Mdot_Eddington=1.0e+18

        Luminosity=4.0*pi*(Distance**2.0)*Flux

        Mdot=(Luminosity*Radius)/(Gravitational_Constant*Mass_Star)
         
        Mdot_min=minval(Mdot)
        Mdot_max=maxval(Mdot)

        ! Alfven radius is bigger than neutron star's radius
        Magnetic_Field_min_Alfven=((Gravitational_Constant*Mass_Star)**(1.0/4.0))*((Mdot_max)**(1.0/2.0))*&
        ((Radius)**(-5.0/4.0))
        ! Alfven radius is bigger than marginally stable orbit
        Magnetic_Field_min_ISCO=((Gravitational_Constant*Mass_Star)**(2.0))*((Mdot_max)**(1.0/2.0))*&
        ((Radius)**(-3.0))*(((Speed_of_Light**2.0)/6.0)**(-7.0/4.0))

        if(Magnetic_Field_min_Alfven .gt. Magnetic_Field_min_ISCO) then
          Magnetic_Field_min=Magnetic_Field_min_Alfven*1.01
        else if(Magnetic_Field_min_Alfven .lt. Magnetic_Field_min_ISCO) then
          Magnetic_Field_min=Magnetic_Field_min_ISCO*1.01
        end if

        !Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min)**(1.0/2.0))*&
        !((Radius)**(-3.0))*((2.0*pi*Nustar)**(-7.0/6.0))

        ! If corotation radius is determined with D-BL-ADAF corotation radius instead of star's corotation radius

        Magnetic_Field_max=((Gravitational_Constant*Mass_Star)**(5.0/6.0))*((Mdot_min)**(1.0/2.0))*&
        ((Radius)**(-3.0))*((2.0*pi*NuCorona)**(-7.0/6.0))     

        Magnetic_Field_step=(Magnetic_Field_max-Magnetic_Field_min)/10.0
        do jmag=1,int((Magnetic_Field_max-Magnetic_Field_min)/Magnetic_Field_step)
          Magnetic_Field=Magnetic_Field_min+(jmag-1)*Magnetic_Field_step

          do jalpha=1,int((Alpha_BL_max-Alpha_BL_min)/Alpha_BL_step)
            Alpha_BL=Alpha_BL_min+(jalpha-1)*Alpha_BL_step

            do jeps=1,int((Epsilon_Cycle_max-Epsilon_Cycle_min)/Epsilon_Cycle_step)
              Epsilon_Cycle=Epsilon_Cycle_min+(jeps-1)*Epsilon_Cycle_step

              if(Alpha_BL*Epsilon_Cycle .le. 0.6) then
   
                do jamec=1,int((AMEC_max-AMEC_min)/AMEC_step) ! we are also scanning possible AMEC values
                  AMEC=AMEC_min+(jamec-1)*AMEC_step

                  Radius_Alfven=((Gravitational_Constant*Mass_Star)**(-1.0/7.0))*((Mdot)**(-2.0/7.0))*&
                  ((Magnetic_Field)**(4.0/7.0))*((Radius)**(12.0/7.0))
                  Omega_Kepler_rin=(Gravitational_Constant*Mass_Star/(Radius_Alfven**3.0))**(1.0/2.0)
                  Keplerian_Frequency=Omega_Kepler_rin/(2.0*pi)
                  H_SS=(3.0*Kappa_es*Mdot)/(8.0*pi*Speed_of_Light)*(1.0-AMEC)
                  H_t=a_0*H_SS+H_0 
                  Epsilon=H_t/Radius_Alfven * (1.0+((rand(0)*2.0)-1.0)*Perturbation) ! %20 perturbation of the epsilon itself
                  temp=Epsilon_Cycle/maxval(Epsilon)
                  Epsilon=temp*Epsilon

                  if(maxval(Epsilon) .le. 0.1 .and. minval(Epsilon) .ge. 1.0D-04) then

                    Delta=Epsilon*Alpha_BL

                    do i=1,Number_of_Lines        
                      ! Delta_Nu=(-B+-sqrt(B^2-4AC))/(2A)
                      A=3.0-(1.0/Delta(i))
                      B=(-3.0+(2.0/Delta(i)))*Keplerian_Frequency(i)-(2.0*Lower_QPO(i))
                      C=-(Lower_QPO(i)**2.0)
                      Delta_Nu_1(i)=(-B+sqrt((B**2.0)-(4.0*A*C)))/(2.0*A)
                      Delta_Nu_2(i)=(-B-sqrt((B**2.0)-(4.0*A*C)))/(2.0*A)
                    end do

                    Delta_Nu_Check_1=all(Delta_Nu_1 .ge. 0.0)
                    Delta_Nu_Check_2=all(Delta_Nu_2 .ge. 0.0)

                    ! First type of solution
                    if(Delta_Nu_Check_1 .eqv. .true.) then

                      ! DeltaNu and Nu1 averaging over Mdot values

                      !Average_Delta_Nu_1=0.0
                      !Average_Lower_QPO=0.0
                      Frequency=minval(Lower_QPO)

                      do k=1,j
                        Total_Mdot=0.0
                        Total_Delta_Nu_1=0.0
                        Total_Lower_QPO=0.0

                        Frequency_Initial=Frequency+((k-1)*Frequency_Range)
                        Frequency_Final=Frequency+(k*Frequency_Range)

                        Total_Mdot=sum(pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))
                        Total_Delta_Nu_1=sum(pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final)*&
                        pack(Delta_Nu_1, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))
                        Total_Lower_QPO=sum(pack(Lower_QPO, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final)*&
                        pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))

                        Average_Delta_Nu_1(k)=Total_Delta_Nu_1/Total_Mdot
                        Average_Lower_QPO(k)=Total_Lower_QPO/Total_Mdot
                      end do
                      if(maxval(Average_Delta_Nu_1) .le. 400.0 .and. minval(Average_Delta_Nu_1) .ge. 200.0) then

                        m=minloc(Average_Delta_Nu_1) ! indice for minimum average deltanu
                        n=maxloc(Average_Delta_Nu_1) ! indice for maximum average deltanu
                          
                        if(Average_Lower_QPO(n(1)) .lt. Average_Lower_QPO(m(1))) then   ! nu1 vs deltanu decreasing behaviour, in the x axis lower QPO of max average deltanu should be LOWER than lower QPO of min average deltanu             
                          Onur=1
                          write(*,100) Onur, trim(adjustl(Source(l))),Mass,Radius,Magnetic_Field,2.0*Alpha_BL,AMEC,temp,&
                          maxval(Epsilon),minval(Epsilon),maxval(Delta),minval(Delta),maxval(Average_Delta_Nu_1),&
                          minval(Average_Delta_Nu_1)
                        end if

                      end if

                    end if
                    ! End of First Solution

                    ! Second type of solution
                    if(Delta_Nu_Check_2 .eqv. .true.) then

                      ! DeltaNu and Nu2 averaging over Mdot values

                      !Average_Delta_Nu_2=0.0
                      !Average_Lower_QPO=0.0
                      Frequency=minval(Lower_QPO)

                      do k=1,int((maxval(Lower_QPO)-minval(Lower_QPO))/Frequency_Range)
                        Total_Mdot=0.0
                        Total_Delta_Nu_2=0.0
                        Total_Lower_QPO=0.0

                        Frequency_Initial=Frequency+((k-1)*Frequency_Range)
                        Frequency_Final=Frequency+(k*Frequency_Range)
                        
                        Total_Mdot=sum(pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))
                        Total_Delta_Nu_2=sum(pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final)*&
                        pack(Delta_Nu_2, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))
                        Total_Lower_QPO=sum(pack(Lower_QPO, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final)*&
                        pack(Mdot, Lower_QPO .ge. Frequency_Initial .and. Lower_QPO .le. Frequency_Final))

                        Average_Delta_Nu_2(k)=Total_Delta_Nu_2/Total_Mdot
                        Average_Lower_QPO(k)=Total_Lower_QPO/Total_Mdot
                      end do
                      if(maxval(Average_Delta_Nu_2) .le. 400.0 .and. minval(Average_Delta_Nu_2) .ge. 200.0) then

                      write(*,'(3es10.3)') maxval(Average_Delta_Nu_1),minval(Average_Delta_Nu_1)
                        m=minloc(Average_Delta_Nu_2) ! indice for minimum average deltanu
                        n=maxloc(Average_Delta_Nu_2) ! indice for maximum average deltanu
                          
                        if(Average_Lower_QPO(n(1)) .lt. Average_Lower_QPO(m(1))) then   ! nu1 vs deltanu decreasing behaviour, in the x axis lower QPO of max average deltanu should be LOWER than lower QPO of min average deltanu             
                          Onur=1
                          write(*,100) Onur, trim(adjustl(Source(l))),Mass,Radius,Magnetic_Field,2.0*Alpha_BL,AMEC,temp,&
                          maxval(Epsilon),minval(Epsilon),maxval(Delta),minval(Delta),maxval(Average_Delta_Nu_2),&
                          minval(Average_Delta_Nu_2)
                        end if

                      end if

                    end if
                    ! End of Second Solution
                  end if

                end do
              end if
            end do
          end do        
        end do
      end if
    end do

  end do
  !$omp end do
  close(13)
  !$omp end parallel 
  deallocate(Count_Rate,Lower_QPO,Flux)
  deallocate(Luminosity,Mdot,Radius_Alfven,Keplerian_Frequency)
  deallocate(Omega_Kepler_rin,H_SS,H_t,Epsilon,Delta,Delta_Nu_1,Delta_Nu_2)
  deallocate(Average_Delta_Nu_1,Average_Delta_Nu_2,Average_Lower_QPO)

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
