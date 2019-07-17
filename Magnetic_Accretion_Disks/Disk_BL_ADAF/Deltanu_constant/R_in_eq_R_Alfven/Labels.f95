program main
implicit none

integer :: i,k
real, dimension(4) :: Mass,Radius,Magnetic_Field,Alpha_BL,x4,x1,x2,x3,Small_a,H_0,C,Eps_max,Eps_min,Delta_max,Delta_min
character*100 :: Filename(8),Sample_File

Data Filename / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /

open(11,file='Labels.txt')

do k=1,8
  Sample_File=trim(adjustl(Filename(k)))//'_Sample_Fit.dat'
  write(11,*) ' '
  write(11,*) ' '
  write(11,*) ' '
  write(11,*) Sample_File
  open(10,file=Sample_File)
  
  do i=1,4
    read(10,*) Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),x4(i),x1(i),x2(i),x3(i),Small_a(i),H_0(i),C(i),&
    Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)

    write(11,100) 'M:',Mass(i),'M_{sun} R:',int(Radius(i)*1.0E-05),'km B:',Magnetic_Field(i)*1.0E-08,&
    'x10^8G {D}_{BL}:',Alpha_BL(i)*2.0
    100 format(1a3,1f4.2,1a10,1i2,1a5,1f4.2,1a16,1f4.2)
  end do


  close(10)
end do
close(11)

end program main
