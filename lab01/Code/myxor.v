module myxor (a, b, out);

	input a, b;
	output out;

	wire not_a, not_b;
	wire and0, and1;

	not not_0 (not_a, a);
	not not_1 (not_b, b);
	
	and and_0 (and0, not_a, b);
	and and_1 (and1, a, not_b);

	or or_0 (out, and0, and1);

endmodule
