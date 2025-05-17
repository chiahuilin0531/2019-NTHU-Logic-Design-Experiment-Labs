module lab1_1 (a, b, c, aluctr, d, e);

	input a, b, c;
	input [1:0] aluctr;
	output d, e;

	wire x1, x2, x3, x4;
	wire y1;
	wire and2, and3, and4;
	wire xor1, xor2;
	
	and a1 (x2, a, b);
	nor n1 (x3, a, b);
	
	and a2 (and2, a, b, c);
	or  o1 (x1, xor2, and2);
	
	and a3 (and3, a, c);
	and a4 (and4, b, c);
	or  o2 (y1, x2, and3, and4);

	

	myxor mxd(
		.a(a),
		.b(b),
		.out(x4)
	);
	myxor mxe1(
		.a(a),
		.b(b),
		.out(xor1)
	); 
	myxor mxe2(
		.a(xor1),
		.b(c),
		.out(xor2)
	); 

	mux4_to_1 m1(
	   .q_o(d),
	   .a_i(x1),
	   .b_i(x2),
	   .c_i(x3),
	   .d_i(x4),
	   .sel_i(aluctr)
	);

	mux4_to_1 m2(
	   .q_o(e),
	   .a_i(y1),
	   .b_i(1'b0),
	   .c_i(1'b0),
	   .d_i(1'b0),
	   .sel_i(aluctr)
	);

endmodule