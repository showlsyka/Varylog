module inv(input x, output y);
  supply1 vcc;
  supply0 gnd;

  pmos(y, vcc, x);
  nmos(y, gnd, x);
endmodule


module scheme (input [3:0] x, output y);
  supply1 vcc;
  supply0 gnd;

  wire nx1, nx2, nx3, nx0, w1, w2, w3;

  inv i1 (x[2], nx2);
  inv i2 (x[3], nx3);
  inv i3 (x[0], nx0);
  inv i4 (x[1], nx1);

  pmos(w1, vcc, x[3]);  pmos(w1, vcc, nx0);
  pmos(w2, vcc, x[3]);  pmos(w2, vcc, x[2]);
  pmos(w3, w2,  x[2]);  pmos(w3, w2,  nx1);
  pmos(y,  w3,  nx3);   pmos(y,  w3,  nx2);  pmos(y, w3, x[0]);

  pulldown(y);
endmodule


module main;
  reg  [3:0] x;
  wire y;

  scheme s1(x, y);

  initial begin : test
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
      x = i; #1; $display("%3b %b", x, y);
    end
    $finish;
  end
endmodule
