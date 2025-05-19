`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_sequencer extends uvm_sequencer #(gpio_transaction);
  `uvm_component_utils(gpio_sequencer)

  function new(string name ="gpio_sequencer" , uvm_component parent);
    super.new(name, parent);
  endfunction
endclass