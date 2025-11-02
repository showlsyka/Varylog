module sheme(input [3:0] x, output z);

assign z = (x[3] & ~x[2] & x[0])
         | (~x[3] & x[2] & x[1])
         | (~x[3] & ~x[2] & ~x[0]);

endmodule


module main;

reg  [3:0] x = 0;
wire z;

sheme s1(x, z);

initial begin: test
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
        x = i; #1 $display("%3b %b", x, z);
    end
    $finish;
end

endmodule
