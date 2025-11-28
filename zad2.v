module zad2(x,y);
input [2:0] x;
output reg [7:0] y;
parameter Realization = "Case";
generate
if(Realization == "Case")
always @*
begin
case(x)
3'b000 : y=8'b11111110;
3'b001 : y=8'b11111101;
3'b010 : y=8'b11111011;
3'b011 : y=8'b11110111;
3'b100 : y=8'b11101111;
3'b101 : y=8'b11011111;
3'b110 : y=8'bx;
default: y=8'bx;
endcase
end

else
always @*
begin
if (x==0) y=8'b11111110;
else if (x==1) y=8'b11111101;
else if (x==2) y=8'b11111011;
else if (x==3) y=8'b11110111;
else if (x==4) y=8'b11101111;
else if (x==5) y=8'b11011111;
else if (x==6) y=8'b10111111;
else y=8'b01111111;
end
endgenerate
endmodule

