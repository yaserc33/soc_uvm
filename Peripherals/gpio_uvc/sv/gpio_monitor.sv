`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_monitor extends uvm_monitor #(gpio_transaction);
  `uvm_component_utils(gpio_monitor)

  virtual gpio_if vif;
  uvm_analysis_port #(gpio_transaction) analysis_port;

//Constructor 
  function new(string name = "gpio_monitor", uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

//Get interface 
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual gpio_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVID", "Virtual interface not set for monitor")
    end
  endfunction

virtual task run_phase(uvm_phase phase);
    gpio_transaction trans;
    forever begin
      @(posedge vif.wb_clk_i);
      trans = gpio_transaction::type_id::create("trans");
      
      trans.wb_clk_i = vif.wb_clk_i;
      trans.wb_rst_i = vif.wb_rst_i;
      trans.wb_cyc_i = vif.wb_cyc_i;
      trans.wb_adr_i = vif.wb_adr_i;
      trans.wb_dat_i = vif.wb_dat_i;
      trans.wb_we_i  = vif.wb_we_i;
      trans.wb_stb_i = vif.wb_stb_i;
      trans.wb_sel_i = vif.wb_sel_i;

      analysis_port.write(trans);
    end
  endtask

endclass
