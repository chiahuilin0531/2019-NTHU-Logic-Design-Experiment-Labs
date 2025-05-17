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


module clock_divider (clk_div, clk);
    input clk;
    output clk_div;
    
    parameter width = 25;
    reg  [width-1:0] num;
    wire [width-1:0] next_num;
    
    always @(posedge clk) begin  
        num <= next_num;
    end
    
    assign  next_num = num + 1;
    assign  clk_div = num[width-1];  
     
endmodule

module debounce(clk,pb,pb_debounced);
    input clk;
    input pb;
    output pb_debounced;
    
    
    reg [3:0] shift_reg;
    
    always @(posedge clk) begin
        shift_reg[3:1] <= shift_reg[2:0];
        shift_reg[0] <= pb;
    end
    
    assign pb_debounced = ((shift_reg == 4'b1111) ? 1'b1 : 1'b0);

endmodule

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

module SampleDisplay(
//	output wire [6:0] display,
//	output wire [3:0] digit,
	output reg [7:0] nums,
	output wire enter,
	output reg press,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk,
	input wire en
	);
	
//	parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
//	parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
    parameter [8:0] ENTER_CODES = 9'b0_0101_1010;
	parameter [8:0] KEY_CODES [0:19] = {
		9'b0_0100_0101,	// 0 => 45
		9'b0_0001_0110,	// 1 => 16
		9'b0_0001_1110,	// 2 => 1E
		9'b0_0010_0110,	// 3 => 26
		9'b0_0010_0101,	// 4 => 25
		9'b0_0010_1110,	// 5 => 2E
		9'b0_0011_0110,	// 6 => 36
		9'b0_0011_1101,	// 7 => 3D
		9'b0_0011_1110,	// 8 => 3E
		9'b0_0100_0110,	// 9 => 46
		
		9'b0_0111_0000, // right_0 => 70
		9'b0_0110_1001, // right_1 => 69
		9'b0_0111_0010, // right_2 => 72
		9'b0_0111_1010, // right_3 => 7A
		9'b0_0110_1011, // right_4 => 6B
		9'b0_0111_0011, // right_5 => 73
		9'b0_0111_0100, // right_6 => 74
		9'b0_0110_1100, // right_7 => 6C
		9'b0_0111_0101, // right_8 => 75
		9'b0_0111_1101  // right_9 => 7D
	};
	
//	reg [15:0] nums;
	reg [3:0] key_num;
	reg [9:0] last_key;
	
//	wire shift_down;
	wire [511:0] key_down;
	wire [8:0] last_change;
	wire been_ready;
	
	assign enter = (key_down[ENTER_CODES] == 1'b1)? 1'b1 : 1'b0;
//	assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;
	
//	SevenSegment seven_seg (
//		.display(display),
//		.digit(digit),
//		.nums(nums),
//		.rst(rst),
//		.clk(clk)
//	);
		
	KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);

	always @ (posedge clk, posedge rst) begin
		if (rst) begin
			nums <= 8'b0;
			press <= 1'b0;
		end else begin
			nums <= nums;
			if (been_ready && key_down[last_change] == 1'b1) begin
				if (key_num != 4'b1111)begin
				    press <= ~press;
				    nums <= {nums[3:0], key_num};
//					if (shift_down == 1'b1) begin
//						nums <= {key_num, nums[15:4]};
//					end else begin
//						nums <= {nums[11:0], key_num};
//					end
				end
			end
		end
	end
	
	always @ (*) begin
		case (last_change)
			KEY_CODES[00] : key_num = 4'b0000;
			KEY_CODES[01] : key_num = 4'b0001;
			KEY_CODES[02] : key_num = 4'b0010;
			KEY_CODES[03] : key_num = 4'b0011;
			KEY_CODES[04] : key_num = 4'b0100;
			KEY_CODES[05] : key_num = 4'b0101;
			KEY_CODES[06] : key_num = 4'b0110;
			KEY_CODES[07] : key_num = 4'b0111;
			KEY_CODES[08] : key_num = 4'b1000;
			KEY_CODES[09] : key_num = 4'b1001;
			KEY_CODES[10] : key_num = 4'b0000;
			KEY_CODES[11] : key_num = 4'b0001;
			KEY_CODES[12] : key_num = 4'b0010;
			KEY_CODES[13] : key_num = 4'b0011;
			KEY_CODES[14] : key_num = 4'b0100;
			KEY_CODES[15] : key_num = 4'b0101;
			KEY_CODES[16] : key_num = 4'b0110;
			KEY_CODES[17] : key_num = 4'b0111;
			KEY_CODES[18] : key_num = 4'b1000;
			KEY_CODES[19] : key_num = 4'b1001;
			default		  : key_num = 4'b1111;
		endcase
	end
	
endmodule

module SevenSegment(
	output reg [6:0] display,
	output reg [3:0] digit,
	input wire [3:0] dig_on,
	input wire [15:0] nums,
	input wire rst,
	input wire clk
	
    );
    
    wire clk_div;
    reg [3:0] display_num;
    
    clock_divider #(13) _clk(.clk(clk),.clk_div(clk_div));
    
    always @ (posedge clk_div, posedge rst) begin
    	if (rst) begin
    		display_num <= 4'b1111;
    		digit <= 4'b0000;
    	end else begin
            if (dig_on == 4'b0001) begin
                case (digit)
                    4'b1110 : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end
                    default : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end				
                endcase
            end else if (dig_on == 4'b0011) begin
                case (digit)
                    4'b1110 : begin
                        display_num <= nums[7:4];
                        digit <= 4'b1101;
                    end
                    4'b1101 : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end
                    default : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end				
                endcase
            end else if (dig_on == 4'b1100) begin
                case (digit)
                    4'b1011 : begin
                        display_num <= nums[15:12];
                        digit <= 4'b0111;
                    end
                    4'b0111 : begin
                        display_num <= nums[11:8];
                        digit <= 4'b1011;
                    end
                    default : begin
                        display_num <= nums[11:8];
                        digit <= 4'b1011;
                    end				
                endcase
            end else begin
                case (digit)
                    4'b1110 : begin
                        display_num <= nums[7:4];
                        digit <= 4'b1101;
                    end
                    4'b1101 : begin
                        display_num <= nums[11:8];
                        digit <= 4'b1011;
                    end
                    4'b1011 : begin
                        display_num <= nums[15:12];
                        digit <= 4'b0111;
                    end
                    4'b0111 : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end
                    default : begin
                        display_num <= nums[3:0];
                        digit <= 4'b1110;
                    end				
                endcase
            end
    	end
    end
    
    always @ (*) begin
    	case (display_num)
    		0 : display = 7'b1000000;	//0000
			1 : display = 7'b1111001;   //0001                                                
			2 : display = 7'b0100100;   //0010                                                
			3 : display = 7'b0110000;   //0011                                             
			4 : display = 7'b0011001;   //0100                                               
			5 : display = 7'b0010010;   //0101                                               
			6 : display = 7'b0000010;   //0110
			7 : display = 7'b1111000;   //0111
			8 : display = 7'b0000000;   //1000
			9 : display = 7'b0010000;	//1001
			default : display = 7'b0111111;
    	endcase
    end
    
endmodule

module KeyboardDecoder(
	output reg [511:0] key_down,
	output wire [8:0] last_change,
	output reg key_valid,
	inout wire PS2_DATA,
	inout wire PS2_CLK,
	input wire rst,
	input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
	parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state;
    reg been_ready, been_extend, been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    wire pulse_been_ready;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
		.key_in(key_in),
		.is_extend(is_extend),
		.is_break(is_break),
		.valid(valid),
		.err(err),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
	);
	
	OnePulse op (
		.signal_single_pulse(pulse_been_ready),
		.signal(been_ready),
		.clock(clk)
	);
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		state <= INIT;
    		been_ready  <= 1'b0;
    		been_extend <= 1'b0;
    		been_break  <= 1'b0;
    		key <= 10'b0_0_0000_0000;
    	end else begin
    		state <= state;
			been_ready  <= been_ready;
			been_extend <= (is_extend) ? 1'b1 : been_extend;
			been_break  <= (is_break ) ? 1'b1 : been_break;
			key <= key;
    		case (state)
    			INIT : begin
    					if (key_in == IS_INIT) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready  <= 1'b0;
							been_extend <= 1'b0;
							been_break  <= 1'b0;
							key <= 10'b0_0_0000_0000;
    					end else begin
    						state <= INIT;
    					end
    				end
    			WAIT_FOR_SIGNAL : begin
    					if (valid == 0) begin
    						state <= WAIT_FOR_SIGNAL;
    						been_ready <= 1'b0;
    					end else begin
    						state <= GET_SIGNAL_DOWN;
    					end
    				end
    			GET_SIGNAL_DOWN : begin
						state <= WAIT_RELEASE;
						key <= {been_extend, been_break, key_in};
						been_ready  <= 1'b1;
    				end
    			WAIT_RELEASE : begin
    					if (valid == 1) begin
    						state <= WAIT_RELEASE;
    					end else begin
    						state <= WAIT_FOR_SIGNAL;
    						been_extend <= 1'b0;
    						been_break  <= 1'b0;
    					end
    				end
    			default : begin
    					state <= INIT;
						been_ready  <= 1'b0;
						been_extend <= 1'b0;
						been_break  <= 1'b0;
						key <= 10'b0_0_0000_0000;
    				end
    		endcase
    	end
    end
    
    always @ (posedge clk, posedge rst) begin
    	if (rst) begin
    		key_valid <= 1'b0;
    		key_down <= 511'b0;
    	end else if (key_decode[last_change] && pulse_been_ready) begin
    		key_valid <= 1'b1;
    		if (key[8] == 0) begin
    			key_down <= key_down | key_decode;
    		end else begin
    			key_down <= key_down & (~key_decode);
    		end
    	end else begin
    		key_valid <= 1'b0;
			key_down <= key_down;
    	end
    end

endmodule

module OnePulse (
	output reg signal_single_pulse,
	input wire signal,
	input wire clock
	);
	
	reg signal_delay;

	always @(posedge clock) begin
		if (signal == 1'b1 & signal_delay == 1'b0)
		  signal_single_pulse <= 1'b1;
		else
		  signal_single_pulse <= 1'b0;

		signal_delay <= signal;
	end
endmodule
