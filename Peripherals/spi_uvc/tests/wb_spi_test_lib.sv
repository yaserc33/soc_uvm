`ifndef SOC
class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  string m_tb_name;
  testbench tb;

  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Set testbench name for flexible hierarchy
    m_tb_name = "tb";
    tb = testbench::type_id::create(m_tb_name, this);

    // Set testbench name in config DB so child tests can use it
    uvm_config_db#(string)::set(null, "*", "m_tb_name", m_tb_name);

    // Set the test name (optional but useful for logging/reporting)
    uvm_config_db#(string)::set(null, "*", "test_name", get_type_name());

    // Enable full transaction recording
    uvm_config_int::set(this, "*", "recording_detail", UVM_FULL);

    `uvm_info(get_type_name(), "Inside build phase of base_test", UVM_MEDIUM)
  endfunction : build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  function void check_phase(uvm_phase phase);
    check_config_usage();
  endfunction : check_phase

endclass : base_test
class mcsequencer_basic_test extends base_test;

  `uvm_component_utils(mcsequencer_basic_test)

  spi_config m_spi_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_spi_config = spi_config::type_id::create("m_spi_config", this);
    m_spi_config.Clock_Phase_Pol = 2'b00;

    uvm_config_db #(spi_config)::set(this, "*", "spi_config", m_spi_config);

    if (!uvm_config_db#(string)::get(this, "", "m_tb_name", m_tb_name))
      `uvm_error("CONFIGDB", "Could not find Testbench Name in config DB");

    // Use m_tb_name to construct correct path for setting default sequences
    uvm_config_wrapper::set(this, $sformatf("%s.clk_rst.agent.sequencer.run_phase", m_tb_name),
                            "default_sequence", clk10_rst5_seq::get_type());

    uvm_config_wrapper::set(this, $sformatf("%s.mc_seqr.run_phase", m_tb_name),
                            "default_sequence", wb_spi_mcsequence_lib::get_type());
  endfunction : build_phase

endclass : mcsequencer_basic_test

`endif



//----------------------------------------------------------------
// TEST: write test 
//----------------------------------------------------------------
class wbxspi_write_test extends base_test;

  `uvm_component_utils(wbxspi_write_test)

  function new(string name = get_type_name(), uvm_component parent = null);
    super.new(name, parent);
  endfunction : new




  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 200ns);
  endtask : run_phase


  virtual function void build_phase(uvm_phase phase);


    // Set the default sequence for the clock
    uvm_config_wrapper::set(this, "*mc_seqr*",  "default_sequence", write_wbxspi_seq::get_type()); 
    
    //  uvm_config_wrapper::set(
    //   this, 
    //   "tb.wb.masters[0].sequencer.main_phase",
    //   "default_sequence", 
    //   wb_write_spi1_seq::get_type()
    // );

    //   uvm_config_wrapper::set(
    //   this, 
    //   "tb.spi1.slave_agent.seqr.run_phase",
    //   "default_sequence", 
    //   spi_slave_response_seq::get_type()
    // );
    uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());
   



  



    super.build_phase(phase);
  endfunction : build_phase

endclass : wbxspi_write_test



//----------------------------------------------------------------
// TEST: read  test
//----------------------------------------------------------------
class wbxspi_read_test extends base_test;

  `uvm_component_utils(wbxspi_read_test)

  function new(string name = get_type_name(), uvm_component parent = null);
    super.new(name, parent);
  endfunction : new




  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 100ns);
  endtask : run_phase


 virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    // Set the default sequence for the clock
    uvm_config_wrapper::set(this, "*mc_seqr*",  "default_sequence", read_wbxspi_seq::get_type()); 
    uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());



  endfunction : build_phase


endclass : wbxspi_read_test

class wbxspi_flags_test extends base_test;

  `uvm_component_utils(wbxspi_flags_test)

  function new(string name = get_type_name(), uvm_component parent = null);
    super.new(name, parent);
  endfunction : new




  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 100ns);
  endtask : run_phase


 virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
	if (!uvm_config_db#(string)::get(this, "", "m_tb_name", m_tb_name))
			  `uvm_error("CONFIGDB", "Could not find Testbench Name in config DB");

    // Set the default sequence for the clock
    uvm_config_wrapper::set(this, $sformatf("%s.mcseqr.run_phase", m_tb_name), "default_sequence",flag_wbxspi_seq ::get_type()); 
    uvm_config_wrapper::set(this,$sformatf( "%s.clk_rst_env.agent.sequencer.run_phase",m_tb_name), "default_sequence", clk10_rst5_seq::get_type());


  
  endfunction : build_phase
endclass : wbxspi_flags_test

class wbxspi_stress_test extends base_test;

  `uvm_component_utils(wbxspi_stress_test)

  function new(string name = get_type_name(), uvm_component parent = null);
    super.new(name, parent);
  endfunction : new




  task run_phase(uvm_phase phase);
    uvm_objection obj = phase.get_objection();
    obj.set_drain_time(this, 100ns);
  endtask : run_phase


 virtual function void build_phase(uvm_phase phase);


    // Set the default sequence for the clock
    uvm_config_wrapper::set(this, "*mc_seqr.run_phase",  "default_sequence", stress_wbxspi_seq ::get_type()); 
    uvm_config_wrapper::set(this, "*clk_rst*", "default_sequence", clk10_rst5_seq::get_type());


    super.build_phase(phase);
  endfunction : build_phase
endclass : wbxspi_stress_test




