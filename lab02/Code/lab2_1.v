module lab2_1(clk, rst_n, en, dir, in, data, out); 
	input clk, rst_n, en, dir, in;
	input [3:0] data; 
	output [3:0] out;
	
	reg [3:0] count, next_count;

	always@(posedge clk or rst_n)begin
		if (rst_n == 1'b0)begin
            count = 4'b0000;
	    end
        else 
            count = next_count;
	end

    always@(*)begin
        if (en == 1'b0)begin
            next_count = count;
        end
        else begin
            if (in == 1'b0)begin
                if (dir == 1'b1)
                    next_count = count + 4'b0001;
                else begin
                    next_count = count + 4'b1111;
                end
            end
            else begin
                next_count = data;
            end
        end
    end
    
    assign out = count;

endmodule
