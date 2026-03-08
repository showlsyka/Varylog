`timescale 1ns/1ns

module jkff (output reg q = 0, input clock, j, k);
    always @(posedge clock)
        if (j && k)      q <= ~q;
        else if (j)      q <= 1'b1;
        else if (k)      q <= 1'b0;
        else             q <= q;
endmodule


module lr5zd5 #(parameter mode="SUM") (output [3:0] b, input clk);

    wire [3:0] next;

    assign next =
        (b==4'b0000) ? 4'b0001 :
        (b==4'b0001) ? 4'b0011 :
        (b==4'b0011) ? 4'b0010 :
        (b==4'b0010) ? 4'b0110 :
        (b==4'b0110) ? 4'b0111 :
        (b==4'b0111) ? 4'b0101 :
        (b==4'b0101) ? 4'b0100 :
        (b==4'b0100) ? 4'b1100 :
        (b==4'b1100) ? 4'b1101 :
        (b==4'b1101) ? 4'b1111 :
        (b==4'b1111) ? 4'b1110 :
        (b==4'b1110) ? 4'b1010 :
        (b==4'b1010) ? 4'b1011 :
        (b==4'b1011) ? 4'b1001 :
        (b==4'b1001) ? 4'b1000 :
        (b==4'b1000) ? 4'b0000 :
                      4'b0000;  // ?? ?????? ??????

    // 0->1: J=1 K=0
    // 1->0: J=0 K=1
    // 0->0: J=0 K=0
    // 1->1: J=0 K=0
    wire [3:0] j = (~b) & next;
    wire [3:0] k = ( b) & (~next);

    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin: registers
            jkff jkffi (.q(b[i]), .clock(clk), .j(j[i]), .k(k[i]));
        end
    endgenerate

endmodule


`timescale 1ns/1ns
`define TD 10
`include "lr5zd5.vhd"


module lr5zd5_tb();
    reg clk=0;
    wire [3:0] b;
    
    lr5zd5 #(.mode("SUM")) counter (.b(b), .clk(clk));
    initial
        repeat (64) #`TD clk=~clk;
endmodule
