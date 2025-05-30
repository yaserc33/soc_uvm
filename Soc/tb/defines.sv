

`define DATA_MEMORY_BASE_ADDRESS 32'h00000000
`define DATA_MEMORY_ADDRESS_FOR_CORE_2_UVM_SYNC  `DATA_MEMORY_BASE_ADDRESS 	//32 Bytes for config
`define UVM_2_CORE_SEQ_SYNC_MASK 8'h01	//First Bit for synchronization between UVM ENv to Core
`define CORE_2_UVM_SEQ_SYNC_MASK  8'h02     //Second Bit for synchronization between Core 2 UVM Seq Sync 
`define CORE_2_UVM_FINISH_SYNC_MASK 8'h04  //THird Bit for synchronization betwen Core 2 UVM for finishing simulation


`define UART_BASE_ADDRESS 32'h20000000
`define UART_END_ADDRESS 32'h200000FF

`define GPIO_BASE_ADDRESS 32'h20000100
`define GPIO_END_ADDRESS 32'h200001FF

`define SPI1_BASE_ADDRESS 32'h20000200
`define SPI1_END_ADDRESS 32'h2000027F

`define SPI2_BASE_ADDRESS 32'h20000280
`define SPI2_END_ADDRESS 32'h200002FF

`define I2C_BASE_ADDRESS 32'h20000300
`define I2C_END_ADDRESS 32'h200003FF


`define PTC_BASE_ADDRESS 32'h20000400
`define PTC_END_ADDRESS 32'h200004FF

`define CLINT_BASE_ADDRESS 32'h20000C00
`define CLINT_END_ADDRESS 32'h20000C0F



`define OFFSET 4

