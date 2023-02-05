program main
implicit none

! under r_in = r_Alfven assumption program calculates all possible eps 
! values that satisfy parallel track data

integer :: i_read , Tip , i_write , Number_of_Lines , N , i, ii, Data_Read , onur , DataLineCounter , dummy, dims, xxx
real(16), allocatable, dimension(:) :: Mdot , Count_Rate , Flux , Luminosity , Delta_Nu , Lower_QPO , Upper_QPO_Frequency, r, H_ss, Keplerian_freq
real(16), allocatable, dimension(:) :: rin , Omega_Kepler_rin , Constant , DBL , Fastness , Epsilon , Delta, Kappa_epi, deltanu1, deltanu2, a1, a2, a3, root
real(16), dimension(20) :: Average_Deltanu, Average_Lower_QPO
real(16) :: Magnetic_Field , D_BL , Mass , Radius , Nustar , Omega_Star , Distance , Kiloparsec , Parsec , pi , Mdot_Eddington
real(16) :: Gravitational_Constant , Mass_Solar , Mass_Star , Mdot_max , Mdot_min , Speed_of_Light
real(16) :: Magnetic_Moment , A_1 , A_2 , Deltanu_Cycle
real(16) :: Magnetic_Field_min , Magnetic_Field_max , Magnetic_Field_step , Magnetic_Field_min_Alfven , Magnetic_Field_min_ISCO
real(16) :: Radius_max , Radius_min , Hadronic_Constant , Conversion_Factor , NuCorona, r_ISCO, C, kappa, Omega_rin
character*100 :: frmt , x ! format descriptor
character*30 :: filename , SourceName(4), Sourcefile

Data SourceName / '4U_1608_52.txt','4U_1636_54.txt','4U_1728_34.txt','Aql_X_1.txt' /

frmt = '(I100)' ! an integer of width 5 with zeros at the left
write (x,frmt) Data_Read ! converting integer to string using a 'internal file'
filename='Mass_'//trim(adjustl(x))//'.dat'
open(16,file=filename)

N = 3

