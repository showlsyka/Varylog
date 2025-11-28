`include "zad2.v"
`timescale 1ns/1ns
module zad2_tb ();
reg [2:0] x;
wire [5:0] y;
integer i;
realtime t;
localparam n=8;

zad2
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

