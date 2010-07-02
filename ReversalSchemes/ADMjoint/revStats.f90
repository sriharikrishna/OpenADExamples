module RevStats

public :: revStatsInit, revStatsupdate, revStatsDump

integer :: maxCP, maxTape

contains
  subroutine revStatsInit()
    maxCP=0
    maxTape=0
  end subroutine revStatsInit
  
  subroutine revStatsupdate(cpPointer, tapePointer) 
    integer :: cpPointer, tapePointer
    if (cpPointer>maxCP) maxCP=cpPointer
    if (tapePoiner>maxTape) maxTape=tapePointer
  end subroutine revStatsupdate
  
  subroutine revStatsDump()
    print *, 'revStats: maxCP=',maxCP, ' maxTape=', maxTape
  end subroutine revStatsDump

end module RevStats
