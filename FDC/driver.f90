program driver

  implicit none 

  external head

  double precision, dimension(:), allocatable :: x0
  double precision, dimension(:), allocatable :: x
  double precision, dimension(:), allocatable :: y
  integer n,m,nx1,nx2
  integer i,j,k
  double precision  hx1,hx2,xx2,xx1
  double precision ::r
  double precision zero,one,two,three,four
  parameter(zero=0.0d0,one=1.0d0,two=2.0d0,three=3.0d0,four=4.0d0)

  nx1=5
  nx2=5
  !	  n should nx1*nx2 
  n=25
  m=25
  r=10.0

  allocate(x0(n))
  allocate(x(n))
  allocate(y(m))

  !         initial value 

  hx1 = one/dble(nx1 + 1)
  hx2 = one/dble(nx2 + 1)

  xx2 = hx2
  do i = 1, nx2
     xx1 = hx1
     do j = 1, nx1
        k = (i - 1)*nx1 + j
        x0(k) = - xx1*(one - xx1)*xx2*(one - xx2)
        xx1 = xx1 + hx1
     end do
     xx1 = hx1
     xx2 = xx2 + hx2
  end do

  call head(nx1,nx2,x,y,r)

  do k=1,m
     write(*,'(A,I1,A,EN26.16E3)') "y(",k,")=",y(k)
  end do

  deallocate(x0)
  deallocate(x)
  deallocate(y)

end program driver
