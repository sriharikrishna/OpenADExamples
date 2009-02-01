ifndef (F90C)
F90C=gfortran
endif
RTSUPP=w2f__types OAD_active
driver: $(addsuffix .o, $(RTSUPP)) driver.o head.prepped.xb.x2w.w2f.pp.o
	${F90C} -o $@ $^
head.prepped.xb.x2w.w2f.pp.f $(addsuffix .f90, $(RTSUPP)) : toolChain 
toolChain : head.prepped.f90
	openad -c -m f $<

show:  head.prepped.xaif
	${XAIFBOOSTERROOT}/xaifBooster/algorithms/BasicBlockPreaccumulation/driver/oadDriver -v -V -i $< -s ${XAIFSCHEMAROOT}/schema -c ${XAIFSCHEMAROOT}/schema/examples/inlinable_intrinsics.xaif -o head.prepped.xb.xaif  -g 8

showScarce:  head.prepped.xaif
	${XAIFBOOSTERROOT}/xaifBooster/algorithms/BasicBlockPreaccumulation/driver/oadDriver -v -V -i $< -s ${XAIFSCHEMAROOT}/schema -c ${XAIFSCHEMAROOT}/schema/examples/inlinable_intrinsics.xaif -o head.prepped.xb.xaif  -g 8 -M 1

oadDriver:
	ln -s  ${XAIFBOOSTERROOT}/xaifBooster/algorithms/BasicBlockPreaccumulation/driver/oadDriver ./

%.o : %.f90
	${F90C} -o $@ -c $< 
%.o : %.f
	${F90C} -o $@ -c $< 
clean: 
	rm -f ad_template* OAD_* w2f__*  iaddr* oadDriver
	rm -f head.prepped.xb* *.B *.xaif *.o *.mod driver *~ 
.PHONY: clean toolChain show showScarce
