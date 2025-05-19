`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_driver extends uvm_driver #(gpio_transaction);
  `uvm_component_utils(gpio_driver)

  // Virtual interface instance
  virtual gpio_if vif;

  // Constructor
  function new(string name = "gpio_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  //Get virtual interface from config DB
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual gpio_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVID", "Virtual interface not set")
    end
  endfunction

  //Main task to drive signals
  virtual task run_phase(uvm_phase phase);
    gpio_transaction trans;
    forever begin 
      seq_item_port.get_next_item(trans); //Get next transaction 

      // Drive inputs using the virtual interface
      vif.wb_clk_i <= trans.wb_clk_i;
      vif.wb_rst_i <= trans.wb_rst_i;
      vif.wb_cyc_i <= trans.wb_cyc_i;
      vif.wb_adr_i <= trans.wb_adr_i;
      vif.wb_dat_i <= trans.wb_dat_i;
      vif.wb_we_i  <= trans.wb_we_i;
      vif.wb_stb_i <= trans.wb_stb_i;
      vif.wb_sel_i <= trans.wb_sel_i;

      //wait for a clock or handshaking signal
      @(posedge vif.wb_clk_i);

      seq_item_port.item_done(); //Notify sequencer
    end
  endtask

endclass