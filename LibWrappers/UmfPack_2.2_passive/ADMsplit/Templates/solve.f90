subroutine template()
  use OAD_tape
  use OAD_rev
!$TEMPLATE_PRAGMA_DECLARATIONS
  double precision , dimension(size(x)) :: passiveX, passiveB
  if (our_rev_mode%plain) then
     passiveB=b%v
     call solve(n,A,passiveX,passiveB,trans)
     x%v=passiveX
  end if
  if (our_rev_mode%tape) then
     passiveB=b%v
     call solve(n,A,passiveX,passiveB,trans)
     x%v=passiveX
     ! save A (do by hand what the inliner does)
     double_tape(double_tape_pointer:double_tape_pointer+ &
          (size(A,1)*size(A,2))-1)=reshape(A,(/size(A,1)*size(A,2)/))
     double_tape_pointer=double_tape_pointer+(size(A,1)*size(A,2))
  end if
  if (our_rev_mode%adjoint) then
     passiveX=x%d
     ! restore A: (do by hand what the inliner does)
     double_tape_pointer=double_tape_pointer-(size(A,1)*size(A,2))
     A(:,:)=reshape(double_tape(double_tape_pointer:),shape(A))
     call solve(n,A,passiveB,passiveX, .not. trans)  ! <---- flipping the transpose flag 
     b%d=b%d+passiveB
     x%d=0.0
  end if
end subroutine template
