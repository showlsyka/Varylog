
module Zhigalkin (input [3:0] x, output z);

wire y1, y2, y3, nx0, nx1, nx2, nx3;

not(nx0, x[0]);
not(nx1, x[1]);
not(nx2, x[2]);
not(nx3, x[3]);

and(y1, x[0], x[2]);
and(y2, x[1], x[2]);
and(y3, x[2], x[3]);
and(y4, x[1], x[2], x[3]);

xor(z, 1'b1, x[0], x[2], x[3], y1, y2, y3, y4);

endmodule


module main;
supply0 gnd;
supply1 vcc;

reg [3:0] x = 0;
wire z;

Zhigalkin s1(x, z);

initial begin: test
    integer i;
    for(i=0; i<16; i = i+1) begin
        x = i; #1 $display ("%3b | %3b |", x, z);
    end
    $finish;
end

endmodule
