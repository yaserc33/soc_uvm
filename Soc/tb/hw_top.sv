module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;
  logic         STx_O;

    logic CLK_PAD;
    logic RESET_N_PAD;
    logic o_flash_sCLK_PAD;
    logic o_flash_cs_n;
    logic o_flash_mosi;
    logic i_flash_miso;
    logic o_uart_tx;
    logic i_uart_rx;
    logic pwm_pad_o;

    logic tck_i;
    logic tdi_i;
    logic tms_i;
    logic tdo_o;

    parameter DMEM_DEPTH = 2048;
    parameter IMEM_DEPTH = 16384;
    parameter NO_OF_GPIO_PINS = 24;

    logic CLK_PAD;  // external clock pad
    logic RESET_N_PAD;          // external reset (active low)
    logic O_FLASH_SCLK_PAD;     // external SPI flash serial clock
    logic O_FLASH_CS_N_PAD;     // external SPI flash chip‐select (active low)
    logic O_FLASH_MOSI_PAD;     // external SPI flash MOSI
    logic I_FLASH_MISO_PAD;     // external SPI flash MISO
    logic O_UART_TX_PAD;        // external UART TX
    logic I_UART_RX_PAD;       // external UART RX
    wire [23:0] IO_DATA_PAD;  // external GPIO pads
    logic O_PWM_PAD;
// Power ports
    logic  VDD_LEFT;                // Power
    logic  VDD_RIGHT;                // Ground
    logic  VDD_TOP;                // Power
    logic  VDD_BOTTOM;                // Ground
    logic  VSS_LEFT;                // Power
    logic  VSS_RIGHT;                // Ground
    logic VSS_TOP;                // Power
    logic  VSS_BOTTOM;                // Ground
    logic VDDPST_LEFT;             // Power
    logic VDDPST_RIGHT;            // Ground
    logic VDDPST_TOP;              // Power
    logic VDDPST_BOTTOM;           // Ground
    logic VSSPST_LEFT;             // Ground
    logic VSSPST_RIGHT;            // Power
    logic VSSPST_TOP;              // Ground
    logic VSSPST_BOTTOM;           // Power

//JTAG pad signals
    logic I_TCK_PAD; // external JTAG TCK
    logic I_TMS_PAD; // external JTAG TMS
    logic I_TDI_PAD; // external JTAG TDI
    logic O_TDO_PAD; // external JTAG TDO



   logic SPI1_SCK;
   logic SPI1_MOSI;
   logic SPI1_MISO;


    assign CLK_PAD = clock;
    assign RESET_N_PAD = ~reset;

    // Dut instantiation
    top_rv32i_soc DUT(
        .*
    );

   
 assign SPI1_SCK = IO_DATA_PAD[21];
 assign IO_DATA_PAD[22]= SPI1_MISO;
 assign SPI1_MOSI = IO_DATA_PAD[23];

// //assign spi1_if.select = IO_DATA_PAD[20];//SPI1_SS0;
//  assign spi1_if.mosi = SPI1_MOSI;
//  assign SPI1_MISO = spi1_if.miso;
 
 

//GPIOs for SPI sck, cs, MOSI, MISO

  //wishbone interface
  wb_if  wb_if(clock, reset);

  //SPI interface
  spi_if spi1_if(clock,reset);
  spi_if spi2_if(clock,reset);

  //UART interface
  // uart_if uart_if(clock,reset);

   // clock and reset interface 
  clock_and_reset_if clk_rst_if(
    .clock(clock),
    .reset(reset),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );


  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );

  /*
  //Adding RTL
  uart_top	UART(.wb_clk_i(clock), 
                // Wishbone signals
	              .wb_rst_i(reset), .wb_adr_i(wb_if.adr_i), .wb_dat_i(wb_if.dat_i), .wb_dat_o(wb_if.dat_o), .wb_we_i(wb_if.we_i), .wb_stb_i(wb_if.stb_i), .wb_cyc_i(wb_if.cyc_i), .wb_ack_o(wb_if.ack_o), .wb_sel_i(wb_if.sel_i),
	              .int_o(wb_if.inta_o), // interrupt request
              	// UART	signals
              	// serial input/output
	              .stx_pad_o(UART_if.STx_O), .srx_pad_i(UART_if.SRx_I),
              	// modem signals
	              .rts_pad_o(), .cts_pad_i(), .dtr_pad_o(), .dsr_pad_i(), .ri_pad_i(), .dcd_pad_i());
	*/




  assign wb_if.dout  = DUT.u_rv32i_soc.wb_s2m_io_dat;
  assign wb_if.ack = DUT.u_rv32i_soc.wb_s2m_io_ack;
  assign spi1_if.cs=DUT.u_rv32i_soc.o_flash_cs_n ;
  assign spi1_if.sclk=DUT.u_rv32i_soc.o_flash_sclk;
  assign spi2_if.cs=DUT.u_rv32i_soc.o_cs_n ;
  assign spi2_if.sclk=DUT.u_rv32i_soc.o_sclk;
  assign spi1_if.mosi=DUT.u_rv32i_soc.o_flash_mosi;
  assign spi2_if.mosi=DUT.u_rv32i_soc.o_mosi;

  `ifndef SOC_DV_WITH_CORE 
    always@(*)
    begin    
  force DUT.u_rv32i_soc.wb_m2s_io_adr = wb_if.addr;
  force DUT.u_rv32i_soc.wb_m2s_io_dat = wb_if.din;
  //there is no sel signal in the interface of the wb
  force DUT.u_rv32i_soc.wb_m2s_io_sel = 4'b1111; // assuming all bytes selected
  force DUT.u_rv32i_soc.wb_m2s_io_we  = wb_if.we;
  force DUT.u_rv32i_soc.wb_m2s_io_stb = wb_if.stb;
  force DUT.u_rv32i_soc.wb_m2s_io_cyc = wb_if.cyc;
  force DUT.u_rv32i_soc.i_flash_miso=spi1_if.miso;
  force DUT.u_rv32i_soc.i_miso=spi2_if.miso;
   
    end

 `else  

   assign wb_if.addr =  DUT.u_rv32i_soc.wb_m2s_io_adr;
   assign wb_if.din =  DUT.u_rv32i_soc.wb_m2s_io_dat;
   //assign wb_if.sel_i =  DUT.u_rv32i_soc.wb_m2s_io_sel;
   assign wb_if.we =  DUT.u_rv32i_soc.wb_m2s_io_we;
   assign wb_if.cyc =  DUT.u_rv32i_soc.wb_m2s_io_cyc;
   assign wb_if.stb =  DUT.u_rv32i_soc.wb_m2s_io_stb;

  `endif


//
    // assign uart_if.STx_O=O_UART_TX_PAD;	
    // assign I_UART_RX_PAD = UART_if.SRx_I;	




endmodule : hw_top
