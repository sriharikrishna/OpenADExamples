# explicit make rules

# fortran -> whirl
head.prepped.B: head.prepped.f90 
	${OPEN64ROOT}/crayf90/sgi/mfef90 -z -F -N132 $<
# whirl -> xaif
head.prepped.xaif : head.prepped.B 
	${OPENADFORTTKROOT}/bin/whirl2xaif -n -o $@ $<
# xaif -> xaif'
head.prepped.xb.xaif : head.prepped.xaif
	${XAIFBOOSTERROOT}/xaifBooster/algorithms/BasicBlockPreaccumulation/driver/oadDriver \
	-c ${XAIFSCHEMAROOT}/schema/examples/inlinable_intrinsics.xaif \
	-s ${XAIFSCHEMAROOT}/schema -i $< -o $@ 
# xaif' -> whirl'
head.prepped.xb.x2w.B : head.prepped.xb.xaif  
	${OPENADFORTTKROOT}/bin/xaif2whirl --structured head.prepped.B $<
# whirl' -> fortran'
head.prepped.xb.x2w.w2f.f: head.prepped.xb.x2w.B
	${OPEN64ROOT}/whirl2f/whirl2f -openad $<
# postprocess 
head.prepped.xb.x2w.w2f.pp.E.f: head.prepped.xb.x2w.w2f.f
	${OPENADFORTTK_BASE}/tools/SourceProcessing/postProcess.py -m f -o $@ $<

# we add the .E extension  here to distinguish the targets from the 
# rules using the openad script
driverE: $(addsuffix .E.o, $(RTSUPP)) driver.o head.prepped.xb.x2w.w2f.pp.E.o
	${F90C} -o $@ $^

w2f__types.E.f90: ${OPENADROOT}/runTimeSupport/all/w2f__types.f90
	cp -f $< $@

OAD_active.E.f90: ${OPENADROOT}/runTimeSupport/scalar/OAD_active.f90
	cp -f $< $@
