module zhegalkin_assign(input [3:0] x, output y);
  assign y =  1'b1^ x[0] ^ x[2] ^ x[3] ^ (x[0] & x[2]) ^ 
             (x[2] & x[1]) ^ (x[3] & x[2]) ^ 
             (x[3] & x[2] & x[1]);
endmodule

module main;
  reg  [3:0] x;
  wire       z;

  zhegalkin_assign s1 (x,z);

  integer i;
  initial begin : test
    $display(" i | x3 x2 x1 x0 | y");
    $display("-----------------------");

    for (i = 0; i < 16; i = i + 1) begin
      x = i[3:0];
      #1;
      $display("%2d |  %b  %b  %b  %b | %b",
               i, x[3], x[2], x[1], x[0], z);
    end

    $finish;
  end
endmodule
