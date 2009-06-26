program driver

  implicit none 

  external head

  double precision, dimension(:), allocatable :: x0
  double precision, dimension(:,:), allocatable :: res_dd
  double precision, dimension(:), allocatable :: x, xph
  double precision, dimension(:), allocatable :: y, yph
  real h
  integer n,m,nx1,nx2
  integer i,j,k
  double precision  hx1,hx2,xx2,xx1
  double precision::r
  double precision zero,one,two,three,four
  parameter(zero=0.0d0,one=1.0d0,two=2.0d0,three=3.0d0,four=4.0d0)

  nx1=5
  nx2=5
  !	  n should nx1*nx2 
  n=25
  m=25
  h=0.00001
  r=10.0

  allocate(x0(n))
  allocate(res_dd(m,n))
  allocate(x(n))
  allocate(xph(n))
  allocate(y(m))
  allocate(yph(m))

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

  write(*,*) "divided differences"
  do i=1,n   
     do j=1,n   
        x(j)=x0(j)
        if (i==j) then 
           xph(j)=x0(j)+h
        else
           xph(j)=x0(j)
        end if
     end do
     call head(nx1,nx2,xph,yph,r)
     call head(nx1,nx2,x,y,r)
     do k=1,m
        res_dd(k,i)=(yph(k)-y(k))/h
     end do
  end do
  do k=1,n
     do i=1,m   
        write(*,'(2(A,I2),A,EN26.16E3)') "F(",i,",",k,")=",res_dd(i,k)
     end do
  end do

  deallocate(x0)
  deallocate(res_dd)
  deallocate(x)
  deallocate(xph)
  deallocate(y)
  deallocate(yph)

end program driver
