subroutine template()
  use OAD_tape
  use OAD_rev
!$TEMPLATE_PRAGMA_DECLARATIONS
  double precision , dimension(size(x)) :: passiveX, passiveB
  if (our_rev_mode%plain) then
     passiveB=b%v
     call solve(n,A,passiveX,passiveB)
     x%v=passiveX
  end if
  if (our_rev_mode%tape) then
     passiveB=b%v
     call solve(n,A,passiveX,passiveB)
     x%v=passiveX
  end if
  if (our_rev_mode%adjoint) then
     passiveX=x%d
     call solve(n,A,passiveB,passiveX)
     b%d=b%d+passiveB
  end if
end subroutine template
