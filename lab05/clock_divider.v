`timescale 1ns / 1ps

module clock_divider(clk, clk_div);
    parameter n = 26; 
    input clk;
    output reg clk_div;

    reg [n-1 : 0] count = 0;

    always@(posedge clk) begin
        if (count == 2**n-1)
            count = 0;
        else
            count = count + 1;
    end

    always@(posedge clk) begin
        if(count < 2**(n-1))
            clk_div = 0;
        else
            clk_div = 1'b1; 
    end
endmodule