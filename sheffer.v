module sheffer (input [3:0] x, output z);

wire y1, y2, y3, y4, y5, y6, nx0, nx1, nx2, nx3;

not (nx0, x[0]);
not (nx1, x[1]);
not (nx2, x[2]);
not (nx3, x[3]);

or (y1, x[3], x[2], x[1], x[0]);
or (y2, x[3], x[2], nx1, x[0]);
or (y3, x[3],nx2, nx1, x[0]);
or (y4, x[3], nx2, nx1, nx0);
or (y5, nx3, x[2], x[1], nx0);
or (y6, nx3, x[2], nx1, nx0);

nand (z, y1, y2, y3, y4, y5, y6);

endmodule


module main;

supply0 gnd;
supply1 vcc;

reg  [3:0] x = 0;
wire z;

sheffer s1(x, z);

initial begin: test
  integer i;
  for (i = 0; i < 16; i = i + 1) begin
    x = i; #1 $display("%3b | %3b |", x, z);
  end
  $finish;
end

endmodule
