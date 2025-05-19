`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_agent extends uvm_agent;
  `uvm_component_utils(gpio_agent)

//Components inside the agent 
  gpio_driver drv;
  gpio_sequencer seqr;
  gpio_monitor mon;

//interface handle
virtual gpio_if vif;

//constructor 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

//build phase 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual gpio_if)::get(this, "", "vif", vif))
      `uvm_fatal("AGENT/NOVIF", "Virtual interface not set for gpio_agent")

    drv = gpio_driver::type_id::create("drv", this);
    seqr = gpio_sequencer::type_id::create("seqr", this);
    mon = gpio_monitor::type_id::create("mon", this);
  endfunction

//Connect phase 
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.vif = this.vif;
    mon.gpio_if = this.vif;

//Connect the sequencer to the driver 
    drv.seq_item_port.connect(seqr.seq_item_export);
  
//Connect the monitor's analysis port to the analysis component 
monitor.analysis_port.connect(analysis_export);
  endfunction
endclass
