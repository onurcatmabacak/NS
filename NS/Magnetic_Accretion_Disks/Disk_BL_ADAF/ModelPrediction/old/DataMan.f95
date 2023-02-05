program main
implicit none

integer :: Data_Read,Number_of_Lines,i,DataLineCounter
real(8), dimension(10000000) :: Mass,Radius,Magnetic_Field,D_BL,Eps_max,Eps_min,Delta_max,Delta_min,ADN_max,ADN_min,AMEC,temp
character*100 :: frmt,x ! format descriptor
character(len=30) :: filename,SourceName,Source(8)

Data Source / '4U_1608_52_3.6_kpc','4U_1608_52_4.22_kpc','4U_1608_52_5.0_kpc','4U_1636_54_5.5_kpc','4U_1636_54_kpc',&
'4U_1728_34_4.5_kpc','Aql_X_1_2.5_kpc','Aql_X_1_5.2_kpc' /
  
  100 format(15es10.3)
  101 format(15a10)

  open(11,file='4U_1608_52_3.6_kpc.dat')
  write(11,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(12,file='4U_1608_52_4.22_kpc.dat')
  write(12,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(13,file='4U_1608_52_5.0_kpc.dat')
  write(13,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(14,file='4U_1636_54_5.5_kpc.dat')
  write(14,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(15,file='4U_1636_54_7.0_kpc.dat')
  write(15,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(16,file='4U_1728_34_4.5_kpc.dat')
  write(16,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(17,file='Aql_X_1_2.5_kpc.dat')
  write(17,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  open(18,file='Aql_X_1_5.2_kpc.dat')
  write(18,101) 'Mass','Radius','Mag. F.','D_BL','C','C_Eps','EPS_max','EPS_min','Delta_max','Delta_min','ADN_max','ADN_min'
  
  do Data_Read=1,300

    frmt = '(I100)' ! an integer of width 5 with zeros at the left
    write (x,frmt) Data_Read ! converting integer to string using a 'internal file'
    filename='Mass_'//trim(adjustl(x))//'.dat'
    Number_of_Lines=DataLineCounter(filename)
        
    open(10,file=filename)
    read(10,*)
      do i=1,Number_of_Lines-1
        
        read(10,*) SourceName,Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
        
        if(SourceName .eq. Source(1)) then
        write(11,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(2)) then
        write(12,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(3)) then
        write(13,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(4)) then
        write(14,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(5)) then
        write(15,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(6)) then
        write(16,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(7)) then
        write(17,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        else if(SourceName .eq. Source(8)) then
        write(18,100) Mass(i),Radius(i),Magnetic_Field(i),D_BL(i),AMEC(i),temp(i),Eps_max(i),Eps_min(i),&
        Delta_max(i),Delta_min(i),ADN_max(i),ADN_min(i)
      
        end if
      end do
    
    close(10)
    
  end do
  
  close(9)  
    
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
