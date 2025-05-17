module lab1_3 (a, b, c, aluctr, d, e);

	input a, b, c;
	input [1:0] aluctr;
	output reg d, e;

	wire and0, nor0, xor0;

	and and_0 (and0, a, b);
	nor nor_0 (nor0, a, b);
	myxor m_0 (.out(xor0), .a(a), .b(b));
	
	always@(*)begin
		case(aluctr)
			0: begin
				{e,d} = a + b + c;
			end

			1: begin
				d = and0;
				e = 1'b0;
			end

			2: begin
				d = nor0;
				e = 1'b0;
			end

			3: begin
				d = xor0;
				e = 1'b0;
			end
		endcase
	end

	
endmodule