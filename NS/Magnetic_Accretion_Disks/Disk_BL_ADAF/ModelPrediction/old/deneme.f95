program main
implicit none

logical :: b
integer, dimension(10) :: a,d
real :: i
integer :: c

!allocate(a(10),d(10))

do c=1,10
  a(c) = int(rand(0)*10.0)
  d(c) = int(rand(0)*10.0)
end do

b = all(a<5)
write(*,*) b

if(b .eqv. .true.) then
  write(*,*) 'oldu amk'
end if

c=sum(pack(a, a<3 .and. a>1))

write(*,*) c,a*d

write(*,*) pack(d, a<3)
!$omp parallel
!$omp do
do c=1,10
  write(*,*) 'Number: ',d(c),a(c),'\n'
end do
!$omp end do

!$omp end parallel
!deallocate(a,d)

end program main
