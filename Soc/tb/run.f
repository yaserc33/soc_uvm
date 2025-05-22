////////////////////////////////////////
// option
////////////////////////////////////////

############select test###########
+UVM_TESTNAME=mcsequencer_simple_test




############Saving run Output to a Log File/##########
-l sim.log


############changing the seed of the randomization /##########

//+ntb_random_seed_automatic


##############debug#################

##+UVM_CONFIG_DB_TRACE
##+UVM_OBJECTION_TRACE



############verbosity level###########
//+UVM_VERBOSITY=UVM_LOW
//+UVM_VERBOSITY=UVM_MEDIUM
+UVM_VERBOSITY=UVM_HIGH
//+UVM_VERBOSITY=UVM_FULL



############ gui#############
//-gui
//+access+rwc


// default timescale
-timescale 1ns/1ns



