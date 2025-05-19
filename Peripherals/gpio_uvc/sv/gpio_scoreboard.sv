`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_scoreboard extends uvm_component;
  `uvm_component_utils(gpio_scoreboard)

  uvm_analysis_imp #(gpio_transaction, gpio_scoreboard) analysis_export;

  function new(string name = "gpio_scoreboard", uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  virtual function void write(gpio_transaction trans);
    $display("Received transaction: %h", trans);

    if (trans.wb_dat_i !== trans.wb_dat_o) begin
      `uvm_error("SCOREBOARD_ERROR", "Mismatch between expected and actual data values")
    end
  endfunction
endclass