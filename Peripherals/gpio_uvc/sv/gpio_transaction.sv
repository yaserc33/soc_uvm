`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_transaction extends uvm_sequence_item;
  `uvm_object_utils(gpio_transaction)

//Define the wishbone interface signals
  bit wb_clk_i;
  bit wb_rst_i;
  bit wb_cyc_i;
  bit [5:0] wb_adr_i;
  bit [31:0] wb_dat_i;
  bit [3:0] wb_sel_i;
  bit wb_we_i;
  bit wb_stb_i;

  function new(string name = "gpio_transaction");
    super.new(name);
  endfunction

 // Method to do print the transaction information
  function void do_print();
    $display("Transaction: wb_clk_i=%b, wb_rst_i=%b, wb_cyc_i=%b, wb_adr_i=%h, wb_dat_i=%h", wb_clk_i, wb_rst_i, wb_cyc_i, wb_adr_i, wb_dat_i);
  endfunction
  
endclass