module inv_decoder3_6 (
    input  wire a2,
    input  wire a1,
    input  wire a0,
    output wire b5,
    output wire b4,
    output wire b3,
    output wire b2,
    output wire b1,
    output wire b0
);

    wire na2, na1, na0;
    not (na2, a2);
    not (na1, a1);
    not (na0, a0);

    wire d0, d1, d2, d3, d4, d5;

    // 000 -> d0
    and (d0, na2, na1, na0);
    // 001 -> d1
    and (d1, na2, na1, a0);
    // 010 -> d2
    and (d2, na2, a1, na0);
    // 011 -> d3
    and (d3, na2, a1, a0);
    // 100 -> d4
    and (d4, a2, na1, na0);
    // 101 -> d5
    and (d5, a2, na1, a0);

    // Инверсные выходы (активный низкий уровень):
    // когда di = 1 -> соответствующий bi = 0
    not (b0, d0);
    not (b1, d1);
    not (b2, d2);
    not (b3, d3);
    not (b4, d4);
    not (b5, d5);

endmodule

module inv_decoder3_6_tb;
    reg  [2:0] a;  
    wire [5:0] b;  

    // Экземпляр тестируемого модуля
    inv_decoder3_6 uut (
        .a2(a[2]),
        .a1(a[1]),
        .a0(a[0]),
        .b5(b[5]),
        .b4(b[4]),
        .b3(b[3]),
        .b2(b[2]),
        .b1(b[1]),
        .b0(b[0])
    );

    initial begin
        $display("a2 a1 a0\t b5 b4 b3 b2 b1 b0");
        $display("--------\t ----------------");

        // Перебор всех комбинаций входов
        #50 a = 3'b000;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);

        #50 a = 3'b001;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);

        #50 a = 3'b010;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);

        #50 a = 3'b011;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);

        #50 a = 3'b100;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);

        #50 a = 3'b101;
        #1
        $display("%b   %b  %b\t  %b  %b  %b  %b  %b  %b",
                 a[2], a[1], a[0],
                 b[5], b[4], b[3], b[2], b[1], b[0]);


        // Завершение симуляции
        #50 $finish;
    end
endmodule
