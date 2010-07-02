module RevStats

public :: revStatsInit, revStatsUpdateTape, revStatsUpdateCP, revStatsDump

integer :: maxCP, maxTape

contains

  subroutine revStatsInit()
    maxCP=0
    maxTape=0
  end subroutine revStatsInit
  
  subroutine revStatsUpdateCP(cpPointer) 
    integer :: cpPointer
    if (cpPointer>maxCP) maxCP=cpPointer
  end subroutine revStatsUpdateCP
  
  subroutine revStatsupdateTape( tapePointer) 
    implicit none
    integer :: tapePointer
    if (tapePointer>maxTape) maxTape=tapePointer
  end subroutine revStatsupdateTape
  
  subroutine revStatsDump()
    print *, 'revStats: maxCP=',maxCP, ' maxTape=', maxTape
  end subroutine revStatsDump

end module RevStats
