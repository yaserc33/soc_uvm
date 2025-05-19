interface gpio_if(input logic clk);

  // GPIO signals
  logic wb_clk_i;       // Clock signal for the GPIO interface
  logic wb_rst_i;       // Reset signal for the GPIO interface
  logic wb_cyc_i;       // Cycle signal
  logic [3:0] wb_adr_i; // Address for the GPIO interface
  logic [7:0] wb_dat_i; // Data input
  logic wb_we_i;        // Write enable signal
  logic wb_stb_i;       // Strobe signal
  logic [3:0] wb_sel_i; // Select signals

  logic wb_dat_o;       // Data output
  logic wb_ack_o;       // Acknowledge output
  logic wb_err_o;       // Error signal

endinterface
