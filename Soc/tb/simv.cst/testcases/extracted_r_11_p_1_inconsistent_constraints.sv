class c_11_1;
    rand bit[31:0] addr; // rand_mode = ON 

    constraint addr_limit_this    // (constraint_mode = ON) (../../Soc/wb_bfm/sv/wb_transaction.sv:38)
    {
       (addr <= 32'hff);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (../../Soc/wb_bfm/sv/wb_master_seqs.sv:68)
    {
       (addr == 32'h20000200);
    }
endclass

program p_11_1;
    c_11_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z001x110x0zzxzx11z001000xxxx1110zxzxzzxzzzzxzzxzxzxzxxzxzxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
