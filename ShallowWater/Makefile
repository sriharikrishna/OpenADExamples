FC      = gfortran
FFLAGS  = -fdefault-real-8 -fdefault-double-8
FIXEDFORMAT = -ffixed-line-length-none -ffixed-form
CC      = gcc
CFLAGS  = -O3
FPP     = cpp
FPPFLAGS = -traditional-cpp
LFLAGS  = 
IPATH   = -I. -I./Inc
LIBS    = -lnetcdff -lnetcdf

# modules to push through OpenAD
SRCMODS = \
adsize.f90 \
size.f90 \
parms.f90 \
vars.f90 \
pfields.f90 \
force.f90 \
data.f90 \
weights.f90 \
mini.f90 \
size_small.f90

# code to push through OpenAD
# without IO
SRCFILES = \
inifields.F \
readparms.F \
iowrapper.F \
read_data.F \
make_weights.F \
map_control_vector.F \
small_routines_split.F \
small_routines_joint.F \
cost_function.F \
cost_depth.F \
loop_body_wrapper_inner.F \
loop_body_wrapper_outer.F \
forward_model.F 

default: Run links Run/shallow_water_ad

Run : 
	mkdir Run

links: 
	ln -sf ../Data/data Run/data
	ln -sf ../Data/data.orig Run/data.orig
	ln -sf ../Data/restart_long.nc Run/restart_long.nc
	ln -sf ../Data/weights_depth_diff.nc Run/weights_depth_diff.nc
	ln -sf ../Data/weights_depth.nc Run/weights_depth.nc

###################################################################
# shallow_water_ad
###################################################################

# OpenAD helper modules 
OADSUPPORTMODS = \
w2f__types.f90 \
OAD_active.f90 \
OAD_cp.f90 \
OAD_dct.f90 \
OAD_tape.f90 \
OAD_rev.f90

Run/shallow_water_ad: $(addprefix OpenAD/, $(OADSUPPORTMODS:.f90=.o)) \
	              numericalCore.xb.x2w.w2f.pp.o \
                      OpenAD/iaddr.o \
                      OpenAD/timeRatio.o \
		      ionetcdf.o \
                      main.prepped.o
	$(FC) $(LFLAGS) -o $@ $^ $(LIBS)  

# concatenate all sources into a single file
numericalCore.f : $(SRCMODS) $(SRCFILES:.F=.f)
	cat $^ > $@

# fortran -> whirl
numericalCore.B: numericalCore.f 
	${OPEN64ROOT}/crayf90/sgi/mfef90 -z -F -N132 $<

# whirl -> xaif
numericalCore.xaif : numericalCore.B 
	${OPENADFORTTKROOT}/bin/whirl2xaif -o $@ $<

# xaif -> xaif'
numericalCore.xb.xaif : numericalCore.xaif
	${XAIFBOOSTERROOT}/xaifBooster/algorithms/BasicBlockPreaccumulationReverse/test/t -i $< -c ${XAIFSCHEMAROOT}/schema/examples/inlinable_intrinsics.xaif -s ${XAIFSCHEMAROOT}/schema -o $@ -U

# xaif' -> whirl'
numericalCore.xb.x2w.B : numericalCore.xb.xaif  
	${OPENADFORTTKROOT}/bin/xaif2whirl --structured numericalCore.B $<

# whirl' -> fortran'
numericalCore.xb.x2w.w2f.f: numericalCore.xb.x2w.B
	${OPEN64ROOT}/whirl2f/whirl2f -openad $<

# postprocess 
numericalCore.xb.x2w.w2f.pp.f: numericalCore.xb.x2w.w2f.f
	perl ${OPENADFORTTKROOT}/bin/multi-pp.pl $<

###################################################################
# generic stuff 
###################################################################

# cancel the built in rule: 
%.o:%.F 

# F77 preprocessor rule: 
%.f:%.F
	$(FPP) $(FPPFLAGS) $(IPATH) -o $@ $< 

# F77 compile rules
%.o:%.f 
	$(FC) $(FIXEDFORMAT) -c $(FFLAGS) -o $@ $< 

OpenAD/%.o:OpenAD/%.f 
	$(FC) -c $(FFLAGS) -o $@ $< 

%.o:%.f90 
	$(FC) -c $(FFLAGS) -o $@ $< 

OpenAD/%.o:OpenAD/%.f90 
	$(FC) -c $(FFLAGS) -o $@ $< 

OpenAD/%.o:OpenAD/%.c 
	$(CC) -c $< -o $@

clean:
	rm -f numericalCore* 
	rm -f *.o *.mod *.mod-whirl OpenAD/*.o
	rm -f $(SRCFILES:.F=.f)
	rm -f ionetcdf.f main.f 
	rm -rf Run

.SUFFIXES: .f90 .F .f .o 

all: default Run/shallow_water

.PHONY : default all links clean 

.PRECIOUS: %.f OpenAD/%.f

###################################################################
# original shallow_water 
###################################################################

Run/shallow_water: $(SRCMODS:.f90=.o) $(SRCFILES:.F=.o) ionetcdf.o main.o 
	$(FC) $(LFLAGS) -o $@ $^ $(LIBS)

