subroutine foo (a)
  real a
  a=a*2
end

program func 
  real x
  x=1.0;
  call foo(x*3.0)
end program
