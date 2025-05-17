module lab2_2(clk, rst_n, en, dir, gray, cout); 
    input clk, rst_n, en, dir;
    output [7:0] gray;
    output cout;
    
    wire c0;

    gray_1_digit g0(.clk(clk), .rst_n(rst_n), .en(en), .dir(dir), .gray(gray[3:0]), .cout(c0));
    gray_1_digit g1(.clk(clk), .rst_n(rst_n), .en(c0), .dir(dir), .gray(gray[7:4]), .cout(cout));
    // add your design here
    
endmodule

module gray_1_digit(clk, rst_n, en, dir, gray, cout);

    input clk, rst_n, en, dir;
    output [3:0] gray;
    output reg cout;

    //reg bool;
	reg [3:0] count, next_count;
	
    xor x1(gray[0], count[1], count[0]);
    xor x2(gray[1], count[2], count[1]);
    xor x3(gray[2], count[3], count[2]);
    assign gray[3] = count[3];
    
    always@(negedge clk or rst_n)begin
		if (rst_n == 1'b0)begin
            count = 4'b0000;
	    end else begin
            count = next_count;
        end
        //$display("count = %b", count);
    end


    always@(*)begin
        
        if (en == 1'b0)begin
            next_count = count;
            cout = 1'b0;
        end else begin
            if (dir == 1'b1)begin
                next_count = count + 1;
                if (count == 4'b1111)
                    cout = 1'b1;
                else
                    cout = 1'b0;
            end else begin
                next_count = count - 1;
                if (count == 4'b0000)
                    cout = 1'b1;
                else
                    cout = 1'b0;
            end
        end
        
    end

endmodule


            /*
            if (bool == 1'b1)begin

                casex (count)
                    4'bxxx1:    next_count[1] = !next_count[1];
                    4'bxx10:    next_count[2] = !next_count[2];
                    4'bx100:    next_count[3] = !next_count[3];
                    4'b1000:begin
                        next_count = 4'b0000;
                        cout = 1'b1;
                    end
                    default next_count = 4'b0001;

                endcase
                bool = 1'b0;
                
            end else begin
                //next_count[0] = !next_count[0];
                //bool = 1'b1;
            end
        */
