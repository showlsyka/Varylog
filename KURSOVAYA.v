module johnson_to_gray(j,g);
parameter Realization= "MDNF";
input wire [3:0] j;
output reg [2:0] g;
output wire [2:0] g;

generate
if(Realization =="MDNF")
@@ -38,20 +38,22 @@ begin
nmos(w2, gnd, nJ2); nmos(w2, gnd, j[0]);
nmos(g[0], w2, j[2]); nmos(g[0], w2, nJ0);
end
else if(Realization == "Case") begin
  always @* begin
else if (Realization == "Case") begin : GEN_CASE
    reg [2:0] g_r;      
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
            4'b0000: g_r = 3'b000;
            4'b0001: g_r = 3'b001;
            4'b0011: g_r = 3'b011;
            4'b0111: g_r = 3'b010;
            4'b1111: g_r = 3'b110;
            4'b1110: g_r = 3'b111;
            4'b1100: g_r = 3'b101;
            4'b1000: g_r = 3'b100;
            default: g_r = 3'bxxx;
endcase
end
    assign g = g_r;     
end
else if (Realization == "PIRS") begin
assign g[2] = j[3];
@@ -83,23 +85,32 @@ end
endgenerate
endmodule

  `timescale 1ns/1ns
  `define TD 5
`timescale 1ns/1ns
`define TD 5

module johnson_to_gray_tb();
reg  [3:0] johnson;
  wire [2:0] gray;

  johnson_to_gray #("Case") uut(.j(johnson), .g(gray));
  wire [2:0] gray_mdnf;
  wire [2:0] gray_case;
  wire [2:0] gray_pirs;
  wire [2:0] gray_shef;

  johnson_to_gray #("MDNF")    uut_mdnf (.j(johnson), .g(gray_mdnf));
  johnson_to_gray #("Case")    uut_case (.j(johnson), .g(gray_case));
  johnson_to_gray #("PIRS")    uut_pirs (.j(johnson), .g(gray_pirs));
  johnson_to_gray #("SHEFFER") uut_shef (.j(johnson), .g(gray_shef));

initial begin
johnson = 4'b0000;
    $display(" i | johnson | GRAY ");
    $display("----------------------");

    $display(" i | johnson |  MDNF_GRAY |  CASE_GRAY |  PIRS_GRAY | SHEFFER_GRAY |");
    $display("-------------------------------------------------------------------|");

repeat (8) begin
      #1; 
      $display("%2d |  %b   |  %b   |",
               johnson, johnson, gray);
      #1;
      $display("%2d |  %b   |  %b       |  %b       |  %b       |   %b        |",
               johnson, johnson, gray_mdnf, gray_case, gray_pirs, gray_shef);

#(`TD-1);
johnson = {johnson[2:0], ~johnson[3]};
@@ -108,3 +119,4 @@ module johnson_to_gray_tb();
$finish;
end
endmodule

