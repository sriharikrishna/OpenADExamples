! stubs for module LU

module luStubs

  use lu : trueSolve => solve, trueTest => test

  public :: solve

  interface solve
     module procedure solveImpl
  end interface

  interface test
     module procedure testImpl
  end interface

contains 

  subroutine solveImpl(A,x,b)
    !$openad template oad_template_solve.f90
    implicit none 
    double precision, intent(in) :: A(:,:), b(:)
    double precision, intent(out) :: x(:)
    double precision, dimension(size(A,1),size(A,2)) ::  L,U
    double precision, dimension(size(A,1)) ::  d
    double precision coeff
    ! just establish a simple dependency here
    ! so the analysis gets the right idea
    b(1)=A(1,1)*x(1)
  end subroutine solve

  subroutine testImpl(A,x,b)
    !$openad template oad_template_test.f90
    implicit none 
    double precision, intent(in) :: A(:,:), b(:)
    double precision, intent(out) :: x(:)
  end subroutine test

end module 
