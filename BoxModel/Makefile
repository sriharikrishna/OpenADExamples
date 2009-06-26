ifndef (F90C)
F90C=gfortran
endif
driver:  all_globals_mod.o driver.o head.o
	${F90C} -o $@ $^
%.o : %.f90
	${F90C} -o $@ -c $< 
%.o : %.f
	${F90C} -o $@ -c $< 
clean: 
	rm -f *.o *.mod driver  
	cd FD && $(MAKE) $@

.PHONY: clean 
