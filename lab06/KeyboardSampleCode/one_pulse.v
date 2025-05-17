module one_pulse(clk, pb_debounced, pb_1pulse);

    input clk;
    input pb_debounced;
    output pb_1pulse;
    
    reg pb_1pulse;
    reg pb_debounced_delay;
        
    always @(posedge clk) begin
        pb_debounced_delay <= pb_debounced;
        
        if ((pb_debounced) && (!pb_debounced_delay))
            pb_1pulse <= 1'b1;
        else 
            pb_1pulse <= 1'b0;
    end   
endmodule
