`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/15 16:02:29
// Design Name: 
// Module Name: lab06
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


module lab06(
    output wire [6:0] display,
    output wire [3:0] digit,
    output wire [15:0] LED,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire rst,
    input wire clk,
    input wire start,
    input wire cheat
    );
    
    
    parameter [2:0] init = 3'd0;
    parameter [2:0] range = 3'd1;
    parameter [2:0] keyin2 = 3'd2;
    parameter [2:0] keyin1 = 3'd4;
    parameter [2:0] win = 3'd3;
    
    reg [2:0] state, next_state;
//    reg [15:0] number, next_number;
    reg [6:0] answer;
    reg [6:0] count, next_count;
    reg [6:0] lnum, rnum, next_lnum, next_rnum;
    wire [7:0] nums;
    wire [6:0] nums_val;
    reg [7:0] prev_nums;
    reg [3:0] dig_on;
    reg [3:0] BCD0, BCD1, BCD2, BCD3;
    reg en, prev_press;
    wire enter, press, key_in;
    
    
    // clock
    
    wire clk_13, clk_16, clk_25, clk_FSM;
    
    clock_divider #(13) c13(.clk(clk), .clk_div(clk_13));
    clock_divider #(16) c16(.clk(clk), .clk_div(clk_16));
    clock_divider #(25) c25(.clk(clk), .clk_div(clk_25));
    
    assign clk_FSM = (state == win)? clk_25 : clk_16;
    
    //debounce
    
    wire rst_d, start_d, cheat_d, enter_d, press_d;
    
    debounce d0(.clk(clk_16), .pb(rst), .pb_debounced(rst_d));
    debounce d1(.clk(clk_16), .pb(start), .pb_debounced(start_d));
    debounce d2(.clk(clk_16), .pb(cheat), .pb_debounced(cheat_d));
    debounce d3(.clk(clk_16), .pb(enter), .pb_debounced(enter_d));
    
    
    //one pulse
    
    wire start_1, enter_1, rst_1;
    
    one_pulse o3(.clk(clk_16), .pb_debounced(rst_d), .pb_1pulse(rst_1));
    one_pulse o0(.clk(clk_16), .pb_debounced(start_d), .pb_1pulse(start_1));
    one_pulse o1(.clk(clk_16), .pb_debounced(enter_d), .pb_1pulse(enter_1));
    
    assign LED = (state == win)? 16'b1111_1111_1111_1111 : 16'b0;
    
    // FSM
    
    always@* begin
        case (state)
            init: begin
                BCD0 = 4'b1111;
                BCD1 = 4'b1111;
                BCD2 = 4'b1111;
                BCD3 = 4'b1111;
                dig_on = 4'b1111;
            end
            range: begin
                
                if(cheat_d) begin
                    BCD3 = answer/10;
                    BCD2 = answer%10;
                    BCD1 = 0;
                    BCD0 = 0;
                    dig_on = 4'b1100;
                end else begin
                    BCD3 = lnum/10;
                    BCD2 = lnum%10;
                    BCD1 = rnum/10;
                    BCD0 = rnum%10;
                    dig_on = 4'b1111;
                end
            end
            keyin1: begin
                BCD3 = 0;
                BCD2 = 0;
                BCD1 = 0;
                BCD0 = nums[3:0];
                dig_on = 4'b0001;
            end
            keyin2: begin
                BCD3 = 0;
                BCD2 = 0;
                BCD1 = nums[7:4];
                BCD0 = nums[3:0];
                dig_on = 4'b0011;
            end
            win: begin
                BCD3 = answer/10;
                BCD2 = answer%10;
                BCD1 = answer/10;
                BCD0 = answer%10;
                dig_on = 4'b1111;
            end
        endcase
        
    end
    
    always@(posedge rst_1, posedge clk_FSM) begin
        if(rst_1) begin
            prev_press = 0;
            
        end else begin
            prev_press = press;
            if(count<97) next_count = count+1;
            else next_count = 0;
        end
    end
    
    always@(posedge rst_1, posedge clk_FSM) begin
        
        if(rst_1) begin
            state = init;
            count = 7'b0;
            lnum = 7'd0;
            rnum = 7'd99;
            
        end else begin
            state = next_state;
            count = next_count;
            lnum = next_lnum;
            rnum = next_rnum;
        end
    
    end
    
    always@(*) begin
        next_state = state;
        next_lnum = lnum;
        next_rnum = rnum;
        case (state)
            init: begin
                en = 1'b0;
                
                if (start_1) begin
                    next_state = range;
                    answer = count+1;
                    next_lnum = 7'd0;
                    next_rnum = 7'd99;
                end
            end
            range: begin
                en = 1'b1;
                if(key_in) next_state = keyin1;
            end
            keyin1: begin
                en = 1'b1;
                if(enter_1) next_state = range;
                else if(key_in) next_state = keyin2;
            end
            keyin2: begin
                en = 1'b1;
                if(enter_1) begin
                    next_state = range;
                    if (nums_val > lnum && nums_val < rnum) begin
                        if (nums_val > answer) next_rnum = nums_val;
                        else if (nums_val < answer) next_lnum = nums_val;
                        else begin
                            next_state = win;
                        end
                    end
                end
            end
            win: begin
                en = 1'b0;
                next_state = init;
            end
        endcase
    end
    
//    assign press = (nums != prev_nums)? 1'b1 : 1'b0;
    assign nums_val = 10 * nums[7:4] + nums[3:0];
    assign key_in = (press != prev_press)? 1'b1 : 1'b0;
    
    SampleDisplay sd(
//        .display(display), 
//        .digit(digit), 
        .PS2_DATA(PS2_DATA), 
        .PS2_CLK(PS2_CLK), 
        .rst(rst), 
        .clk(clk),
        .nums(nums),
        .en(en),
        .enter(enter),
        .press(press)
    );
    
    
	SevenSegment seven_seg (
		.display(display), 
        .digit(digit),
        .dig_on(dig_on),
        .nums({BCD3, BCD2, BCD1, BCD0}),
		.rst(rst),
		.clk(clk)
	);
    
endmodule
