ifndef (F90C)
F90C=gfortran
endif
ifndef (CC)
CC=gcc
endif
RTSUPP=w2f__types OAD_active OAD_cp OAD_tape OAD_rev 
driverADMsplit: $(addsuffix .o, $(RTSUPP) iaddr) head.xb.x2w.w2f.pp.o driverADMsplit.o init.o
	${F90C} -o $@ $^
head.xb.x2w.w2f.pp.f $(addsuffix .f90, $(RTSUPP)) iaddr.c : toolChain 
toolChain : head.f
	openad -c -m rs $<

%.o : %.f90
	${F90C} -o $@ -c $< 

%.o : %.f
	${F90C} -o $@ -c $< 

%.o : %.c
	${CC} -o $@ -c $< 

init.f: 
	ln -s ../$@ ./

head.f: 
	ln -s ../$@ ./

clean: 
	rm -f ad_template* ad_inline.f OAD_* w2f__*  iaddr* 
	rm -f head.* *.B *.xaif *.o *.mod* driverADMsplit init.f *~ 
.PHONY: clean toolChain
