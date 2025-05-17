`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/15 16:11:16
// Design Name: 
// Module Name: lab4_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab4_1(
    input wire [15:0] SW,
    input wire clk,
    input wire reset,
    output reg [3:0] DIGIT,
    output reg [0:6] DISPLAY
);
    
    reg [3:0] value;
    wire [3:0] BCD0, BCD1, BCD2, BCD3;
    wire clk_div;
    
    clock_divider #(13) c13(.clk(clk), .clk_div(clk_div));
    assign BCD0 = reset? 4'b0 : {SW[3], SW[2], SW[1], SW[0]};
    assign BCD1 = reset? 4'b0 : {SW[7], SW[6], SW[5], SW[4]};
    assign BCD2 = reset? 4'b0 : {SW[11], SW[10], SW[9], SW[8]};
    assign BCD3 = reset? 4'b0 : {SW[15], SW[14], SW[13], SW[12]};
    
    
    always@(posedge clk_div) begin
        case (DIGIT)
            4'b1110: begin
                value = BCD1;
                DIGIT = 4'b1101;
            end
            4'b1101: begin
                value = BCD2;
                DIGIT = 4'b1011;
            end
            4'b1011: begin
                value = BCD3;
                DIGIT = 4'b0111;
            end
            4'b0111: begin
                value = BCD0;
                DIGIT = 4'b1110;
            end
            default: begin
                value = BCD0;
                DIGIT = 4'b1110;
            end
        endcase 
    end
    
    always @* begin
        case (value)
            4'd0: DISPLAY = 7'b0000001;
            4'd1: DISPLAY = 7'b1001111;
            4'd2: DISPLAY = 7'b0010010;
            4'd3: DISPLAY = 7'b0000110;
            4'd4: DISPLAY = 7'b1001100;
            4'd5: DISPLAY = 7'b0100100;
            4'd6: DISPLAY = 7'b0100000;
            4'd7: DISPLAY = 7'b0001111;
            4'd8: DISPLAY = 7'b0000000;
            4'd9: DISPLAY = 7'b0000100;
            default: DISPLAY = 7'b00000100;
        endcase
    end
endmodule
