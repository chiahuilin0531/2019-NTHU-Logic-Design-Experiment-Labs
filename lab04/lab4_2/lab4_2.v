`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/19 23:15:54
// Design Name: 
// Module Name: lab4_2
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

`define start 2'b00
`define pause 2'b01
`define resume 2'b10

module lab4_2(
    input wire en,
    input wire reset,
    input wire clk,
    input wire dir,
    input wire record,
    output reg [3:0] DIGIT,
    output reg [0:6] DISPLAY,
    output wire max,
    output wire min
//    output wire s
    );
    
    
    reg [3:0] value, BCD2, BCD3, next_BCD2, next_BCD3;
    reg [6:0] count, next_count;
    reg [1:0] state = `start, next_state;
    reg reg_dir, next_dir;
//    reg reg_en = 1'b0, next_en;
    
    wire [3:0] BCD0, BCD1;
    wire clk_25, clk_23, clk_13;
    wire _dir, _en, _record;
    wire dir1, en1, record1;
    wire dir_d, en_d, record_d;
        
    clock_divider #(13) c13(.clk(clk), .clk_div(clk_13));
    clock_divider #(25) c25(.clk(clk), .clk_div(clk_25));
    clock_divider #(23) c23(.clk(clk), .clk_div(clk_23));
    
    debounce d0(.pb_debounced(_dir), .pb(dir), .clk(clk_13));
    debounce d1(.pb_debounced(_en), .pb(en), .clk(clk_13));
    debounce d2(.pb_debounced(_record), .pb(record), .clk(clk_13));
    
    onepulse o0(.pb_debounced(_record), .clk(clk_23), .pb_1pulse(record1));
    onepulse o1(.pb_debounced(_en), .clk(clk_23), .pb_1pulse(en1));
    onepulse o2(.pb_debounced(_dir), .clk(clk_23), .pb_1pulse(dir1));
    
    delay_signal de0(.pb_delayed(record_d), .pb_1pulse(record1), .clk(clk_23));
    delay_signal de1(.pb_delayed(en_d), .pb_1pulse(en1), .clk(clk_23));
    delay_signal de2(.pb_delayed(dir_d), .pb_1pulse(dir1), .clk(clk_23));
    
    
    assign BCD0 = count%10;
    assign BCD1 = count%100/10;
    assign max = reg_dir & count == 99;
    assign min = ~reg_dir & count == 0;
//    assign s = state == `start;
    
    always@(posedge clk_25) begin
    
        state = next_state;
        
        if (state == `start) begin
            reg_dir = 1'b1;
            BCD2 = 1'b0; 
            BCD3 = 1'b0;
//            reg_en = 0;
            count = 7'b0;
            
        end else begin
        
            reg_dir = next_dir;
            BCD2 = next_BCD2; 
            BCD3 = next_BCD3;
//            reg_en = next_en;
            count = next_count;
            
        end
        
    end
    
    always@* begin
        next_BCD2 = BCD2; 
        next_BCD3 = BCD3;
        next_dir = reg_dir;
//        next_en = reg_en;
        next_count = count;
        next_state = state;
        
        if (state == `start) begin
            if (en_d) next_state = `resume;
            
        end else begin
            if (dir_d) next_dir = ~reg_dir;
            if (reset) next_state = `start;
            if (record_d) begin
                next_BCD2 = BCD0;
                next_BCD3 = BCD1;
            end
            
            if (state == `resume) begin
                if (reg_dir && count<99) next_count = count+1;
                else if (~reg_dir && count>0) next_count = count-1;
                if (en_d) next_state = `pause;
            
            end else if (state == `pause) begin
                if (en_d) next_state = `resume;
            end
        end
        
        
//            next_en = ~reg_en;
        
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
    
    always @(posedge clk)
    begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb_1pulse;
    end
    assign pb_delayed = (|shift_reg);
endmodule