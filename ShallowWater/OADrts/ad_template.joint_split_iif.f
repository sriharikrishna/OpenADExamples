      subroutine template()
      use OAD_cp
      use OAD_tape
      use OAD_rev

!$TEMPLATE_PRAGMA_DECLARATIONS

      type(modeType) :: our_orig_mode

      integer iaddr
      external iaddr

      if (our_rev_mode%arg_store) then 
        call cp_write_open()
!$PLACEHOLDER_PRAGMA$ id=4
        call cp_close()
      end if 
      if (our_rev_mode%arg_restore) then
        call cp_read_open()
!$PLACEHOLDER_PRAGMA$ id=6
        call cp_close()
      end if
      if (our_rev_mode%plain) then
!$PLACEHOLDER_PRAGMA$ id=1
      end if
      if (our_rev_mode%tape) then
         our_orig_mode=our_rev_mode
         our_rev_mode%arg_store=.FALSE.
         our_rev_mode%arg_restore=.FALSE.
         our_rev_mode%res_store=.FALSE.
         our_rev_mode%res_restore=.FALSE.
         our_rev_mode%plain=.FALSE.
         our_rev_mode%tape=.TRUE.
         our_rev_mode%adjoint=.FALSE.
!$PLACEHOLDER_PRAGMA$ id=2
         our_rev_mode%arg_store=.FALSE.
         our_rev_mode%arg_restore=.FALSE.
         our_rev_mode%res_store=.FALSE.
         our_rev_mode%res_restore=.FALSE.
         our_rev_mode%plain=.FALSE.
         our_rev_mode%tape=.FALSE.
         our_rev_mode%adjoint=.TRUE.
!$PLACEHOLDER_PRAGMA$ id=3
         our_rev_mode=our_orig_mode
      end if 
      end subroutine template
