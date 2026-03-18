`timescale 1ns/1ns

module jkff(clock, j, k, q);
    input clock, j, k;
    output reg q = 0;

    always @(posedge clock)
        if (j && k)      q <= ~q;
        else if (j)      q <= 1'b1;
        else if (k)      q <= 1'b0;
endmodule


// =====================================================
// SUM
// =====================================================
module count4gray_sum_jk(clock, b);
    input clock;
    output [3:0] b;

    wire [3:0] j, k, q;

    assign j[3] =  q[2] & ~q[1] & ~q[0];
    assign k[3] = ~q[2] & ~q[1] & ~q[0];

    assign j[2] =  q[1] & ~q[3] & ~q[0];
    assign k[2] =  q[1] &  q[3] & ~q[0];

    assign j[1] = (q[0] & ~q[2] & ~q[3]) |
                  (q[0] &  q[2] &  q[3]);

    assign k[1] = (q[0] &  q[2] & ~q[3]) |
                  (q[0] &  q[3] & ~q[2]);

    assign j[0] = ( q[1] &  q[2] & ~q[3]) |
                  ( q[1] &  q[3] & ~q[2]) |
                  ( q[2] &  q[3] & ~q[1]) |
                  (~q[1] & ~q[2] & ~q[3]);

    assign k[0] = ( q[1] &  q[2] &  q[3]) |
                  ( q[1] & ~q[2] & ~q[3]) |
                  ( q[2] & ~q[1] & ~q[3]) |
                  ( q[3] & ~q[1] & ~q[2]);

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1)
            jkff jkffi(clock, j[i], k[i], q[i]);
    endgenerate

    assign b = q;
endmodule


// =====================================================
// SUB
// =====================================================
module count4gray_sub_jk(clock, b);
    input clock;
    output [3:0] b;

    wire [3:0] j, k, q;

    assign j[3] = ~q[2] & ~q[1] & ~q[0];
    assign k[3] =  q[2] & ~q[1] & ~q[0];

    assign j[2] =  q[1] &  q[3] & ~q[0];
    assign k[2] =  q[1] & ~q[3] & ~q[0];

    assign j[1] = (q[0] &  q[2] & ~q[3]) |
                  (q[0] &  q[3] & ~q[2]);

    assign k[1] = (q[0] & ~q[2] & ~q[3]) |
                  (q[0] &  q[2] &  q[3]);

    assign j[0] = ( q[1] &  q[2] &  q[3]) |
                  ( q[1] & ~q[2] & ~q[3]) |
                  ( q[2] & ~q[1] & ~q[3]) |
                  ( q[3] & ~q[1] & ~q[2]);

    assign k[0] = ( q[1] &  q[2] & ~q[3]) |
                  ( q[1] &  q[3] & ~q[2]) |
                  ( q[2] &  q[3] & ~q[1]) |
                  (~q[1] & ~q[2] & ~q[3]);

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1)
            jkff jkffi(clock, j[i], k[i], q[i]);
    endgenerate

    assign b = q;
endmodule

`timescale 1ns/1ns
`include "asiign.v"

module gray_jk_sum_sub_tb();

    reg clock = 0;

    wire [3:0] b_sum;
    wire [3:0] b_sub;

    count4gray_sum_jk sum_counter(clock, b_sum);
    count4gray_sub_jk sub_counter(clock, b_sub);

    initial
        repeat (64) #5 clock = ~clock;

endmodule
