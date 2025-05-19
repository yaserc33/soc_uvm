class gpio_test extends uvm_test;
  `uvm_component_utils(gpio_test)

  gpio_env env;  // Environment instance

  // Constructor
  function new(string name = "gpio_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase: Create environment instance
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the environment (make sure to properly call the environment class type)
    env = gpio_env::type_id::create("env", this);
  endfunction

  // Run phase: Start the sequence
  virtual task run_phase(uvm_phase phase);
    gpio_sequence seq;

    phase.raise_objection(this);  // Raise objection to keep simulation running

    // Create the sequence and start it using the sequencer in the agent
    seq = gpio_sequence::type_id::create("seq");
    seq.start(env.agent.sequencer);  // Start the sequence using the sequencer from the environment's agent

    phase.drop_objection(this);  // Drop objection after the sequence has been started
  endtask
endclass