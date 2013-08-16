# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# +                                                               +
# + ADISM makefile                                                +
# +                                                               +
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# Copyright (C) 2013 ADISM contributors - see COPYRIGHT file 
# for list of contributors.
#
# This program is free software; you can redistribute it and/or 
# modify it under the terms of the GNU General Public License as 
# published by the Free Software Foundation; either version 3 of 
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program; if not, write to the Free Software 
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
# 02111-1307 USA
#
# ADISM is maintained by:
#
# Ian Rutt, Swansea University (i.c.rutt@swansea.ac.uk)
# Jonathan McGovern, LGGE, France
#
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Library locations
# UMFPACK 2.2
ifndef UMFPACK_LIB_DIR
UMFPACK_LIB_DIR=../UMFPACK2.2
endif

# BLAS
ifndef BLAS_LIB_DIR
BLAS_LIB_DIR=../BLAS
endif

# NetCDF (for Ubuntu/Linux Mint)
ifndef NCDF_LIB
NCDF_LIB = /usr/lib
endif
ifndef NCDF_INC
NCDF_INC = /usr/include
endif
ifndef NCDFL
NCDFL = -lnetcdff
endif

# Compiler
ifndef FC
FC=gfortran
endif

ifndef MPIFC
MPIFC=mpif90
endif

GLIMMER = glimmerThermal
GLIMLIB = $(GLIMMER)/libglimtherm.a

SOURCES = adism_ncdf adism_mbal adism_umf 	
RTSUPP = w2f__types OAD_active OAD_tape OAD_cp OAD_rev revolve
ADSDIR = adsupport
GLIMMER_LIB_DIR=$(GLIMMER)

EXE = adism adism_FD adism_sens adism_sens_par adism_adjoint

all: $(GLIMLIB) $(EXE)

$(GLIMLIB): 
	cd $(GLIMMER) && $(MAKE)

adism:     $(addsuffix .o, $(SOURCES)) adism.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB) 
	${FC} -g -o $@ $^ -L${UMFPACK_LIB_DIR} -lumfpack -L${BLAS_LIB_DIR} -lblas -L${NCDF_LIB} ${NCDFL}

adism_FD:  $(addsuffix .o, $(SOURCES)) adism_FD.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB) 
	${FC} -o $@ $^ -L${UMFPACK_LIB_DIR} -lumfpack -L${BLAS_LIB_DIR} -lblas -L${NCDF_LIB} ${NCDFL}

adism_sens: $(addsuffix .o, $(SOURCES)) adism_sens.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB)
	${FC} -o $@ $^ -L${UMFPACK_LIB_DIR} -lumfpack -L${BLAS_LIB_DIR} -lblas -L${NCDF_LIB} ${NCDFL}

adism_sens_par: $(addsuffix .o, $(SOURCES)) adism_sens_par.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o \
    adism_umf.o adism_data.o $(GLIMLIB)
	${MPIFC} -o $@ $^ -L${UMFPACK_LIB_DIR} -lumfpack -L${BLAS_LIB_DIR} -lblas -L${NCDF_LIB} ${NCDFL}

adism_adjoint: $(addsuffix .o, $(RTSUPP)) ${GLIMMER_LIB_DIR}/libglimtherm.a adism_data.o \
	adism_ncdf.o adism_adcore.o adism_adjoint.o cpSupport.o ${UMFPACK_LIB_DIR}/libumfpack.a
	${FC} -o $@ $^ -L${NCDF_LIB} ${NCDFL} -L${UMFPACK_LIB_DIR} -L${GLIMMER_LIB_DIR} -lglimtherm -lumfpack -L${BLAS_LIB_DIR} -lblas

%.o: %.F90
	${FC} -g -c ${FCFLAGS} $< -I${NCDF_INC} -I${GLIMMER} ${NCDFL}

%.o: %.f90
	${FC} -g -c ${FCFLAGS} $< -I${NCDF_INC} -I${GLIMMER} ${NCDFL}

%.o: $(ADSDIR)/%.f90
	${FC} -g -c ${FCFLAGS} $< -I${NCDF_INC}

.PHONY: clean spotless

clean:
	rm -f *.o *.mod head.f *~  data.dat

spotless:
	rm -f *.o *.mod head.f *~  data.dat $(EXE)

adism_wrap.o: adism_wrap.F90 adism_body.o adism_core.o adism_loop.o adism_mbal.o adism_umf.o
adism_body.o: adism_body.F90 adism_core.o adism_ncdf.o adism_mbal.o
adism_ncdf.o: adism_ncdf.F90
adism_mbal.o: adism_mbal.F90 adism_core.o
adism_umf.o:  adism_umf.f90
adism_core.o: adism_core.F90
adism_loop.o: adism_loop.F90
adism.o:      adism.F90 adism_wrap.o adism_data.o
adism_FD.o:   adism_FD.F90 adism_wrap.o adism_data.o
adism_sens.o: adism_sens.F90 adism_wrap.o adism_data.o
adism_sens_par.o: adism_sens_par.F90 adism_wrap.o adism_data.o
	$(MPIFC) -g -c ${FCFLAGS} $< -I${NCDF_INC} -I${GLIMMER} ${NCDFL}
adism_data.o: adism_data.F90 adism_core.o
adism_adcore.o: adism_adcore.f90 OAD_tape.o

w2f__types.o: $(ADSDIR)/w2f__types.f90
OAD_active.o: $(ADSDIR)/OAD_active.f90
OAD_cp.o: $(ADSDIR)/OAD_cp.f90
OAD_rev.o: $(ADSDIR)/OAD_rev.f90
OAD_tape.o: $(ADSDIR)/OAD_tape.f90
revolve.o: $(ADSDIR)/revolve.f90
