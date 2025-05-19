// class base_test extends uvm_test;   
//   `uvm_component_utils(base_test)

//   soc_tb tb_soc; 

//   function new(string name = "base_test", uvm_component parent = null);
//     super.new(name, parent);
//     `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
//   endfunction

//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);
//     tb_soc = soc_tb::type_id::create("tb_soc", this);

//     // Common config
//     uvm_config_int::set(this, "tb_soc.wbenv.masters[0]", "is_active", UVM_ACTIVE);  
//     uvm_config_int::set(this, "*", "recording_detail", 1);

//      uvm_config_db#(string)::set(null, "*", "test_name", get_type_name());
//     `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
//   endfunction

//   function void check_phase(uvm_phase phase);
//     check_config_usage();
//   endfunction

//   function void end_of_elaboration_phase(uvm_phase phase);
//     uvm_top.print_topology();
//   endfunction

//   task run_phase(uvm_phase phase);
//     uvm_objection obj = phase.get_objection();
//     obj.set_drain_time(this, 200ns);
//   endtask
// endclass
class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  // SoC testbench
  soc_tb tb_soc;

  // Optional config objects
  string m_tb_name;

  // Constructor
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Set dynamic testbench name
    m_tb_name = "tb_soc";
    tb_soc = soc_tb::type_id::create(m_tb_name, this);


    // Common testbench-wide config
      uvm_config_db#(string)::set(null, "*", "m_tb_name", m_tb_name);
    uvm_config_int::set(this, "tb_soc.wbenv.masters[0]", "is_active", UVM_ACTIVE);
    uvm_config_int::set(this, "*", "recording_detail", UVM_FULL);
    uvm_config_db#(string)::set(null, "*", "test_name", get_type_name());
  

    `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
  endfunction

  // Optional check phase
  function void check_phase(uvm_phase phase);
    check_config_usage();
  endfunction

  // Print topology
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

  // Drain time if needed
  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 200ns);
  endtask

endclass : base_test


// class spi_enable_test extends base_test;
//   `uvm_component_utils(spi_enable_test)

//   function new(string name = "spi_enable_test", uvm_component parent = null);
//     super.new(name, parent);
//   endfunction

//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);

//     uvm_config_wrapper::set(
//       this, 
//       "tb_soc.wbenv.masters[0].sequencer.main_phase",
//       "default_sequence", 
//       enable_spi_core::get_type()
//     );

// uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());

    
//   endfunction
// endclass
// class wb_spi_write_test extends base_test;
//   `uvm_component_utils(wb_spi_write_test)

//   function new(string name = "wb_spi_write_test", uvm_component parent = null);
//     super.new(name, parent);
//   endfunction

//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);

// uvm_config_wrapper::set( this, "*soc_mcseqr.run_phase","default_sequence", write_wbxspi_seq::get_type() );
//   // uvm_config_wrapper::set(
//   //     this, 
//   //     "tb_soc.wbenv.masters[0].sequencer.main_phase",
//   //     "default_sequence", 
//   //     wb_write_spi1_seq::get_type()
//   //   );

//   //     uvm_config_wrapper::set(
//   //     this, 
//   //     "tb_soc.spienv.slave_agent.seqr.main_phase",
//   //     "default_sequence", 
//   //     spi_slave_response_seq::get_type()
//   //   );
    
// uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());

    
//   endfunction
// endclass

// class wb_spi_flags_test extends base_test;
//   `uvm_component_utils(wb_spi_flags_test)

//   function new(string name = "wb_spi_flags_test", uvm_component parent = null);
//     super.new(name, parent);
//   endfunction

//   function void build_phase(uvm_phase phase);
//     super.build_phase(phase);

// uvm_config_wrapper::set( this, "*mcseqr.run_phase","default_sequence", flag_wbxspi_seq::get_type() );
//   // uvm_config_wrapper::set(
//   //     this, 
//   //     "tb_soc.wbenv.masters[0].sequencer.main_phase",
//   //     "default_sequence", 
//   //     wb_write_spi1_seq::get_type()
//   //   );

//   //     uvm_config_wrapper::set(
//   //     this, 
//   //     "tb_soc.spienv.slave_agent.seqr.main_phase",
//   //     "default_sequence", 
//   //     spi_slave_response_seq::get_type()
//   //   );
    
// uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());

    
//   endfunction
// endclass