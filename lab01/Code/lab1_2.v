module lab1_2 (a, b, c, aluctr, d, e);

	input a, b, c;
	input [1:0] aluctr;
	output d, e;

	assign d = !aluctr[0]&!aluctr[1]&(!a&!b&c | a&b&c | a&!b&!c | !a&b&!c) | 
	           !aluctr[1]&aluctr[0]&a&b |
	           aluctr[0]&aluctr[1]&(a&!b|!a&b) |
	           aluctr[1]&!aluctr[0]&!a&!b;

	assign e = !aluctr[0]&!aluctr[1]&(a&b|a&c|b&c);

endmodule