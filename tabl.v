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

  reg  [3:0] x = 0;
  wire z;

  tabl t1 (z, x[3], x[2], x[1], x[0]);

  initial begin: test
    integer i;
    $display(" x3  x2  x1  x0 | y");
    for (i = 0; i < 16; i = i + 1) begin
      x = i; #1 $display("%3b  %3b  %3b  %3b | %b", x[3], x[2], x[1], x[0], z);
    end
    $finish;
  end

endmodule
