ifndef F90C
F90C=gfortran
endif
driver: lu.o  driver.o head.o 
	${F90C} -o $@ $^
%.o : %.f90
	${F90C} -o $@ -c $< 
clean: 
	rm -f *.o *.mod driver  
	cd FD && $(MAKE) $@
	cd ADMsplit && $(MAKE) $@

.PHONY: clean 
