# filelist.f — VCS compile order for IO_TOP

-sverilog
-timescale=1ns/10ps

decoder.sv
gpio_defines.v
gpio_top.sv
io_mux.sv
PDD24DGZ.v
io_top.sv

# Interface file
gpio_if.sv

# Transaction class file
gpio_transaction.sv

# Driver file
gpio_driver.sv

# Monitor file
gpio_monitor.sv

# Sequencer file
gpio_sequencer.sv

# Sequence file
gpio_sequence.sv

# Agent file
gpio_agent.sv

# Environment file
gpio_env.sv

# Test file
gpio_test.sv

# Top-level module file
gpio_top.sv

# tb
tb.sv