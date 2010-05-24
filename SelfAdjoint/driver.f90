program driver
  implicit none 
  external head
  double precision :: x(2), b(2)
  b=(/.5D0,12.0D0/)
  print *, 'driver running for b =',b
  call head(b,x)
  print *, '            yields x =',x
end program driver
