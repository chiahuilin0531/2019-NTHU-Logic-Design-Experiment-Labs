module lab1_b2 (a, b, c, aluctr, d, e);
	input [3:0] a,b;
	input [1:0] aluctr;
	input c;
	output [3:0] d;
	output e;

	wire w, x, z;
	
	lab1_b1 l3 (.a(a[3]), .b(b[3]), .c(z), .aluctr(aluctr), .d(d[3]), .e(e));
	lab1_b1 l2 (.a(a[2]), .b(b[2]), .c(w), .aluctr(aluctr), .d(d[2]), .e(z));
	lab1_b1 l1 (.a(a[1]), .b(b[1]), .c(x), .aluctr(aluctr), .d(d[1]), .e(w));
	lab1_b1 l0 (.a(a[0]), .b(b[0]), .c(c), .aluctr(aluctr), .d(d[0]), .e(x));

endmodule