do i_read = 9,9 

	i_write = 500
	!::::::::::::::::::::::::::::::::::::: Data Read From File ::::::::::::::::::::::::::::::::::::::::!
	if(i_read .eq. 8) then
		Number_of_Lines = DataLineCounter(SourceName(1))
		Nustar = 619.0
		Parsec = 3.6
		Conversion_Factor = 4.49754E-12
		Sourcefile = '4U_1608_52.txt'
	else if(i_read .eq. 9) then
		Number_of_Lines = DataLineCounter(SourceName(1))
		Nustar = 619.0
		Parsec = 4.22
		Conversion_Factor = 4.49754E-12
		Sourcefile = '4U_1608_52.txt'
	else if(i_read .eq. 10) then
		Number_of_Lines = DataLineCounter(SourceName(1))
		Nustar = 619.0
		Parsec = 5.0
		Conversion_Factor = 4.49754E-12
		Sourcefile = '4U_1608_52.txt'
	else if(i_read .eq. 11) then
		Number_of_Lines = DataLineCounter(SourceName(2))
		Nustar = 581.0
		Parsec = 5.5
		Conversion_Factor = 4.6E-12
		Sourcefile = '4U_1636_54.txt'
	else if(i_read .eq. 12) then
		Number_of_Lines = DataLineCounter(SourceName(2))
		Nustar = 581.0
		Parsec = 7.0
		Conversion_Factor = 4.6E-12
		Sourcefile = '4U_1636_54.txt'
	else if(i_read .eq. 13) then
		Number_of_Lines = DataLineCounter(SourceName(3))
		Nustar = 363.0
		Parsec = 4.5
		Conversion_Factor = 3.95E-12
		Sourcefile = '4U_1728_34.txt'
	else if(i_read .eq. 14) then
		Number_of_Lines = DataLineCounter(SourceName(4))
		Nustar = 549.0
		Parsec = 2.5
		Conversion_Factor = 1.96E-12
		Sourcefile = 'Aql_X_1_Barret.txt'
	else if(i_read .eq. 15) then
		Number_of_Lines = DataLineCounter(SourceName(4))
		Nustar = 549.0
		Parsec = 5.2
		Conversion_Factor = 1.96E-12
		Sourcefile = 'Aql_X_1_Mendez.txt'
	 end if

	dims = Number_of_Lines
	Allocate(Mdot(dims), Count_Rate(dims), Flux(dims), Luminosity(dims), Delta_Nu(dims), Lower_QPO(dims), Upper_QPO_Frequency(dims), r(dims), H_ss(dims), Keplerian_freq(dims), rin(dims), Omega_Kepler_rin (dims), Constant(dims), DBL(dims), Fastness(dims), Epsilon(dims), Delta(dims), Kappa_epi(dims), deltanu1(dims), deltanu2(dims), a1(dims), a2(dims), a3(dims), root(dims))

	!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
	
	open(unit = i_read, file = Sourcefile)
	do i = 1, Number_of_Lines
		read(i_read,*) Count_Rate(i),Lower_QPO(i)
		Flux(i) = Count_Rate(i)*Conversion_Factor
	end do
	close(i_read)	
	!::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::!
	
	!$OMP PARALLEL
	do dummy = 100,150
		Mass = dummy / 100.0

		Radius = 0.7E+06
		do while(Radius .le. 1.6E+06)
		
		Radius_min = ( 6.0 * Mass + 4.1 ) / 1.7 * 1.0E+05
		Hadronic_Constant = 1.08
		Radius_max = 1.0E+06*( ( Mass ) ** ( 1.0 / 3.0 ) ) * ( ( Hadronic_Constant * 1000.0 / Nustar ) ** ( 2.0 / 3.0 ) )
		
		if(Radius .lt. Radius_max .and. Radius .gt. Radius_min) then
			
			Deltanu_Cycle = 300.0
			do while(Deltanu_Cycle .le. 500.0)		

				NuCorona = 100.0
				do while(NuCorona .le. 300.0)

					Kiloparsec = 3.08567758E+21
					Distance = Parsec*Kiloparsec
					Gravitational_Constant = 6.67E-08
					Mass_Solar = 2.0E+33
					Speed_of_Light = 3.0E+10
					Mass_Star = Mass*Mass_Solar
					Mdot_Eddington = 1.0E+18
					pi = 4.0*ATAN(1.0)
					kappa = 0.4
					Mdot = 0.0
				
					Luminosity = 4.0 * pi * ( Distance ** 2.0 ) * Flux
					Mdot = ( Luminosity * Radius ) / ( Gravitational_Constant * Mass_Star * Mdot_Eddington ) 
				
					Mdot_min = minval(Mdot)
					Mdot_max = maxval(Mdot)
					
					! Alfven radius is bigger than neutron star's radius
					Magnetic_Field_min_Alfven = ( ( Gravitational_Constant * Mass_Star ) ** ( 1.0 / 4.0 ) ) * ( ( Mdot_max * Mdot_Eddington ) ** ( 1.0 / 2.0 ) ) * ( ( Radius ) ** ( -5.0 / 4.0 ) )
					! Alfven radius is bigger than marginally stable orbit
					Magnetic_Field_min_ISCO = ( ( Gravitational_Constant * Mass_Star ) ** ( 2.0 ) ) * ( ( Mdot_max * Mdot_Eddington ) ** ( 1.0 / 2.0 ) ) * ( Radius ** ( -3.0 ) ) * ( ( ( Speed_of_Light ** 2.0 ) / 6.0 ) ** ( -7.0 / 4.0 ) )
					
					if ( Magnetic_Field_min_Alfven .gt. Magnetic_Field_min_ISCO ) then
						Magnetic_Field_min = Magnetic_Field_min_Alfven
					else if ( Magnetic_Field_min_Alfven .lt. Magnetic_Field_min_ISCO ) then
						Magnetic_Field_min = Magnetic_Field_min_ISCO
					end if
					
					Magnetic_Field_max = ( ( Gravitational_Constant * Mass_Star ) ** ( 5.0 / 6.0 )	) * ( ( Mdot_min * Mdot_Eddington ) ** ( 1.0 / 2.0 ) ) * ( ( Radius ) ** ( -3.0 ) ) * ( ( 2.0 * pi * NuCorona ) ** ( -7.0 / 6.0 ) ) 
					
					! If inner radius is determined with light cylinder radius instead of corotation radius
					
					!Magnetic_Field_max= (	( Gravitational_Constant*Mass_Star ) ** ( 5.0 / 6.0 ) ) * ( ( Mdot_min*Mdot_Eddington ) ** ( 1.0 / 2.0 ) ) * ( ( Radius ) ** ( -3.0 ) ) * (	( 2.0*pi*Nustar ) ** ( -7.0 / 6.0 )	) 
					
					Magnetic_Field_step = ( Magnetic_Field_max-Magnetic_Field_min ) / 10.0
					
					Magnetic_Field = Magnetic_Field_min
					do while ( Magnetic_Field .lt. Magnetic_Field_max ) 

						rin = 0.0
						Magnetic_Moment = Magnetic_Field * (Radius ** 3.0)	
						rin = ( ( Gravitational_Constant * Mass_Star ) ** ( -1.0 / 7.0 )	) * ( ( Mdot * Mdot_Eddington ) ** ( -2.0 / 7.0 ) ) * ( ( Magnetic_Moment ) ** ( 4.0 / 7.0 )	) 
						r_ISCO = 6.0 * Gravitational_Constant * Mass_Star / ( Speed_of_Light ** 2.0 )						 
						r = r_ISCO / rin 
						Omega_Kepler_rin = sqrt(( Gravitational_Constant * Mass_Star ) / ( rin ** 3.0 ))
						Keplerian_freq = Omega_Kepler_rin / ( 2.0 * pi )

						C = 0.5 
						do while ( C .lt. 1.0 )
		
							! Find the minimum Alpha_BL that makes it guarantee to satisfy all parallel track data
							H_ss = ( 3.0 * kappa * Mdot * Mdot_Eddington ) / ( 8.0 * pi * Speed_of_Light ) * ( 1.0 - (C *  (r ** (-0.5 ) ) ) )
							Epsilon = H_ss / rin 

							Omega_rin = 2.0 * pi * Deltanu_Cycle
							Kappa_epi = 2.0 * pi * ( Lower_QPO + Deltanu_Cycle ) 
							Constant = ( (Kappa_epi ** 2.0) / ( 2.0 * Omega_rin ) ) - ( 2.0 * Omega_rin ) + ( 1.5 * Omega_Kepler_rin )
							DBL = 2.0 * ( Omega_Kepler_rin - Omega_rin ) / ( Epsilon * Constant ) 
						
							D_BL = maxval(DBL) 
							
							if (D_BL <= 100.0 .and. D_BL > 0.0 .and. all(H_ss > 0.0)) then
								
								Delta = Epsilon * D_BL
								do ii=1,Number_of_Lines
									Delta(ii) = Delta(ii) * (1.0 + ((rand(0) * 2.0) - 1.0) * 0.15)
								end do
				
								if (minval(Delta) >= 0.01 .and. maxval(Delta) <= 0.3) then

									a1 = 3.0 - ( 2.0 / Delta )
									a2 = ( -a1 * Keplerian_freq ) - ( 2.0 * Lower_QPO )
									a3 = - ( Lower_QPO ** 2.0 )

									root = (a2 ** 2.0) - (4.0 * a1 * a3)
					
									if (all(root >= 0.0)) then

										deltanu1 = ( - a2 + sqrt(root)) / (2.0 * a1)
										deltanu2 = ( - a2 - sqrt(root)) / (2.0 * a1)

										Average_Deltanu = 0.0
										Average_Lower_QPO = 0.0

										130 format(1i5,5x,1a21,20es15.5)
										140 format(2es15.5)
										if (all(deltanu1 >= 0.0)) then

											! here put the function to average deltanu values over mdot
											call Average(deltanu1, Mdot, Lower_QPO, Number_of_Lines, Average_Deltanu, Average_Lower_QPO)											
											write(*,130) 1, Sourcefile, Parsec, Mass, Radius, Magnetic_Field, D_BL, C, NuCorona, Deltanu_Cycle, minval(Average_Deltanu), maxval(Average_Deltanu)	
											do xxx=1,20
												write(*,140) Average_Deltanu(xxx), Average_Lower_QPO(xxx)
											end do
	
											if (all(Average_Deltanu >= NuCorona) .and. all(Average_Deltanu <= Deltanu_Cycle)) then 

												write(*,130) 1, Sourcefile, Parsec, Mass, Radius, Magnetic_Field, D_BL, C, NuCorona, Deltanu_Cycle, minval(Average_Deltanu), maxval(Average_Deltanu)	

											end if
							
										end if

										Average_Deltanu = 0.0
										Average_Lower_QPO = 0.0

										if (all(deltanu2 >= 0.0)) then

											! here put the function to average deltanu values over mdot
											call Average(deltanu2, Mdot, Lower_QPO, Number_of_Lines, Average_Deltanu, Average_Lower_QPO)
											write(*,130) 2, Sourcefile, Parsec, Mass, Radius, Magnetic_Field, D_BL, C, NuCorona, Deltanu_Cycle, minval(Average_Deltanu), maxval(Average_Deltanu)	
											do xxx=1,20
												write(*,140) Average_Deltanu(xxx), Average_Lower_QPO(xxx)
											end do

											if (all(Average_Deltanu >= NuCorona) .and. all(Average_Deltanu <= Deltanu_Cycle)) then 

												write(*,130) 2, Sourcefile, Parsec, Mass, Radius, Magnetic_Field, D_BL, C, NuCorona, Deltanu_Cycle, minval(Average_Deltanu), maxval(Average_Deltanu)	

											end if

										end if

									end if

								end if

							end if

						C = C + 0.01
						end do

					Magnetic_Field = Magnetic_Field + Magnetic_Field_step
					end do

				NuCorona = NuCorona + 10.0
				end do
			
			Deltanu_Cycle = Deltanu_Cycle + 10.0
			end do 
			
		end if	 
		Radius = Radius + 1.0E+04
		end do
		
	end do
	!$OMP END PARALLEL

	Deallocate(Mdot, Count_Rate, Flux, Luminosity, Delta_Nu, Lower_QPO, Upper_QPO_Frequency, r, H_ss, Keplerian_freq, rin, Omega_Kepler_rin , Constant, DBL, Fastness, Epsilon, Delta, Kappa_epi, deltanu1, deltanu2, a1, a2, a3, root)

