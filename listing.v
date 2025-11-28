`include "zad1.v"
`timescale 1ns/1ns
module zad1_tb ();
reg [2:0] x;
wire [5:0] y;
integer i;
realtime t;
localparam n=8;
zad1 #(.Realization("ZHEG"))
t1 (.x(x), .y(y));
initial 
begin
x=0;
for (i=0; i<n; i=i+1)
begin
if( i<n-2) x=i;
else if (i==n-2) x= 'bx;
else x= 'bz;
t=$time;
$strobe(
"t=%3.0f ns, x=%b, y=%b",
 t, x, y);
#50;
end
end
endmodule

`define TD 5
`timescale 1ns/1ns

module decoder3_5_tb;
    reg  [2:0] x;
    wire [5:0] y;
    integer i;

zad1 #(.Realization("ZHEG"))
t1 (.x(x), .y(y));

    initial begin
        $display("x2 x1 x0 |y5 y4 y3 y2 y1 y0");
        for (i = 0; i < 6; i = i + 1) begin
            x = i[2:0];
            #`TD;
            $display("%1b  %1b  %1b | %1b %1b  %1b  %1b  %1b  %1b",
                     x[2], x[1], x[0],
                    y[5], y[4], y[3], y[2], y[1], y[0]);
        end
    end
endmodule

