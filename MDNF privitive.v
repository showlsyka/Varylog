module sheme (input [3:0] x, output z);

wire nx3, nx2, nx0, y1, y2, y3;

not (nx3, x[3]);
not (nx2, x[2]);
not (nx0, x[0]);

and (y1, nx3, nx2, nx0);
and (y2, x[3], nx2, x[0]);
and (y3, nx3, x[2], x[1]);
or  (z,  y2, y1, y3);

endmodule


module main;

reg  [3:0] x = 0;
wire z;

sheme s1(x, z);

initial begin: test
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
        x = i; #1 $display("%3b | %b", x, z);
    end
    $finish;
end

endmodule
