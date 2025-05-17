module top(
    input clk,
    input rst,
    input shift,
    input split,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output light1,
    output light2,
    output light3
    );

    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire clk_16;
    wire [16:0] pixel_addr;
    wire [11:0] pixel;
    wire valid;
    wire black;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480

    assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1 && black==0) ? pixel:12'h0;

    clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk22(clk_22),
      .clk16(clk_16)
    );

    mem_addr_gen mem_addr_gen_inst(
        .clk(clk_22),
        .clk_16(clk_16),
        .rst(rst),
        .shift(shift),
        .split(split),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .pixel_addr(pixel_addr),
        .black(black),
        .light1(light1),
        .light2(light2),
        .light3(light3)
    );
     
 
    blk_mem_gen_0 blk_mem_gen_0_inst(
      .clka(clk_25MHz),
      .wea(0),
      .addra(pixel_addr),
      .dina(data[11:0]),
      .douta(pixel)
    ); 

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
      
endmodule


module mem_addr_gen(
    input clk,
    input clk_16,
    input rst,
    input shift,
    input split,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    output reg [16:0] pixel_addr,
    output reg black,
    output light1,
    output light2,
    output light3
    );

    // debounce
    
    wire shift_d, split_d;    
    debounce d0(.clk(clk_16), .pb(shift), .pb_debounced(shift_d));
    debounce d1(.clk(clk_16), .pb(split), .pb_debounced(split_d));
    
    // one_pulse
    
    wire shift_1, split_1;
    
    one_pulse o0(.clk(clk_16), .pb_debounced(shift_d), .pb_1pulse(shift_1));
    one_pulse o1(.clk(clk_16), .pb_debounced(split_d), .pb_1pulse(split_1));
    
    // FSM
    
    reg [8:0] position, next_position;
       
//    assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 
    
    parameter [1:0] init = 2'b00;
    parameter [1:0] shifting = 2'b01;
    parameter [1:0] spliting = 2'b10;
    
    reg [1:0] state, next_state;
    reg appearing, next_appearing;
    
    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            state = init;
            position = 0;
            appearing = 0;
        end else begin
            state = next_state;
            position = next_position;
            appearing = next_appearing;
        end
    end

    always@* begin
        next_state = state;
        next_position = position;
        
        case (state)
            init: begin
                next_appearing = 0;
                
                if (shift_d) begin
                    next_state = shifting;
                    next_position = 319;
                end else if (split_d) begin
                    next_state = spliting;
                    next_position = 0;
                end
            end
            shifting: begin
                if (appearing == 0) begin
                    next_appearing = 0;
                    if (position > 0) begin
                        next_position = position - 1;
                    end else begin
                        next_position = 0;
                        next_appearing = 1'b1;
                    end
                end else begin
                    next_appearing = 1'b1;
                    if (position < 240-1) begin
                        next_position = position + 1;
                    end else begin
                        next_state = init;
                        next_position = 0;
                        next_appearing = 0;
                    end
                end
            end
            spliting: begin
                next_appearing = 0;
                if (position < 320/2-1) begin
                    next_position = position + 1;
                end else begin
                    next_position = 0;
                    next_state = init;
                end
            end        
        endcase
    end
    
    always@* begin
        pixel_addr = pixel_addr;
        
        case (state)
            init: begin
                black = 0;
                pixel_addr = (h_cnt>>1) + 320*(v_cnt>>1);
            end
            shifting: begin
                if (appearing == 0) begin
                    if (h_cnt>>1 > position) begin
                        black = 1'b1;
                    end else begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + 320*(v_cnt>>1);
                    end
                end else begin
                    if (v_cnt>>1 > position) begin
                        black = 1'b1;
                    end else begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + 320*(v_cnt>>1);
                    end
                end
            end
            spliting: begin
                if (h_cnt>>1 < 160 && v_cnt>>1 < 120) begin // up left
                    if(position > 120) begin
                        black = 1'b1;
                    end else if (v_cnt>>1 < 120-position) begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + 320*((v_cnt>>1) + position);
                    end else 
                        black = 1'b1;
                    
                end else if (h_cnt>>1 < 160 && v_cnt>>1 >= 120) begin //down left
                    if (h_cnt>>1 < 160-position) begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + position + 320*(v_cnt>>1);
                    end else
                        black = 1'b1;
                    
                end else if (h_cnt>>1 >= 160 && v_cnt>>1 < 120) begin //up right
                    if (h_cnt>>1 >= 160+position) begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + 320*(v_cnt>>1) - position ;
                    end else
                        black = 1'b1;
                    
                end else begin                                          //down right
                    if (v_cnt>>1 >= 120+position) begin
                        black = 0;
                        pixel_addr = (h_cnt>>1) + 320*((v_cnt>>1) - position);
                    end else
                        black = 1'b1;
                
                end
            end
        
        endcase   
    end
    
    assign light1 = state == init;
    assign light2 = state == shifting;
    assign light3 = state == spliting;
    
endmodule


`timescale 1ns/1ps
/////////////////////////////////////////////////////////////////
// Module Name: vga
/////////////////////////////////////////////////////////////////

module vga_controller (
    input wire pclk, reset,
    output wire hsync, vsync, valid,
    output wire [9:0]h_cnt,
    output wire [9:0]v_cnt
    );

    reg [9:0]pixel_cnt;
    reg [9:0]line_cnt;
    reg hsync_i,vsync_i;

    parameter HD = 640;
    parameter HF = 16;
    parameter HS = 96;
    parameter HB = 48;
    parameter HT = 800; 
    parameter VD = 480;
    parameter VF = 10;
    parameter VS = 2;
    parameter VB = 33;
    parameter VT = 525;
    parameter hsync_default = 1'b1;
    parameter vsync_default = 1'b1;

    always @(posedge pclk)
        if (reset)
            pixel_cnt <= 0;
        else
            if (pixel_cnt < (HT - 1))
                pixel_cnt <= pixel_cnt + 1;
            else
                pixel_cnt <= 0;

    always @(posedge pclk)
        if (reset)
            hsync_i <= hsync_default;
        else
            if ((pixel_cnt >= (HD + HF - 1)) && (pixel_cnt < (HD + HF + HS - 1)))
                hsync_i <= ~hsync_default;
            else
                hsync_i <= hsync_default; 

    always @(posedge pclk)
        if (reset)
            line_cnt <= 0;
        else
            if (pixel_cnt == (HT -1))
                if (line_cnt < (VT - 1))
                    line_cnt <= line_cnt + 1;
                else
                    line_cnt <= 0;

    always @(posedge pclk)
        if (reset)
            vsync_i <= vsync_default; 
        else if ((line_cnt >= (VD + VF - 1)) && (line_cnt < (VD + VF + VS - 1)))
            vsync_i <= ~vsync_default; 
        else
            vsync_i <= vsync_default; 

    assign hsync = hsync_i;
    assign vsync = vsync_i;
    assign valid = ((pixel_cnt < HD) && (line_cnt < VD));

    assign h_cnt = (pixel_cnt < HD) ? pixel_cnt : 10'd0;
    assign v_cnt = (line_cnt < VD) ? line_cnt : 10'd0;

endmodule


module clock_divisor(clk1, clk, clk22, clk16);
    input clk;
    output clk1;
    output clk22;
    output clk16;
    
    reg [21:0] num;
    wire [21:0] next_num;
    
    always @(posedge clk) begin
        num <= next_num;
    end
    
    assign next_num = num + 1'b1;
    assign clk1 = num[1];
    assign clk22 = num[21];
    assign clk16 = num[14];
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

