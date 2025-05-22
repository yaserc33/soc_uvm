class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Analysis ports
  `uvm_analysis_imp_decl(_spi1)
  uvm_analysis_imp_spi1#(spi_transaction, scoreboard) spi_in1;

  `uvm_analysis_imp_decl(_spi2)
  uvm_analysis_imp_spi2#(spi_transaction, scoreboard) spi_in2;

  `uvm_analysis_imp_decl(_ref)
  uvm_analysis_imp_ref#(wb_transaction, scoreboard) ref_in;

  // Stats
  int total_packets_received = 0;
  int total_matched_packets  = 0;
  int total_wrong_packets    = 0;
  int total_spi_transactions = 0;
  int total_ref_transactions = 0;

  // Reference model instance 
  wb_x_spi_module ref_model;
string test_name, seq_name;
  // Constructor
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    spi_in1 = new("spi_in1", this);
    spi_in2 = new("spi_in2", this);
    ref_in  = new("ref_in", this);
    
     
  endfunction

  // SPI 1 callback
  function void write_spi1(spi_transaction t);
    `uvm_info("SCOREBOARD", $sformatf("Received SPI1 Transaction: %s", t.sprint()), UVM_MEDIUM)
    // ref_model.tx_queue.push_back(t.data_in);
    ref_model.rx_queue.push_back(t.data_out);
    ref_model.spi_queue.push_back(t);
    total_spi_transactions++;
    total_packets_received++;
    compare_transactions();
  endfunction

  // SPI 2 callback
  function void write_spi2(spi_transaction t);
    `uvm_info("SCOREBOARD", $sformatf("Received SPI2 Transaction: %s", t.sprint()), UVM_MEDIUM)
    // ref_model.tx_queue.push_back(t.data_in);
    ref_model.rx_queue.push_back(t.data_out);
    ref_model.spi_queue.push_back(t);
    total_spi_transactions++;
    total_packets_received++;
    compare_transactions();
  endfunction

  // Reference Model callback
  function void write_ref(wb_transaction t);
    `uvm_info("SCOREBOARD", $sformatf("Received REF Transaction: %s", t.sprint()), UVM_MEDIUM)
     if(t.addr ==2) begin
    ref_model.tx_queue.push_back(t.din);
    ref_model.rx_queue.push_back(t.dout);
     end
    ref_model.wb_queue.push_back(t);
    total_ref_transactions++;
    total_packets_received++;
    compare_transactions();
  endfunction


function void compare_transactions();
  if (ref_model.wb_queue.size() == 0)
    return;

  else  begin
  wb_transaction ref_pkt = ref_model.wb_queue.pop_front();
   if (ref_pkt.op_type == wb_read) begin
  // Only expect SPI data for SPDR register 
    case (ref_pkt.addr)
      32'h0: compare_reg("SPCR", ref_pkt.dout, ref_model.get_SPCR());
      32'h1: compare_reg("SPSR", ref_pkt.dout, ref_model.get_SPSR());
       32'h2: begin // SPDR
            if (ref_model.spi_queue.size() > 0 &&
            ref_model.rx_queue.size() > 0 &&
            ref_model.tx_queue.size() > 0) begin
            bit [7:0] expected_data = ref_model.rx_queue.pop_front();
            bit [7:0] actual_data   = ref_model.tx_queue.pop_front();
            spi_transaction spi_pkt = ref_model.spi_queue.pop_front();
            if (spi_pkt.data_in == ref_model.get_SPDR()) begin
              total_matched_packets++;
              `uvm_info("SCOREBOARD", $sformatf("MATCH: WB read = %h, expected SPI = %h",  ref_model.get_SPDR(),spi_pkt.data_in), UVM_HIGH)
     
            end else begin
              total_wrong_packets++;
              `uvm_error("SCOREBOARD", $sformatf("MISMATCH: WB read = %h, expected SPI = %h", ref_model.get_SPDR(), spi_pkt.data_in))
            end
             
            end
            end 
      32'h3: compare_reg("SPER", ref_pkt.dout, ref_model.get_SPER());
      32'h4: compare_reg("CSREG", ref_pkt.dout, ref_model.get_CSREG());
     default: begin 
        `uvm_warning("SCOREBOARD", "Unhandled address in comparison");
         end 
    endcase
   
  end 
 

    //                 `uvm_info("SCOREBOARD", $sformatf(
    //           "Queue Sizes — wb_queue: %0d, spi_queue: %0d, rx_queue: %0d, tx_queue: %0d",
    //           ref_model.wb_queue.size(), ref_model.spi_queue.size(),
    //           ref_model.rx_queue.size(), ref_model.tx_queue.size()
    //         ), UVM_MEDIUM)
    //          if (ref_model.wb_queue.size() == 0)
    // return;

  end 
endfunction


function void compare_reg(string name, bit [7:0] actual, bit [7:0] expected);
    void'(ref_model.rx_queue.pop_front());
      void'(ref_model.tx_queue.pop_front());
  if (actual == expected) begin
    total_matched_packets++;
    `uvm_info("SCOREBOARD", $sformatf("MATCH: WB = %h, REF_MODEL %s = %h", actual, name, expected), UVM_HIGH)
  end else begin
    total_wrong_packets++;
    `uvm_error("SCOREBOARD", $sformatf("MISMATCH: WB = %h, REF_MODEL %s = %h", actual, name, expected))
  end
endfunction

  // Report
  function void report_phase(uvm_phase phase);
  `uvm_info("SCOREBOARD", "ENTERED report_phase!", UVM_NONE)
    `uvm_info("SCOREBOARD", "-------------------- SCOREBOARD REPORT --------------------", UVM_LOW)
    `uvm_info("SCOREBOARD", $sformatf("Total SPI Transactions  : %0d", total_spi_transactions), UVM_LOW)
    `uvm_info("SCOREBOARD", $sformatf("Total REF Transactions  : %0d", total_ref_transactions), UVM_LOW)
    `uvm_info("SCOREBOARD", $sformatf("Total Received Packets  : %0d", total_packets_received), UVM_LOW)
    `uvm_info("SCOREBOARD", $sformatf("Total Matched Packets   : %0d", total_matched_packets), UVM_LOW)
    `uvm_info("SCOREBOARD", $sformatf("Total Wrong Packets     : %0d", total_wrong_packets), UVM_LOW)
   
    if (!uvm_config_db#(string)::get(this, "", "test_name", test_name))
          `uvm_warning("SCOREBOARD", "Could not retrieve test_name from config DB");

      if (!uvm_config_db#(string)::get(this, "", "seq_name", seq_name))
          `uvm_warning("SCOREBOARD", "Could not retrieve seq_name from config DB");
          
    `uvm_info("SCOREBOARD", $sformatf("Test name: %s , Sequence name : %s", test_name,seq_name), UVM_LOW)

  endfunction

endclass