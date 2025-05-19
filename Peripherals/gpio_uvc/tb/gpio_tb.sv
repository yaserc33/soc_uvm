`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/rtl/gpio_top.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/rtl/io_mux.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/rtl/io_top.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/interface.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_transaction.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_sequence.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_driver.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_monitor.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_sequencer.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_agent.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_env.sv"
//`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_test.sv"
`include "/home/Mashael_Aljohani/VD-Mashael/GPIO/sv/gpio_scoreborad.sv"

`include "uvm_macros.svh"
import uvm_pkg::*;

module gpio_top;

  // Declare signals for the design under test (DUT)
  logic wb_clk_i;
  logic wb_rst_i;
  logic wb_cyc_i;
  logic wb_adr_i;
  logic wb_dat_i;
  logic wb_we_i;
  logic wb_stb_i;
  logic wb_sel_i;

  // Declare the interface
  gpio_if gpio_interface(
  wb_clk_i, 
  wb_rst_i, 
  wb_cyc_i, 
  wb_adr_i, 
  wb_dat_i, 
  wb_we_i, 
  wb_stb_i, 
  wb_sel_i
  );

  // Instantiate the environment for the test
  gpio_env env_inst("env_inst");

  // Connect the interface signals to the environment
  assign env_inst.vif = gpio_interface;

  // Clock generation
  always begin
    #5 wb_clk_i = ~wb_clk_i;  // Generate a clock with a period of 10 time units
  end

  // Reset generation
  initial begin
    wb_rst_i = 1'b1;   // Apply reset
    #10 wb_rst_i = 1'b0;  // Release reset after 10 time units
  end

  initial begin
    // Start the UVM test
    run_test();
  end

  task run_test();
    // Create and run the UVM test instance
    gpio_test test_inst("test_inst");
    test_inst.start(NULL);  // Start the test (NULL is the parent)
  endtask

endmodule
