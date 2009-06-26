ifndef (F90C)
F90C=gfortran
endif
driverFD:  driverFD.o head.o
	${F90C} -o $@ $^
%.o : %.f90
	${F90C} -o $@ -c $< 
%.o : %.f
	${F90C} -o $@ -c $< 

head.f: 
	ln -s ../$@ ./
clean: 
	rm -f *.o *.mod driverFD head.f 
.PHONY: clean 
