        subroutine template()
          use OAD_tape
          use OAD_rev
          use OAD_cp
          use revolve
          use RevStats
!$TEMPLATE_PRAGMA_DECLARATIONS
          LOGICAL :: initialized=.FALSE.
          TYPE(rvAction) :: theAction
          CHARACTER , DIMENSION(80) :: errorMsg
          integer :: cpCount
          integer :: currIter
          type(modeType) :: our_orig_mode

          if (our_rev_mode%arg_store) then 
             call cp_write_open
!$PLACEHOLDER_PRAGMA$ id=4
             call cp_close
          end if 
          if (our_rev_mode%arg_restore) then
             call cp_read_open
!$PLACEHOLDER_PRAGMA$ id=6
             call cp_close
          end if
          if (our_rev_mode%plain) then
            revStatsFCounters%__SRNAME__=revStatsFCounters%__SRNAME__+1
            our_orig_mode=our_rev_mode
            our_rev_mode%arg_store=.FALSE.
!$PLACEHOLDER_PRAGMA$ id=1
            our_rev_mode=our_orig_mode
          end if 
          if (our_rev_mode%tape) then
            revStatsFCounters%__SRNAME__=revStatsFCounters%__SRNAME__+1
            call OAD_revStorePlain
C            print*, " tape       ", our_rev_mode
!$PLACEHOLDER_PRAGMA$ id=2
            call OAD_revAdjoint
          end if 
          call revStatsUpdateTape(oad_dt_ptr-1)
          if (our_rev_mode%adjoint) then
             our_orig_mode=our_rev_mode
             currIter=0
             write (*,fmt='(a)',advance='no') 'number of checkpoints = '
             read (*,*) cpCount 
             CALL rvVerbose(3)
             initialized=rvInit(n_max,cpCount,errorMsg)
             IF (.NOT.initialized) WRITE(*,'(A,A)') 'Error: ', errorMsg
             do while (theAction%actionFlag/=rvDone)
                theAction=rvNextAction()
                select case (theAction%actionFlag) 
                case (rvStore)
                  call cp_write_open(theAction%cpNum)
!$PLACEHOLDER_PRAGMA$ id=4
                  call cp_close
                case (rvRestore)
                  call cp_read_open(theAction%cpNum)
!$PLACEHOLDER_PRAGMA$ id=6
                  currIter=theAction%iteration
                  call cp_close
                case (rvForward)
                  call OAD_revPlain
                  do currIter=currIter,theAction%iteration-1
                    call box_forward(currIter)
                  end do
                case (rvFirstUTurn,rvUTurn)
                  call OAD_revTape
                  call box_forward(currIter)
                  call OAD_revAdjoint
                  call box_forward(currIter)
                end select   
              end do
              our_rev_mode=our_orig_mode
            end if 
          call revStatsUpdateCP(cp_fNumber()-1)
       end subroutine template
