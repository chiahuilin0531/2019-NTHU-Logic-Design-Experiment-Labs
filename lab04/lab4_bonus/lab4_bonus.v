`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/21 21:55:42
// Design Name: 
// Module Name: lab4_3
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


`define setting 2'b00
`define counting 2'b01
`define pause 2'b10
`define reset 2'b11

module lab4_bonus(
    input wire en,
    input wire reset,
    input wire clk,
    input wire mode,
    input wire min_plus,
    input wire sec_plus,
    output reg [3:0] DIGIT,
    output reg [0:6] DISPLAY,
    output wire stop
//    output wire mode0,
//    output wire mode_1,
//    output wire mode2
    );
    
     
    reg [3:0] value;
    reg [11:0] count, next_count;
    reg [1:0] state = `setting, next_state;
    
    wire [3:0] BCD0, BCD1, BCD2, BCD3;
    wire clk_25, clk_23, clk_13;
    
    wire _en, en1, en_d;
    wire _mode, mode1, mode_d;
    wire _min_plus, min_plus1, min_d;
    wire _sec_plus, sec_plus1, sec_d;
        
    clock_divider #(13) c13(.clk(clk), .clk_div(clk_13));
    clock_divider2 #(4) c25(.clk(clk), .clk_div(clk_25));
    clock_divider2 #(1) c23(.clk(clk), .clk_div(clk_23));
    
    debounce d0(.pb_debounced(_en), .pb(en), .clk(clk_13));
    debounce d1(.pb_debounced(_mode), .pb(mode), .clk(clk_13));
    debounce d2(.pb_debounced(_min_plus), .pb(min_plus), .clk(clk_13));
    debounce d3(.pb_debounced(_sec_plus), .pb(sec_plus), .clk(clk_13));
    
    onepulse o0(.pb_debounced(_en), .clk(clk_23), .pb_1pulse(en1));
    onepulse o1(.pb_debounced(_mode), .clk(clk_23), .pb_1pulse(mode1));
    onepulse o2(.pb_debounced(_min_plus), .clk(clk_23), .pb_1pulse(min_plus1));
    onepulse o3(.pb_debounced(_sec_plus), .clk(clk_23), .pb_1pulse(sec_plus1));
    
    delay_signal de0(.pb_delayed(en_d), .pb_1pulse(en1), .clk(clk_23));
    delay_signal de1(.pb_delayed(mode_d), .pb_1pulse(mode1), .clk(clk_23));
    delay_signal de2(.pb_delayed(min_d), .pb_1pulse(min_plus1), .clk(clk_23));
    delay_signal de3(.pb_delayed(sec_d), .pb_1pulse(sec_plus1), .clk(clk_23));
    
    
    assign BCD0 = count%60%10;
    assign BCD1 = count%60/10;
    assign BCD2 = count/60%10;
    assign BCD3 = count/60/10;
    
    assign stop = (count == 0) & mode;
//    assign mode0 = state == `setting;
//    assign mode_1 = state == `pause;
//    assign mode2 = state == `counting;
    
    always@(posedge clk_25) begin
    
        state = next_state;
        count = next_count;
    end
    
    always@* begin
        next_count = count;
        next_state = state;
        
        case (state)
            `setting: begin
                
                if (sec_d && min_d && count<3600-61) next_count = count + 61;
                else if (sec_d) begin
                    if (count == 3600-1) next_count = 0;
                    else next_count = count + 1;
                end else if (min_d && count<3600-60) next_count = count + 60;
                
                if (mode) next_state = `pause;
                
            end
            
            `pause: begin
                if (!mode) begin
                    next_state = `setting;
                    next_count = 12'b0;
                end else if (en_d) next_state = `counting;
            end
            
            `counting: begin
                if (count>0) next_count = count-1;
                
                if (!mode) begin
                    next_state = `setting;
                    next_count = 12'b0;
                end else if (en_d || reset) next_state = `pause;
            end
        endcase
        
        if (reset) next_count = 12'b0;
    end
    
    
    
    always@(posedge clk_13) begin
        
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

module debounce (pb_debounced, pb, clk);
    output pb_debounced; // output after being debounced
    input pb;
    // input from a pushbutton
    input clk;
    
    reg [3:0] shift_reg; // use shift_reg to filter the bounce
    
    always @(posedge clk)
    begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb;
    end
    assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);
endmodule

module onepulse (pb_debounced, clk, pb_1pulse);
    input pb_debounced;
    input clk;
    output pb_1pulse;
    
    reg pb_1pulse;
    reg pb_debounced_delay;
    
    always @(posedge clk) begin
        if (pb_debounced == 1'b1 & pb_debounced_delay == 1'b0)
            pb_1pulse <= 1'b1;
        else
            pb_1pulse <= 1'b0;
            
        pb_debounced_delay <= pb_debounced;
    end
endmodule

module delay_signal (pb_delayed, pb_1pulse, clk);
    output pb_delayed; // output after being debounced
    input pb_1pulse;
    // input from a pushbutton
    input clk;
    
    reg [3:0] shift_reg; // use shift_reg to filter the bounce
    
    always @(posedge clk) begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb_1pulse;
    end
    assign pb_delayed = (|shift_reg);
endmodule

module clock_divider2(clk, clk_div);
    parameter n = 4; 
    
    input clk;
    output reg clk_div;

    reg [26 : 0] count = 0;

    always@(posedge clk) begin
        if (count == n*(10**8)/4-1)
            count = 0;
        else
            count = count + 1;
    end

    always@(posedge clk) begin
        if(count < n*(10**8)/4/2)
            clk_div = 0;
        else
            clk_div = 1'b1; 
    end
endmodule