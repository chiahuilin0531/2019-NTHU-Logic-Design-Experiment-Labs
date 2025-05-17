`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 13:47:11
// Design Name: 
// Module Name: lab05
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

`define INITIAL 2'b00
`define DEPOSIT 2'b01
`define BUY     2'b10
`define CHANGE  2'b11

module lab05(
    input clk,
    input rst,
    input money_5,
    input money_10,
    input cancel,
    input drink_A,
    input drink_B,
    output reg [9:0] drop_money,
    output enough_A,
    output enough_B,
    output reg [3:0] DIGIT,
    output reg [0:6] DISPLAY,
    output item1,
    output item2
    );
    
    reg [3:0] value, BCD0, BCD1, BCD2, BCD3;
//    reg [6:0] next_BCD0, next_BCD1, next_BCD2, next_BCD3;
    reg [1:0] state = `INITIAL, next_state;
    reg [6:0] money, next_money;
    reg [9:0] next_drop;
    reg item_1, item_2, next_item_1, next_item_2;
    
    wire clk_13, clk_16, clk_26, clk_FSM;
    wire _money_5, _money_10, _cancel, _drink_A, _drink_B;
    wire m5_1, m10_1, cancel_1, A_1, B_1;
    
    clock_divider #(13) c13(.clk(clk), .clk_div(clk_13));
    clock_divider #(16) c16(.clk(clk), .clk_div(clk_16));
    clock_divider #(26) c26(.clk(clk), .clk_div(clk_26));
    
    debounce d0(.pb_debounced(_money_5), .pb(money_5), .clk(clk_16));
    debounce d1(.pb_debounced(_money_10), .pb(money_10), .clk(clk_16));
    debounce d2(.pb_debounced(_cancel), .pb(cancel), .clk(clk_16));
    debounce d3(.pb_debounced(_drink_A), .pb(drink_A), .clk(clk_16));
    debounce d4(.pb_debounced(_drink_B), .pb(drink_B), .clk(clk_16));

    onepulse o0(.pb_debounced(_money_5), .clk(clk_16), .pb_1pulse(m5_1));
    onepulse o1(.pb_debounced(_money_10), .clk(clk_16), .pb_1pulse(m10_1));
    onepulse o2(.pb_debounced(_cancel), .clk(clk_16), .pb_1pulse(cancel_1));
    onepulse o3(.pb_debounced(_drink_A), .clk(clk_16), .pb_1pulse(A_1));
    onepulse o4(.pb_debounced(_drink_B), .clk(clk_16), .pb_1pulse(B_1));

    assign clk_FSM = (state == `INITIAL || state == `DEPOSIT)? clk_16 : clk_26;
    assign enough_A = (state == `DEPOSIT && money >= 20)? 1:0;
    assign enough_B = (state == `DEPOSIT && money >= 25)? 1:0;
    assign item1 = state == `BUY;
    assign item2 = state == `CHANGE;
    
    always@* begin
        if (state == `BUY) begin
            if(item_1) begin
                BCD0 = 1;
                BCD1 = 1;
                BCD2 = 1;
                BCD3 = 1;
            end else if (item_2) begin
                BCD0 = 2;
                BCD1 = 2;
                BCD2 = 2;
                BCD3 = 2;
            end
        end else begin
            BCD0 = money % 10;
            BCD1 = money / 10;
            BCD3 = 0;
            BCD2 = 0;
            if (state == `DEPOSIT) begin
                if (item_1) begin
                    BCD3 = 2;
                    BCD2 = 0;
                end else if (item_2) begin
                    BCD3 = 2;
                    BCD2 = 5;
                end
            end
        end
    end
    
    always@(posedge clk_FSM) begin
        state = next_state;
        money = next_money;
        drop_money = next_drop;
        item_1 = next_item_1;
        item_2 = next_item_2;
    end
    
    always@* begin
        next_state = state;
        next_drop = drop_money;
        next_money = money;
        next_item_1 = item_1;
        next_item_2 = item_2;
    
        case (state)
            `INITIAL: begin
                next_money = 7'b0;
                next_drop = 10'b0;
                next_state = `DEPOSIT;
                next_item_1 = 0;
                next_item_2 = 0;
            end
            `DEPOSIT: begin
                if (m5_1 && money < 95) begin
                    next_money = money + 5;
                end else if (m10_1 && money < 90) begin
                    next_money = money + 10;
                    
                end else if(A_1) begin
                    if(item_1 && money >= 20) begin
                        next_money = money - 20;
                        next_state = `BUY;
                    end else begin
                        next_item_1 = 1;
                        next_item_2 = 0;
                    end
                end else if(B_1) begin
                    if(item_2 && money >= 25) begin
                        next_money = money - 25;
                        next_state = `BUY;
                    end else begin
                        next_item_1 = 0;
                        next_item_2 = 1;
                    end
                end else if(cancel_1) begin
                    next_state = `CHANGE;
                end
            end
            `BUY: begin
//                if (item_1) next_money = money - 20;
//                else if (item_2) next_money = money - 25;
                next_state = `CHANGE;
            end
            `CHANGE: begin
                if (money >= 10) begin
                    next_money = money - 10;
                    next_drop = 10'b1111111111;
                end else if (money >= 5) begin
                    next_money = money - 5;
                    next_drop = 10'b1111100000;
                end else begin
                    next_drop = 10'b0;
                    next_state = `INITIAL;
                end
            end
        endcase
        if (rst) next_state = `INITIAL;
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
