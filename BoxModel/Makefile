ifndef F90C
F90C=gfortran
endif
driver:  all_globals_mod.o driver.o head.o
	${F90C} -o $@ $^
%.o : %.f90
	${F90C} -o $@ -c $< 
%.o : %.f
	${F90C} -o $@ -c $< 

all: driver
	cd FD && $(MAKE) 
	cd TLM && $(MAKE) 
	cd TLMvec && $(MAKE) 
	cd ADMjoint && $(MAKE) 
	cd ADMsplit && $(MAKE)
	cd TLMvec && $(MAKE) 

clean: 
	rm -f *.o *.mod driver  
	cd FD && $(MAKE) $@
	cd TLM && $(MAKE) $@
	cd TLMvec && $(MAKE) $@
	cd ADMjoint && $(MAKE) $@
	cd ADMsplit && $(MAKE) $@
	cd TLMvec && $(MAKE) $@

.PHONY: clean all
