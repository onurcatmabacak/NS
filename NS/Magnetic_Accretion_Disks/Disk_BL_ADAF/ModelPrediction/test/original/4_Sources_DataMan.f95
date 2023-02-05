program main
implicit none

integer :: Data_Read,Number_of_Lines,i,i_write(10000000),DataLineCounter
real(8), dimension(10000000) :: Mass,Radius,Magnetic_Field,Alpha_BL,Eps_max,Eps_min,Delta_max,Delta_min,Chi_Square,A_1,A_2,A_3
real(8), dimension(10000000) :: Small_a,H_0,C
character*100 :: frmt,x ! format descriptor
character(len=30) :: filename,Source_Name(10000000)
character*30, dimension(8) :: SourceName

  data SourceName / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_7.0_kpc',&
  '4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /
  
  100 format(1a5,1a27,20a15)
  101 format(1i5,1a30,20es15.5)
  
  open(9,file='4U_1608_52_3.6_kpc.dat')
  open(10,file='4U_1608_52_4.22_kpc.dat')
  open(11,file='4U_1608_52_5.0_kpc.dat')
  open(12,file='4U_1636_54_5.5_kpc.dat')
  open(13,file='4U_1636_54_7.0_kpc.dat')
  open(14,file='4U_1728_34_4.5_kpc.dat')
  open(15,file='Aql_X_1_2.5_kpc.dat')
  open(16,file='Aql_X_1_5.2_kpc.dat')
  
  write(9,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(10,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(11,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(12,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(13,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(14,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(15,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  write(16,100) '#','Source_name','Mass','Radius','Mag. Field','Alpha_BL','Chi^2','A_1','A_2','A_3','a','H_0','C','Eps_max',&
  'Eps_min','Deltamax','Deltamin'
  
  do Data_Read=1,300

    frmt = '(I100)' ! an integer of width 5 with zeros at the left
    write (x,frmt) Data_Read ! converting integer to string using a 'internal file'
    filename='Mass_'//trim(adjustl(x))//'.dat'
        
    Number_of_Lines=DataLineCounter(filename)
        
    open(20,file=filename)
    
      do i=1,Number_of_Lines
        
        read(20,*) i_write(i),Source_Name(i),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
        A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        
        if(Source_Name(i) .eq. SourceName(1)) then
          write(9,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(2)) then
          write(10,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(3)) then
          write(11,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(4)) then
          write(12,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(5)) then
          write(13,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(6)) then
          write(14,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(7)) then
          write(15,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        else if(Source_Name(i) .eq. SourceName(8)) then
          write(16,101) i_write(i),adjustr(Source_Name(i)),Mass(i),Radius(i),Magnetic_Field(i),Alpha_BL(i),Chi_Square(i),&
          A_1(i),A_2(i),A_3(i),Small_a(i),H_0(i),C(i),Eps_max(i),Eps_min(i),Delta_max(i),Delta_min(i)
        end if
      end do
    
    close(20)
    
  end do
  
  close(9)
  close(10)  
  close(11)  
  close(12)  
  close(13)  
  close(14)  
  close(15)  
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
end function
