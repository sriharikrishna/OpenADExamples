        subroutine template()
          use OAD_tape
          use OAD_rev
          use lu : trueTest => test
!$TEMPLATE_PRAGMA_DECLARATIONS

          integer iaddr
          external iaddr
          
          double precision , dimension(size(x)) :: passiveX, passiveB

          if (.not.our_rev_mode%adjoint) then
            passiveX=x&v
            passiveB=b&v
            call trueTest(A,passiveX,passiveB)
          end if 
        end subroutine template
