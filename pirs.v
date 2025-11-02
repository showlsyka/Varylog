module pirs (input [3:0] x, output z);

wire y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, nx0, nx1, nx2, nx3;

not(nx0, x[0]);
not(nx1, x[1]);
not(nx2, x[2]);
not(nx3, x[3]);

and(y1, nx3, nx2, nx1, x[0]);
and(y2, nx3, nx2, x[1], x[0]);
and(y3, nx3, x[2], nx1, nx0);
and(y4, x[3], nx2, nx1, nx0);
and(y5, x[3], nx2, x[1], nx0);
and(y6, x[3], x[2], nx1, nx0);
and(y7, x[3], x[2], nx1, x[0]);
and(y8, x[3], x[2], x[1], nx0);
and(y9, x[3], x[2], x[1], x[0]);
and(y10, nx3, x[2], nx1, x[0]);

nor(z, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10);

endmodule


module main;
supply0 gnd;
supply1 vcc;

reg [3:0] x = 0;
wire z;

pirs s1(x, z);

initial begin: test
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
        x = i; #1 $display("%3b | %3b |", x, z);
    end
    $finish;
end

endmodule
