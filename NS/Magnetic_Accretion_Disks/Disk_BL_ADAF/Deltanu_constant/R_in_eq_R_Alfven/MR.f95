program main
implicit none

integer :: i,k,io,Number_of_Lines,i_write
real(8),dimension(10000000) :: Mass,Radius,Magnetic_Field,Alpha_BL,Chi_Square
real(8),dimension(10000000) :: z1,z2,z3,Small_a,H_0,C,Eps_max,Eps_min,Mass_Lower,Mass_Upper
real(8) :: Nustar(8),Hadronic_Constant
character*50 :: Source_Name,Filename(8)

Data Filename / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /

Data Nustar / 619.0,619.0,619.0,581.0,581.0,363.0,549.0,549.0 /

Hadronic_Constant=1.08

do k=1,8
    
    open(10,file=trim(adjustl(Filename(k)))//'_1.dat')
    open(11,file=trim(adjustl(Filename(k)))//'_Raw.dat')
    read(10,*)
    
    Number_of_Lines=0
    do
        read(10,*,iostat=io) i_write,Source_Name,Mass(1),Radius(1),Magnetic_Field(1),Alpha_BL(1),Chi_Square(1),&
        z1(1),z2(1),z3(1),Small_a(1),H_0(1),C(1),Eps_max(1),Eps_min(1)
        if(io .gt. 0) then
            exit
        else if(io .lt. 0) then
            exit
        else if(io .eq. 0) then
            Number_of_Lines=Number_of_Lines+1
        end if
    end do
    close(10)
    
    open(10,file=trim(adjustl(Filename(k)))//'_1.dat')
    read(10,*)
    
    do i=1,Number_of_Lines
        read(10,*) i_write,Source_Name,Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),z1(i),z2(i),z3(i),Small_a(i),&
        H_0(i),C(i),Eps_max(i),Eps_min(i)
        
        Mass_Lower(i)=((Radius(i)*1.0E-06)**(3.0))*((Nustar(k)/1000.0/Hadronic_Constant)**(2.0))
        Mass_Upper(i)=(1.7/6.0*Radius(i)*1.0E-05)-(4.1/6.0)
        
        if(Mass(i) .lt. Mass_Upper(i) .and. Mass(i) .gt. Mass_Lower(i)) then
            write(11,100) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),z1(i),z2(i),z3(i),&
            Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i)
            100 format(20es15.5)
        end if
    end do
    
    close(10)
    close(11)
    close(12)
    
end do

end program main
