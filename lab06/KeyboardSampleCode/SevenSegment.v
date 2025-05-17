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
