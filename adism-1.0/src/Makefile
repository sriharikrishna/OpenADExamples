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
$(error "need UMFPACK_LIB_DIR to be set in the environment pointing to an installation of UMFPACK v 2.2")
endif

# NetCDF (for Ubuntu/Linux Mint)
ifndef NETCDFROOT
NETCDFROOT = /usr
endif
# these depend on how netcdf was configured: 
NETCDFLIBS = -lnetcdff -lnetcdf
NETCDFLIBPATH = -L$(NETCDFROOT)/lib
IPATH+= -I$(NETCDFROOT)/include

# Compiler
ifndef F90C
export F90C=gfortran
endif

ifndef F90CFLAGS
export F90CFLAGS=-g -c $(IPATH)
endif

ifndef MPIFC
MPIFC=mpif90
endif

GLIMMER = glimmerThermal
GLIMLIB = $(GLIMMER)/libglimtherm.a
IPATH+= -I$(GLIMMER)

SOURCES = adism_ncdf adism_mbal adism_umf 	
RTSUPP = w2f__types OAD_active OAD_tape OAD_cp OAD_rev revolve
ADSDIR = adsupport

LD=$(F90C)
LDFLAGS=-L${UMFPACK_LIB_DIR} -lumfpack  -lblas ${NETCDFLIBPATH} $(NETCDFLIBS)

EXE = adism adism_FD adism_sens adism_sens_par adism_adjoint

all: $(GLIMLIB) $(EXE)

$(GLIMLIB): 
	cd $(GLIMMER) && $(MAKE)

adism:     $(addsuffix .o, $(SOURCES)) adism.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB) 
	$(LD) -o $@ $^ $(LDFLAGS)

adism_FD:  $(addsuffix .o, $(SOURCES)) adism_FD.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB) 
	$(LD) -o $@ $^ $(LDFLAGS)

adism_sens: $(addsuffix .o, $(SOURCES)) adism_sens.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o adism_umf.o adism_data.o $(GLIMLIB)
	$(LD) -o $@ $^ $(LDFLAGS)

adism_sens_par: $(addsuffix .o, $(SOURCES)) adism_sens_par.o adism_wrap.o adism_body.o adism_loop.o adism_core.o adism_mbal.o \
    adism_umf.o adism_data.o $(GLIMLIB)
	${MPIFC} -o $@ $^ $(LDFLAGS) 

adism_adjoint: $(addsuffix .o, $(RTSUPP)) \
	adism_data.o adism_ncdf.o adism_adcore.o adism_adjoint.o \
	cpSupport.o $(GLIMLIB) ${UMFPACK_LIB_DIR}/libumfpack.a
	$(LD) -o $@ $^ $(LDFLAGS)

%.o: %.F90
	$(F90C) $(F90CFLAGS) $< 

%.o: %.f90
	$(F90C) $(F90CFLAGS) $< 

%.o: $(ADSDIR)/%.f90
	$(F90C) $(F90CFLAGS) $< 

.PHONY: clean spotless

clean:
	cd $(GLIMMER) && $(MAKE) $@
	rm -f *.o *.mod head.f *~  data.dat

spotless: clean
	cd $(GLIMMER) && $(MAKE) $@
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
	$(MPIFC) -g -c $(F90CFLAGS) $< 
adism_data.o: adism_data.F90 adism_core.o
adism_adcore.o: adism_adcore.f90 OAD_tape.o

w2f__types.o: $(ADSDIR)/w2f__types.f90
OAD_active.o: $(ADSDIR)/OAD_active.f90
OAD_cp.o: $(ADSDIR)/OAD_cp.f90
OAD_rev.o: $(ADSDIR)/OAD_rev.f90
OAD_tape.o: $(ADSDIR)/OAD_tape.f90
revolve.o: $(ADSDIR)/revolve.f90
