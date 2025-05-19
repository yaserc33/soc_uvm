`include "uvm_macros.svh"
import uvm_pkg::*;

class gpio_env extends uvm_env;
  `uvm_component_utils(gpio_env)

  gpio_agent agent;
  gpio_scoreboard sb;


//Constructor 
  function new(string name = "gpio_env", uvm_component parent);
    super.new(name, parent);
  endfunction

//build phase 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = gpio_agent::type_id::create("agent", this);
    sb = gpio_scoreboard::type_id::create("sb", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.analysis_port.connect(sb.analysis_export);
  endfunction
endclass
