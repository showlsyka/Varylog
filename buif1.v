primitive tabl(y, x3, x2, x1, x0);
  output y;
  input  x3, x2, x1, x0;

  table
    0 0 0 0 : 1;
    0 0 0 1 : 0;
    0 0 1 0 : 1;
    0 0 1 1 : 0;
    0 1 0 0 : 0;
    0 1 0 1 : 0;
    0 1 1 0 : 1;
    0 1 1 1 : 1;
    1 0 0 0 : 0;
    1 0 0 1 : 1;
    1 0 1 0 : 0;
    1 0 1 1 : 1;
    1 1 0 0 : 0;
    1 1 0 1 : 0;
    1 1 1 0 : 0;
    1 1 1 1 : 0;
  endtable
endprimitive


module main;
  supply0 gnd;
  supply1 vcc;

  reg  [3:0] x;
  wire z, w;

  tabl  tabl (z, x[3], x[2], x[1], x[0]);
  bufif1 b   (z, w, gnd);

  initial begin: test
    integer i, j;

    for (i = 0; i < 16; i = i + 1) begin
      x = i; #1 $display("%2d | %3b | %3b | %3b | %3b | %b", x, x[3], x[2], x[1], x[0], w);
    end

    for (j = 16; j < 32; j = j + 1) begin
      x = j; #1 $display("%2d | %3b | %3b | %3b | %3b | %b", x, x[3], x[2], x[1], x[0], z);
    end

    $finish;
  end
endmodule
