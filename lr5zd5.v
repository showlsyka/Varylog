`timescale 1ns/1ns

module jkff (output reg q = 0, input clock, j, k);
    always @(posedge clock)
        if (j && k)      q <= ~q;
        else if (j)      q <= 1'b1;
        else if (k)      q <= 1'b0;
        else             q <= q;
endmodule


module lr5zd5 #(parameter mode="SUM") (output [3:0] b, input clk);

    reg  [3:0] next;     // next ???????? ? always @*
    wire [3:0] j;
    wire [3:0] k;

    always @* begin
        // default (????? ?? ???? latch)
        next = 4'b0000;

        if (mode == "SUM") begin
            // -------- SUM (Gray UP) --------
            if      (b==4'b0000) next = 4'b0001;
            else if (b==4'b0001) next = 4'b0011;
            else if (b==4'b0011) next = 4'b0010;
            else if (b==4'b0010) next = 4'b0110;
            else if (b==4'b0110) next = 4'b0111;
            else if (b==4'b0111) next = 4'b0101;
            else if (b==4'b0101) next = 4'b0100;
            else if (b==4'b0100) next = 4'b1100;
            else if (b==4'b1100) next = 4'b1101;
            else if (b==4'b1101) next = 4'b1111;
            else if (b==4'b1111) next = 4'b1110;
            else if (b==4'b1110) next = 4'b1010;
            else if (b==4'b1010) next = 4'b1011;
            else if (b==4'b1011) next = 4'b1001;
            else if (b==4'b1001) next = 4'b1000;
            else if (b==4'b1000) next = 4'b0000;
            else                 next = 4'b0000;
        end
        else if (mode == "SUB") begin
            // -------- SUB (Gray DOWN) --------
            if      (b==4'b0000) next = 4'b1000;
            else if (b==4'b0001) next = 4'b0000;
            else if (b==4'b0011) next = 4'b0001;
            else if (b==4'b0010) next = 4'b0011;
            else if (b==4'b0110) next = 4'b0010;
            else if (b==4'b0111) next = 4'b0110;
            else if (b==4'b0101) next = 4'b0111;
            else if (b==4'b0100) next = 4'b0101;
            else if (b==4'b1100) next = 4'b0100;
            else if (b==4'b1101) next = 4'b1100;
            else if (b==4'b1111) next = 4'b1101;
            else if (b==4'b1110) next = 4'b1111;
            else if (b==4'b1010) next = 4'b1110;
            else if (b==4'b1011) next = 4'b1010;
            else if (b==4'b1001) next = 4'b1011;
            else if (b==4'b1000) next = 4'b1001;
            else                 next = 4'b0000;
        end
        else begin
            next = 4'b0000;  
        end
    end

    // ??????????? JK (0/1, ??? ?)
    assign j = (~b) & next;
    assign k = ( b) & (~next);

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

    lr5zd5 #(.mode("SUB")) counter (.b(b), .clk(clk));

    initial begin
        repeat (64) #`TD clk=~clk;
        $finish;
    end
endmodule
