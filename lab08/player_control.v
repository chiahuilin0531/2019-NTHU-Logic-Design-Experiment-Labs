module player_control (
	input clk,
	input reset,
	input _play,
	input _repeat,
	input _music,
	output reg [11:0] ibeat
);
	parameter LEN = 4095;
    reg [11:0] next_ibeat;
    reg prev_music;

	always @(posedge clk, posedge reset) begin
		prev_music <= prev_music;
		if (reset) begin
			ibeat <= 0;
			prev_music <= _music;
		end else if (prev_music != _music) begin
		    ibeat <= 0;
		    prev_music <= _music;
		end else if (_play) begin
            ibeat <= next_ibeat;
		end else 
		    ibeat <= ibeat;
	end

    always @* begin
        next_ibeat = (ibeat + 1 < LEN) ? (ibeat + 1) : ((_repeat)? 12'd0 : LEN);
    end

endmodule