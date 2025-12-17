
module inv(input x, output y);
  supply1 vcc;
  supply0 gnd;

  pmos(y, vcc, x);
  nmos(y, gnd, x);
endmodule

 module johnson_to_gray(j,g);
parameter Realization= "MDNF";
input wire [3:0] j;
output reg [2:0] g;

generate
if(Realization =="MDNF")
begin
  supply1 vcc;
  supply0 gnd;

  wire nJ3, nJ1, nJ0, nJ2;
  wire w1, w2, w3;

  inv i1 (j[3], nJ3);
  inv i2 (j[1], nJ1);
  inv i3 (j[0], nJ0);
  inv i4 (j[2], nJ2);

  pmos(g[2], vcc, nJ3);
  nmos(g[2], gnd, nJ3);

  pmos(g[1], vcc, nJ1);
  nmos(g[1], gnd, nJ1);

  pmos(w1, vcc, j[2]); pmos(g[0], w1, nJ0);
  pmos(w3, vcc, nJ2); pmos(g[0], w3, j[0]);

  nmos(w2, gnd, nJ2); nmos(w2, gnd, j[0]);
  nmos(g[0], w2, j[2]); nmos(g[0], w2, nJ0);
end
else if(Realization == "Case") begin
  always @* begin
        case (j)
            4'b0000: g = 3'b000; 
            4'b0001: g = 3'b001; 
            4'b0011: g = 3'b011; 
            4'b0111: g = 3'b010; 
            4'b1111: g = 3'b110; 
            4'b1110: g = 3'b111; 
            4'b1100: g = 3'b101; 
            4'b1000: g = 3'b100; 
            default: g = 3'bxxx; 
        endcase
    end
end
else if (Realization == "PIRS") begin
  assign g[2] = j[3];
  assign g[1] = j[1];

  assign g[0] = (~j[2] & j[0]) | (j[2] & ~j[0]);
end
else if(Realization == "SHEFFER") begin
  wire g1, g2;
  wire nJ2, nJ0;
  wire A, B;

  nand(g1, j[3], j[3]);
  nand(g[2], g1, g1);

  nand(g2, j[1], j[1]);
  nand(g[1], g2, g2);

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
  reg  [3:0] johnson;
  wire [2:0] gray;

  johnson_to_gray #("Case") uut(.j(johnson), .g(gray));

  initial begin
    johnson = 4'b0000;
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
