# COMPILER
FC = gfortran

# COMPILER FLAGS
FCimpno = -fimplicit-none
FCreal = -fdefault-real-8
FCchecks = -fbounds-check
FCwarn = -Wunused-value -Werror -W
FCfixed = -ffixed-form -ffixed-line-length-132
FCfree = -ffree-form
FCopt = -O2
FCdebug = -g

EXEC = steepening

COMPILE = $(FC) $(INCLUDES) $(FCimpno) $(FCreal) $(FCfree) -c $(FCwarn) $(FCchecks) $(FCopt)

%.o:%.f
	$(COMPILE) $<

steepening: burgers.o steepening.o
	$(FC) -o $@ burgers.o steepening.o

install: $(EXEC)
	cp $(EXEC) ..
	cd ..; mkdir -p data

clean:
	-@rm -f *.o *.mod $(EXEC)
