class c_14_4;
    bit[0:0] rest_rf = 1'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (../../Peripherals/spi_uvc/sequences/wb_spi_sequences.sv:407)
    {
       (rest_rf == 1'h1);
    }
endclass

program p_14_4;
    c_14_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10zz0x01zxxx111x1x100xx11101z0xzzxxzxxzxzxzxzzxxxxxzzzxzxxxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