end do

close(16)
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
end function DataLineCounter

subroutine Average(Deltanu, Mdot, Lower_QPO, Number_of_Lines, Average_Deltanu, Average_Lower_QPO)

integer, intent(in) :: Number_of_Lines
real(16), dimension(Number_of_Lines), intent(in) :: Deltanu, Mdot, Lower_QPO
real(16), dimension(20), intent(out) :: Average_Deltanu, Average_Lower_QPO
real(16) :: Frequency, Frequency_Range, Total_Mdot, Total_Deltanu, Total_Lower_QPO

k = 1
Frequency = minval(Lower_QPO,(Lower_QPO .gt. 0.0))
Frequency_Range = 30.0

do while(Frequency .le. maxval(Lower_QPO))

	Total_Mdot = 0.0
	Total_Deltanu = 0.0
	Total_Lower_QPO = 0.0

	do j = 1, Number_of_Lines

		if(Lower_QPO(j) .ge. Frequency .and. Lower_QPO(j) .le. Frequency + Frequency_Range) then

			Total_Mdot = Total_Mdot + (Mdot(j))
			Total_Deltanu = Total_Deltanu + (Deltanu(j) * Mdot(j))
			Total_Lower_QPO = Total_Lower_QPO + (Lower_QPO(j) * Mdot(j))

		end if

	end do

	Average_Deltanu(k) = Total_Deltanu / Total_Mdot
	Average_Lower_QPO(k) = Total_Lower_QPO / Total_Mdot

	write(*,*) Average_Deltanu(k), Average_Lower_QPO(k)
	
	Frequency = Frequency + Frequency_Range
	k=k+1

end do
end subroutine Average
