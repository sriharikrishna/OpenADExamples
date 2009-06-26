ifndef (F90C)
F90C=gfortran
endif
driver:  driver.o head.o init.o
	${F90C} -o $@ $^
%.o : %.f90
	${F90C} -o $@ -c $< 
%.o : %.f
	${F90C} -o $@ -c $< 
clean: 
	rm -f *.o driver  
	cd FD && $(MAKE) $@
	cd TLM && $(MAKE) $@
	cd ADMjoint && $(MAKE) $@
	cd ADMsplit && $(MAKE) $@

.PHONY: clean 
