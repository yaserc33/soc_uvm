`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_sequence extends uvm_sequence #(gpio_transaction);
  `uvm_object_utils(gpio_sequence)

  function new(string name = "gpio_sequence");
    super.new(name);
  endfunction

  virtual task body();
    gpio_transaction tr;

    repeat (10) begin  // Generate 10 transactions
      tr = gpio_transaction::type_id::create("tr", this);
      start_item(tr);

      tr.wb_rst_i = $urandom_range(0, 1);
      tr.wb_cyc_i = $urandom_range(0, 1);
      tr.wb_adr_i = $urandom_range(0, 15);    
      tr.wb_dat_i = $urandom_range(0, 255);  
      tr.wb_we_i  = $urandom_range(0, 1);
      tr.wb_stb_i = $urandom_range(0, 1);
      tr.wb_sel_i = $urandom_range(0, 3);     

      finish_item(tr);
    end
  endtask
endclass