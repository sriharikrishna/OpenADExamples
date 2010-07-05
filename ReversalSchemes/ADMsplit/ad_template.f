        subroutine template()
          use OAD_tape
          use OAD_rev
          use RevStats

!$TEMPLATE_PRAGMA_DECLARATIONS

          integer iaddr
          external iaddr

         if (our_rev_mode%plain) then
           revStatsFCounters%__SRNAME__=revStatsFCounters%__SRNAME__+1
!$PLACEHOLDER_PRAGMA$ id=1
          end if
          if (our_rev_mode%tape) then
           revStatsFCounters%__SRNAME__=revStatsFCounters%__SRNAME__+1
!$PLACEHOLDER_PRAGMA$ id=2
          end if 
          if (our_rev_mode%adjoint) then
!$PLACEHOLDER_PRAGMA$ id=3
          end if 
        end subroutine template
