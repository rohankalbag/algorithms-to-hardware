# build software version of testbench (to check the "desired behaviour")
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/include
GNUPTHUTILS_INCLUDE=$(AHIR_RELEASE)/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
SRC=./src
all: HW
TOAA:aalink
TOVC:aalink aa2vc
VC2VHDL: vc2vhdl  vhdlsim
AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
TOVHDL:TOVC vc2vhdl

TOPMODULES=-T shift_and_add_mul

HW: aalink aa2vc  vc2vhdl  vhdlsim
SW: aalink aa2c aa2cbuild

AA2VHDL: aa2vc vc2vhdl vhdlsim

# Aa to vC
aalink: $(SRC)/prog.aa
	AaLinkExtMem $(SRC)/prog.aa  | vcFormat > prog.linked.aa
	AaOpt -C prog.linked.aa | vcFormat > prog.linked.c.aa
	AaOpt -B prog.linked.c.aa | vcFormat > prog.linked.opt.aa

aa2vc: prog.linked.opt.aa
	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

aa2c: prog.linked.opt.aa
	mkdir aa2c
	Aa2C $(TOPMODULES) -o aa2c prog.linked.opt.aa
	#gcc -g -o testbench_sw -DSW -I ./ -I $(PTHREADUTILS_INCLUDE)  aa_c_model.c src/testbench.c -L $(PIPEHANDLER_LIB) -lPipeHandler -lpthread -l BitVectors$

aa2cbuild: aa2c/aa_c_model.c  aa2c/aa_c_model_internal.h aa2c/aa_c_model.h
	gcc -g -c -DSW -I$(PIPEHANDLER_INCLUDE) -Iaa2c/ aa2c/aa_c_model.c -o aa2c/aa_c_model.o
	gcc -g -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -Iaa2c/ -I$(SRC) $(SRC)/testbench.c -o aa2c/testbench.o
	gcc -g -o testbench_sw aa2c/aa_c_model.o aa2c/testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread -lBitVectors -lSockPipes


# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl  -O -I 2 -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c $(SRC)/testbench.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLibPipeHandler -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.dot aa2c

PHONY: all clean