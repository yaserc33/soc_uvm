package spi_module_pkg;
 `include "uvm_macros.svh"
 import uvm_pkg::*;
 import spi_pkg::*;
 import wb_pkg::*;
// Import the Clock & Reset  package
import clock_and_reset_pkg::*;
   `include "wb_x_spi_module.sv"
    `include "scoreboard.sv"
  
    `include "spi_module.sv"
    
endpackage