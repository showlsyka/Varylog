module jkff (q, clock, j, k);
    output reg q = 0;
    input clock, j, k;

    always @(posedge clock) begin
        casex ({j,k})
            2'b11: q <= ~q;     // toggle
            2'b1?: q <= 1'b1;   // set (k don't care)
            2'b?1: q <= 1'b0;   // reset (j don't care)
            default: q <= q;    // hold
        endcase
    end
endmodule

module gray_counter (clock, q);
    input clock;
    output [3:0] q;

    reg [3:0] j, k;

    always @* begin
          j = 0;
          k = 0;
        case (q)
            4'b0000: {j,k} = 8'b0001????; // -> 0001
            4'b0001: {j,k} = 8'b001????0; // -> 0011
            4'b0011: {j,k} = 8'b00????01; // -> 0010
            4'b0010: {j,k} = 8'b01?0??0?; // -> 0110
            4'b0110: {j,k} = 8'b0??1?00?; // -> 0111
            4'b0111: {j,k} = 8'b0????010; // -> 0101
            4'b0101: {j,k} = 8'b0?0??0?1; // -> 0100
            4'b0100: {j,k} = 8'b1?00?0??; // -> 1100
            4'b1100: {j,k} = 8'b??0100??; // -> 1101
            4'b1101: {j,k} = 8'b??1?00?0; // -> 1111
            4'b1111: {j,k} = 8'b????0001; // -> 1110
            4'b1110: {j,k} = 8'b???0010?; // -> 1010
            4'b1010: {j,k} = 8'b?0?10?0?; // -> 1011
            4'b1011: {j,k} = 8'b?0??0?10; // -> 1001
            4'b1001: {j,k} = 8'b?00?0??1; // -> 1000
            4'b1000: {j,k} = 8'b?0001???; // -> 0000

            default: {j,k} = 8'b0000_0000;
        endcase
    end

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1)
            jkff jkffi (q[i], clock, j[i], k[i]);
    endgenerate
endmodule

`timescale 1ns/1ns
module gray_counter_tb ();
    reg clock = 0;
    wire [3:0] g;

    gray_counter gc (clock, g);

    // Gray -> Bin для печати (чтобы видеть "0..15")
    function [3:0] gray2bin;
        input [3:0] gray;
        integer i;
        begin
            gray2bin = gray;
            for (i = 2; i >= 0; i = i - 1)
                gray2bin[i] = gray2bin[i+1] ^ gray2bin[i];
        end
    endfunction

    // Bin -> Gray для расчёта Qnext (чтобы вывести next)
    function [3:0] bin2gray;
        input [3:0] bin;
        begin
            bin2gray = bin ^ (bin >> 1);
        end
    endfunction

    wire [3:0] b      = gray2bin(g);
    wire [3:0] g_next = bin2gray(b + 1'b1);

    integer step;

    initial begin
        $display("====================================================");
        $display("4-bit Gray counter (UP) truth table / transitions");
        $display(" step | Q_gray | Q_bin(dec) | Qnext_gray");
        $display("----------------------------------------------------");

        // печатаем 16 переходов
        for (step = 0; step < 16; step = step + 1) begin
            @(negedge clock); // между фронтами состояние стабильно
             #1;
            $display(" %4d |  %b   |    %2d     |   %b",
                     step, g, b, g_next);
            @(posedge clock);
        end

        $display("====================================================");
        $finish;
    end

    // генератор тактов
    always #5 clock = ~clock;

endmodule
