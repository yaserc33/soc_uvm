    // =================================================================== //
    //   This is the example tb for connecting tracer to the riscv core
    // ================================================================== //
//uhiuhg
module tracer_rv32i_soc_tb;
    logic clk;
    logic reset_n;
    logic o_flash_sclk;
    logic o_flash_cs_n;
    logic o_flash_mosi;
    logic i_flash_miso;
    logic o_uart_tx;
    logic i_uart_rx;
    // more signals can be here 
// `define  TRACER_ENABLE=1; // any value -- (RTL) uncomment it to use tracer module
`ifdef TRACER_ENABLE
    logic [31:0] rvfi_insn;
    logic [4:0]  rvfi_rs1_addr;
    logic [4:0]  rvfi_rs2_addr;
    logic [31:0] rvfi_rs1_rdata;
    logic [31:0] rvfi_rs2_rdata;
    logic [4:0]  rvfi_rs3_addr;
    logic [31:0] rvfi_rs3_rdata;
    logic [4:0]  rvfi_rd_addr  ;
    logic [31:0] rvfi_rd_wdata ;
    logic [31:0] rvfi_pc_rdata ;
    logic [31:0] rvfi_pc_wdata ;
    logic [31:0] rvfi_mem_addr ;
    logic [31:0] rvfi_mem_wdata;
    logic [31:0] rvfi_mem_rdata;
    logic        rvfi_valid;
`endif
    logic srx_pad_i;
    logic stx_pad_o;
    logic rts_pad_o;
    logic cts_pad_i;
    logic current_pc_out;
    logic inst_out;
    wire [23:0] io_data;
    logic  [23:0] en_gpio;
    logic  [23:0] i_gpio;
    logic  [23:0] o_gpio;

    // Clock generator 
    initial clk = 0;
    always #10 clk = ~clk;

    // signal geneartion here
    initial begin 
        reset_n = 0;
        repeat(2) @(negedge clk);
        reset_n = 1; // dropping reset after two clk cycles
    end

    // =================================================== //
    //             Instantiation of the SoC
    // =================================================== //
    `ifdef TRACER_ENABLE
        parameter DMEM_DEPTH = 65536;
        parameter IMEM_DEPTH = 65536;
    `else  // for RTL who uses Vivado software
        parameter DMEM_DEPTH = 10000; // or 128
        parameter IMEM_DEPTH = 10000;
    `endif

    // Dut instantiation
    rv32i_soc #(
        .IMEM_DEPTH(IMEM_DEPTH), // NOTE TO DV: CHANGE THE SIZE OF IMEM AND DMEM TO ACCOMMODATE THE SIZE OF YOUR TESTS
        .DMEM_DEPTH(DMEM_DEPTH)
        // .IMEM_DEPTH(10000), // NOTE TO DV: CHANGE THE SIZE OF IMEM AND DMEM TO ACCOMMODATE THE SIZE OF YOUR TESTS
        // .DMEM_DEPTH(10000)
        // .NO_OF_GPIO_PINS(NO_OF_GPIO_PINS)
    )DUT(
        //.*
        .clk(clk),
        .reset_n(reset_n),
        //TRACER
    `ifdef TRACER_ENABLE
        .rvfi_insn(rvfi_insn),      
        .rvfi_rs1_addr(rvfi_rs1_addr),  
        .rvfi_rs2_addr(rvfi_rs2_addr),  
        // .rvfi_rs3_addr(rvfi_rs3_addr),  
        .rvfi_rs1_rdata(rvfi_rs1_rdata), 
        .rvfi_rs2_rdata(rvfi_rs2_rdata), 
        // .rvfi_rs3_rdata(rvfi_rs3_rdata),
        .rvfi_rd_addr(rvfi_rd_addr),   
        .rvfi_rd_wdata(rvfi_rd_wdata),  
        .rvfi_pc_rdata(rvfi_pc_rdata),  
        .rvfi_pc_wdata(rvfi_pc_wdata),  
        .rvfi_mem_addr(rvfi_mem_addr),  
        .rvfi_mem_wdata(rvfi_mem_wdata), 
        .rvfi_mem_rdata(rvfi_mem_rdata), 
        .rvfi_valid(rvfi_valid),      
    `endif
        
        // ports not used in core-verification
        .srx_pad_i(srx_pad_i), 
        .stx_pad_o(stx_pad_o), 
        .rts_pad_o(rts_pad_o),
        .cts_pad_i(cts_pad_i), 
        .io_data(io_data),
        .en_gpio(en_gpio),
        .i_gpio(i_gpio),
        .o_gpio(o_gpio),

        // ports used
        .current_pc_out(current_pc_out),  
        .inst_out(inst_out)        
    );


    // ============================================================================ //
    //     Example connection of tracer with WB stage signals in the data path
    // ============================================================================ //
    `ifdef TRACER_ENABLE 
        tracer tracer_inst (
        .clk_i(clk),
        .rst_ni(reset_n),
        .hart_id_i(1),
        .rvfi_insn_t(DUT.rv32i_core_inst.data_path_inst.rvfi_insn),
        .rvfi_rs1_addr_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rs1_addr),
        .rvfi_rs2_addr_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rs2_addr),
        .rvfi_rs3_addr_t(),
        .rvfi_rs3_rdata_t(),
        .rvfi_mem_rmask(),
        .rvfi_mem_wmask(),
        .rvfi_rs1_rdata_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rs1_rdata),
        .rvfi_rs2_rdata_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rs2_rdata),
        .rvfi_rd_addr_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rd_addr),
        .rvfi_rd_wdata_t(DUT.rv32i_core_inst.data_path_inst.rvfi_rd_wdata),
        .rvfi_pc_rdata_t(DUT.rv32i_core_inst.data_path_inst.rvfi_pc_rdata),
        .rvfi_pc_wdata_t(DUT.rv32i_core_inst.data_path_inst.rvfi_pc_wdata),
        .rvfi_mem_addr(DUT.rv32i_core_inst.data_path_inst.rvfi_mem_addr),
        .rvfi_mem_wdata(DUT.rv32i_core_inst.data_path_inst.rvfi_mem_wdata),
        .rvfi_mem_rdata(DUT.rv32i_core_inst.data_path_inst.rvfi_mem_rdata),
        .rvfi_valid(DUT.rv32i_core_inst.data_path_inst.rvfi_valid)
        );
    `endif


    // ============================================================================ //
    //  Logic to Initialize the instruction Memory and Data Memory with .hex files
    // ============================================================================ //


    // ============================================================================ //
    //                        Your Own testbench logic ....
    // ============================================================================ //
    
    // // template ...
    // // initializing the instruction memory after every reset
    // bit [31:0] initial_imem [0:IMEM_DEPTH - 1];
    // bit [31:0] initial_dmem [0:DMEM_DEPTH - 1];
    //
    // // initial begin
    //     $readmemh("/path/to/inst_formatted.hex",DUT.inst_mem_inst.dmem); // VIVADO
    //     $readmemh("/path/to/data_formatted.hex",DUT.data_mem_inst.dmem); // VIVADO
    //
    //     // // (in VCS for verification) use force-release instead of assign them directly
    //     // $readmemh("/path/to/inst_formatted.hex", initial_imem);
    //     // $readmemh("/path/to/data_formatted.hex", initial_dmem);
    //     // force DUT.inst_mem_inst.dmem = initial_imem;
    //     // force DUT.data_mem_inst.dmem = initial_dmem;
    //     // #1; 
    //     // release DUT.inst_mem_inst.dmem;
    //     // release DUT.data_mem_inst.dmem;
    //
    //     // display content of dmem & imem
    //     for (int i=0; i<DMEM_DEPTH; ++i   ) begin
    //         $display("%h",DUT.data_mem_inst.dmem[i]);
    //         $display("%h",DUT.inst_mem_inst.dmem[i]);
    //     end
    //
    //     repeat(10000) begin 
    //         @(posedge clk);
    //     end
    //     $finish;
    // end  // wait
    //
    // // enable waveform dump
    // initial begin 
    //     $dumpfile("waveform.vcd");
    //     $dumpvars(0);
    // end

    
    // initializing the instruction memory after every reset
       initial begin
           $readmemh("/home/it/Documents/rvsoc_v3/src/tb/uart_receiver/machine.hex", DUT.inst_mem_inst.dmem);
       end // wait 
    
       initial begin 
        //    repeat(100000) @(posedge clk);
        //    for(int i = 0; i<= 14'h0fff; i = i+1) begin 
        //        $display("imem[%02d] = %8h", i, DUT.inst_mem_inst.memory[i]);
        //    end
           repeat(10000) @(posedge clk);
           for(int i = 0; i < 100; i = i+1) begin 
               $display("dmem[%02d] => %8h <=> %8h <= imem[%02d] ", i, DUT.data_mem_inst.dmem[i], DUT.inst_mem_inst.dmem[i], i);
           end
            for(int i = 0; i<32; i = i+1) begin 
                $display("reg_file[%02d] = %03d", i, DUT.rv32i_core_inst.data_path_inst.reg_file_inst.reg_file[i]);
            end
           $finish;
       end
    initial begin
      $dumpfile("waveform.vcd");
      $dumpvars(0, DUT);
    end

    
    
    // // Verifcation ...
    // // initializing the instruction memory after every reset
    // logic [31:0] initial_imem [0:10000]  ;
    // logic [31:0] initial_dmem [0:10000]  ;
    //
    // initial begin // use your own path ...
    //     // // Reda ...
    //     // $readmemh("/home/Reda_Alhashem/git/uart_wb_uvcs/core-verification/need_verification/testbench/inst_formatted.hex", initial_imem);
    //     // $readmemh("/home/Reda_Alhashem/git/uart_wb_uvcs/core-verification/need_verification/testbench/data_formatted.hex", initial_dmem);
    //
    //     // Nouf ...
    //     $readmemh("/home/Nouf_Alsufyani/new_need_verification/testbench/inst_formatted.hex",  initial_imem);
    //     $readmemh("/home/Nouf_Alsufyani/new_need_verification/testbench/data_formatted.hex", initial_dmem);
    //
    //     // // Shahad ...
    //     // $readmemh("/home/Shahd_Abdulmohsan/core/riscv-dv/new_need_verification/testbench/inst_formatted.hex",  initial_imem);
    //     // $readmemh("/home/Shahd_Abdulmohsan/core/riscv-dv/new_need_verification/testbench/data_formatted.hex", initial_dmem);
    //
    //     // use force-release instead of direct assignment
    //     force DUT.inst_mem_inst.dmem = initial_imem;
    //     force DUT.data_mem_inst.dmem = initial_dmem;
    //     #1; 
    //     release DUT.inst_mem_inst.dmem;
    //     release DUT.data_mem_inst.dmem;
    //
    //     repeat(100000) @(posedge clk);
    //     $finish;
    // end  // wait
    //
    // // enable waveform dump
    // initial begin 
    //     $dumpfile("waveform.vcd");
    //     $dumpvars(0);
    // end


endmodule

