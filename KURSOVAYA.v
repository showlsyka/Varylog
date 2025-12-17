 module johnson_to_gray(j,g);
parameter Realization= "MDNF";
input [3:0] j;
output[2:0] g;

generate
if(Realization =="MDNF")
assign g[2] =j[3],
          g[1] =j[1],
          g[0] =~j[2]&j[0] | j[2]&~j[0];
else if (Realization == "PIRS") begin
  assign g[2] = j[3];
  assign g[1] = j[1];

  wire nJ0, nJ2;
  wire A, B;
  wire C;

  nor (nJ0, j[0], j[0]);
  nor (nJ2, j[2], j[2]);

  // A = ~(J2 | ~J0)
  nor (A, j[2], nJ0);

  // B = ~(~J2 | J0)
  nor (B, nJ2, j[0]);

  // C = ~(A | B) 
  nor (C, A, B);

  // g0 = ~C 
  nor (g[0], C, C);
end
else if(Realization == "SHEFFER") begin
    assign g[2] = j[3];
    assign g[1] = j[1];

    wire nJ2, nJ0;
    wire A, B;

  nand (nJ0, j[0], j[0]);
  nand (nJ2, j[2], j[2]);

  nand(A, nJ2, j[0]);

  nand(B, j[2], nJ0);

  nand(g[0], A, B);

end
    endgenerate
  endmodule

  `timescale 1ns/1ns
  `define TD 5
module johnson_to_gray_tb();
  reg  [3:0] johnson = 0;
  wire [2:0] gray;

  johnson_to_gray #("SHEFFER") uut(.j(johnson), .g(gray));

  initial begin
    $display(" i | johnson | GRAY ");
    $display("----------------------");

    repeat (8) begin
      #1; 
      $display("%2d |  %b   |  %b   |",
               johnson, johnson, gray);

      #(`TD-1);
      johnson = {johnson[2:0], ~johnson[3]};
    end

    $finish;
  end
endmodule
