class soc_mcseq_lib extends uvm_sequence ;
    `uvm_object_utils(soc_mcseq_lib)
//declare the multichannel_sequencer
    `uvm_declare_p_sequencer(soc_mcsequencer)

  function new(string name="soc_mcseq_lib");
    super.new(name);
    uvm_config_db#(string)::set(null, "*", "seq_name", get_type_name());
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : soc_mcseq_lib



// class spi_simple_seq extends soc_mcseq_lib;
  
//     `uvm_object_utils(spi_simple_seq)

// // `uvm_declare_p_sequencer(soc_mcsequencer)

// //spi_m_seqr

//   enable_spi_core enable_spi;
//   // uart_5_seq uart_seq;
// spi_slave_write_seq spi_s_write ; 

//   function new(string name = "router_simple_mcseq");
//     super.new(name);
//     `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
//   endfunction: new


//   task body();
//     // `uvm_info(get_type_name(), "Starting UART Master Control Sequence", UVM_MEDIUM)
//     `uvm_do_on(enable_spi, p_sequencer.wb_seqr)

//     // `uvm_info(get_type_name(), "Finished UART Master Control Sequence", UVM_MEDIUM)
//   endtask
// endclass 

// class wbxspi_write_seq extends soc_mcseq_lib;
    
//     `uvm_object_utils(wbxspi_write_seq)
 

//     function new(string name ="wbxspi_write_seq");
//         super.new(name);
//     endfunction:new


//   // declare the sequences to run

//   wb_write_spi1_seq wb_spi1_write;
//   spi_slave_response_seq spi_seq;


// virtual task body;
// `uvm_info(get_type_name(), "body of mc_sequence 🧑🏻‍⚖️" , UVM_FULL)
// fork
// `uvm_do_on(wb_spi1_write, p_sequencer.wb_seqr)
// `uvm_do_on(spi_seq, p_sequencer.spi1_seqr)
// join

// endtask:body

// endclass 

// class wbxspi_flag_seq extends soc_mcseq_lib;
    
//     `uvm_object_utils(wbxspi_flag_seq)
 

//     function new(string name ="wbxspi_flag_seq");
//         super.new(name);
//     endfunction:new

// //declare the sequences you want to use
// wb_flags_spi1_seq wb_spi1_flag;
// spi_slave_response_seq spi_seq;

// virtual task body;
// `uvm_info(get_type_name(), "body of mc_sequence 🧑🏻‍⚖️" , UVM_FULL)
// fork
// `uvm_do_on(wb_spi1_flag, p_sequencer.wb_seqr)
// `uvm_do_on(spi_seq, p_sequencer.spi1_seqr)
// join

// endtask:body

// endclass

// class spi_simple_seq extends soc_mcseq_lib;
  
//     `uvm_object_utils(spi_simple_seq)

// // `uvm_declare_p_sequencer(soc_mcsequencer)

// //spi_m_seqr

//   enable_spi_core enable_spi;
//   // uart_5_seq uart_seq;
// spi_slave_write_seq spi_s_write ; 

//   function new(string name = "router_simple_mcseq");
//     super.new(name);
//     `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
//   endfunction: new


//   task body();
//     // `uvm_info(get_type_name(), "Starting UART Master Control Sequence", UVM_MEDIUM)
//     `uvm_do_on(enable_spi, p_sequencer.wb_seqr)

//     // `uvm_info(get_type_name(), "Finished UART Master Control Sequence", UVM_MEDIUM)
//   endtask
// endclass 

// class wbxspi_write_seq extends soc_mcseq_lib;
    
//     `uvm_object_utils(wbxspi_write_seq)
 

//     function new(string name ="wbxspi_write_seq");
//         super.new(name);
//     endfunction:new


//   // declare the sequences to run

//   wb_write_spi1_seq wb_spi1_write;
//   spi_slave_response_seq spi_seq;


// virtual task body;
// `uvm_info(get_type_name(), "body of mc_sequence 🧑🏻‍⚖️" , UVM_FULL)
// fork
// `uvm_do_on(wb_spi1_write, p_sequencer.wb_seqr)
// `uvm_do_on(spi_seq, p_sequencer.spi1_seqr)
// join

// endtask:body

// endclass 

// class wbxspi_flag_seq extends soc_mcseq_lib;
    
//     `uvm_object_utils(wbxspi_flag_seq)
 

//     function new(string name ="wbxspi_flag_seq");
//         super.new(name);
//     endfunction:new

// //declare the sequences you want to use
// wb_flags_spi1_seq wb_spi1_flag;
// spi_slave_response_seq spi_seq;

// virtual task body;
// `uvm_info(get_type_name(), "body of mc_sequence 🧑🏻‍⚖️" , UVM_FULL)
// fork
// `uvm_do_on(wb_spi1_flag, p_sequencer.wb_seqr)
// `uvm_do_on(spi_seq, p_sequencer.spi1_seqr)
// join

// endtask:body

// endclass