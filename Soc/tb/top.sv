
//Testbench top
module tb_top;
//Importing UVM and wishbone package
import uvm_pkg::*;
`include "uvm_macros.svh"

//Wishbone package
import wb_pkg::*;

//UART package
// import uart_pkg::*;


//SPI package
import spi_pkg::*;
import spi_module_pkg::*;

//clock and reset package
import clock_and_reset_pkg::*;

import soc_pkg::* ; 


`include "defines.sv"
`include "soc_mcsequencer.sv"
`include "wb_soc_sequences.sv"
// `include "wb_uart_sequences.sv"
`include "wb_spi_sequences.sv"
// `include "wb_uart_mcseqs_lib.sv"
`include "wb_spi_mcseqs_lib.sv"
`include "soc_mcseqs_lib.sv"
`include "soc_tb.sv"
`include "soc_system_test_lib.sv"
// `include "wb_uart_test_lib.sv"
`include "wb_spi_test_lib.sv"

uvm_event uvm_2_core_sync_event;

initial begin
  wb_vif_config::set(null, "*.wbenv.*", "vif", hw_top.wb_if);
  // uart_vif_config::set(null, "*.m_soc_tb.m_uart_env.*", "vif", hw_top.uart_if);
  spi_vif_config::set(null, "*.spienv1.slave_agent.*", "vif", hw_top.spi1_if);
  spi_vif_config::set(null, "*.spienv2.slave_agent.*", "vif", hw_top.spi2_if);
  clock_and_reset_vif_config::set(null, "*.clk_rst_env.*", "vif", hw_top.clk_rst_if);
 
  run_test("base_test");
end




// for C later

// initial begin
// //`ifdef VCS_SIM
//                 $readmemh("../cscripts/main.hex", hw_top.DUT.u_rv32i_soc.inst_mem_inst.tsmc_32k_inst.u0.mem_core_array);
//   //  `endif     

// end
//  initial begin
//  uvm_2_core_sync_event = new();
//  uvm_config_db#(uvm_event)::set(null, "*", "uvm_2_core_sync_event", uvm_2_core_sync_event);
// forever
// begin
// 	uvm_2_core_sync_event.wait_on ();
// 	$display("Trigger Rcevied in Tb Top()");	
// 	uvm_2_core_sync_event.reset();
// //		always @(*)
// //		begin	
// #10;
// 			force hw_top.DUT.u_rv32i_soc.data_mem_inst.tsmc_8k_inst.u0.mem_core_array[`DATA_MEMORY_ADDRESS_FOR_CORE_2_UVM_SYNC] =`UVM_2_CORE_SEQ_SYNC_MASK;
//         	        release hw_top.DUT.u_rv32i_soc.data_mem_inst.tsmc_8k_inst.u0.mem_core_array[`DATA_MEMORY_ADDRESS_FOR_CORE_2_UVM_SYNC];
// //		end

// end




	 
//#1000000;	 
//  $finish;
//  end

initial begin
  $dumpfile("Dump.vcd");
  $dumpvars;
end
endmodule : tb_top
