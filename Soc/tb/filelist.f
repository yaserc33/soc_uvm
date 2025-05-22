// ========== UART ==========  //NEED TO BE UPDATED
//+incdir+../../Peripherals/uart_uvc
//../../Peripherals/uart_uvc/sv/ 
//../../Peripherals/uart_uvc/sv/

+define+SOC
// +define+OC_DV_WITH_CORE 


//==========addresses=========
defines.sv
// ========== wb_uvc ==========
+incdir+../../Soc/wb_bfm/sv
../../Soc/wb_bfm/sv/wb_pkg.sv
../../Soc/wb_bfm/sv/wb_if.sv


// ========== clock_and_reset ==========
+incdir+../../Soc/clock_and_reset/sv              
../../Soc/clock_and_reset/sv/clock_and_reset_pkg.sv
../../Soc/clock_and_reset/sv/clock_and_reset_if.sv

+incdir+../sv
+incdir+../tests+../sequences


// ========== spi ==========
+incdir+../../Peripherals/spi_uvc/sv
+incdir+../../Peripherals/spi_uvc/tests
+incdir+../../Peripherals/spi_uvc/sequences
+incdir+../../Peripherals/spi_uvc/spi/sv
../../Peripherals/spi_uvc/spi/sv/spi_pkg.sv         
../../Peripherals/spi_uvc/spi/sv/spi_if.sv         
// ========== spi ref_model ==========
+incdir+../../Peripherals/spi_uvc/wb_x_spi_module/sv
../../Peripherals/spi_uvc/wb_x_spi_module/sv/spi_module_pkg.sv         




// ========== Scorenoard ==========
+incdir+../../Soc/soc_ref_module
../../Soc/soc_ref_module/soc_pkg.sv
 

// ========== SoC ==========
+incdir+../../Soc/tb
../../Soc/tb/clkgen.sv           # clock generation module (likely used by others)
../../Soc/tb/hw_top.sv           # DUT + interface connections
../../Soc/tb/defines.sv
../../Soc/tb/top.sv              # testbench top module (instantiates soc_tb + run_test)



// ========== pads dir ==========
//+incdir+/home/Reda_Alhashem/shared_folder/soc-rtl/pads/tpz018nv_270a
///home/Reda_Alhashem/shared_folder/soc-rtl/pads/tpz018nv_270a/tpz018nv.v

