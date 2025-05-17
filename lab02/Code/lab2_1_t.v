//`timescale 1ns/100ps

module lab2_1_t();

    reg clk, rst_n, en, dir, in, pass;
    reg [3:0] data, cnt;
    wire [3:0] out;

    integer i;

    lab2_1 counter(
        .clk(clk), 
        .rst_n(rst_n), 
        .en(en), 
        .dir(dir), 
        .in(in), 
        .data(data), 
        .out(out)
     ); 

    always #5 clk = ~clk;
    initial begin
        clk = 1'b0;
        rst_n = 1'b1;
        en = 1'b0;
        in = 1'b0;
        dir = 1'b1;
        data = 'hz;
        cnt = 4'b0000;
        pass = 1'b1;

        @(negedge clk) rst_n = 1'b0;
        #10

        if (out !== cnt) begin
           $display("Error! out should be %b, you got %b", cnt, out); 
           pass = 1'b0;
           //$finish
        end else $display("Pass! %b", cnt);
        
        @(negedge clk);
        rst_n = 1'b1;
        en = 1'b1;

        for (i = 0; i < 20; i = i+1) begin
            cnt = cnt + 1;
            #2
            if (out !== cnt) begin
                $display($time, "Error! out should be %b, you got %b", cnt, out); 
                pass = 1'b0;
                //$finish
            end else $display("Pass! %b", cnt);
            @(negedge clk);
        end

        en = 1'b0;
        
        #10
        @(negedge clk);
        
        en = 1'b1;
        in = 1'b1;
        data = 4'b1001;
        cnt = 4'b1001;
        dir = 1'b0;

        #10
        @(negedge clk);

        if (out !== cnt) begin
           $display("Error! out should be %b, you got %b", cnt, out); 
           pass = 1'b0;
           //$finish
        end else $display("Pass! %b", cnt);
        
        in = 1'b0;
        @(negedge clk);
        
        for (i = 0; i < 12; i = i+1) begin
            cnt = cnt-1;
            #2
            if (out !== cnt) begin
                $display($time, "Error! out should be %b, you got %b", cnt, out); 
                pass = 1'b0;
                //$finish
            end else $display("Pass! %b", cnt);
            @(negedge clk);
        end
        
        en = 1'b0;
        
        @(negedge clk) 
        rst_n = 1'b0;
        cnt = 4'b0000;
        #10

        if (out !== cnt) begin
           $display("Error! out should be %b, you got %b", cnt, out); 
           pass = 1'b0;
           //$finish
        end else $display("Pass! %b", cnt);
        
        @(negedge clk);
        rst_n = 1'b1;
        en = 1'b0;
        
        if (pass === 1'b1) $display("----------ALL PASS!!!----------");
        else $display("----------STH WRONG!!!----------");
        $finish;
    end
    
endmodule
    
