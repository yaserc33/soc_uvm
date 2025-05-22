# Filelists
CORE_LIST := rtl_filelist.f
# CORE_LIST := ../../RivRtos/src/filelist.f
MODULES_LIST := filelist.f


# Compile using both filelists
compile:
	vcs -full64 -ntb_opts uvm -sverilog  +define+$(DV_MODE) -debug_all -kdb -j12 -timescale=1ns/1ns \
	    -f $(MODULES_LIST) -f $(CORE_LIST) -o simv

# Run simulation using run.f
run: compile
	./simv -f run.f

# Clean simulation output files
clean:
	rm -rf simv simv.daidir csrc *.vcd *.log ucli.key *.fsdb *.bak *.sv.d

# Default target: pull all, compile, run
all: compile run

