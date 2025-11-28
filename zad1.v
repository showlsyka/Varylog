module zad1
#(parameter Realization= "MKNF")
(input wire [2:0] x, output wire [5:0] y);
generate

if (Realization == "MKNF")
begin
wire nx0,nx1,nx2, w1;
not (nx0, x[0]); not (nx1, x[1]); not (nx2, x[2]);
or (w1, x[2], x[1]),
(y[0], w1, x[0]),
(y[1], w1, nx0),
(y[2], nx1, x[0]),
(y[3], nx1, nx0),
(y[4], nx2, x[0]),
(y[5], nx2, nx0);
end
 
else if (Realization == "PIRS")
begin
wire n1,n2,n3,n4,n5;
nor(n1,x[2],x[1]); //~(x2 + x1)

nor(n2,n1,n1);// //~~(x2 + x1)

nor(n3,x[0],x[0]); // ~x0

nor(n4,n3,n3); // ~(~x0+~x0)

nor(n5,n2,n4); nor(y[0],n5,n5); //y0

nor(n6,n2,n3); nor(y[1],n6,n6); //y1

nor(n22,x[1],x[1]); nor(n23,n22,x[0]); nor(y[2],n23,n23); 

nor(n10,n22,n3); nor(y[3],n10,n10); //y3

nor(n11,x[2],x[2]); nor(n12,n11,x[0]); nor(y[4],n12,n12);//y4 n11 nx2x2

nor(n13,n11,n3); nor(y[5],n13,n13);//y5
end

else if (Realization == "SHEFER")
begin
wire [2:0] nx; 
wire[1:0] ny;
nand (nx[2], x[2], x[2]); // ~x2
nand (nx[1], x[1], x[1]); // ~x1
nand (nx[0], x[0], x[0]); // ~x0

nand (ny[0],nx[2],nx[1]); // ~x1 * ~x2 - > x1 + x2
nand (ny[1],ny[0],ny[0]); // x1 + x2   - > ~x1 * ~x2

nand (y[0],ny[1],nx[0]);  // y0  
nand (y[1],ny[1],x[0]);   // y1
nand(y[2],nx[0], x[1]);   // y2
nand(y[3],x[0], x[1]);    // y3
nand(y[4],nx[0], x[2]);   //y4
nand(y[5],x[2], x[0]);    //y5
end

else if  (Realization == "ZHEG")
begin
and(x1x0,x[1],x[0]);and(x2x0,x[2],x[0]);and(x2x1,x[2],x[1]);and(x2x1x0,x2x1,x[0]);
xor(z1,x[0],x[1]);xor(z2,x1x0,z1);xor(z3,x[2],z2);
xor(z4,x2x0,z3);xor(z5,x2x1,z4);xor(y[0],x2x1x0,z5);

xor(z6, x[0], x1x0);xor(z7,z6,1);xor(y[1],z7,x2x0);

xor(z8,1,x[1]);xor(y[2],z8,x1x0);
xor(y[3],1,x1x0);
xor(z9,1,x[2]);xor(y[4],z9,x2x0);
xor(y[5],1,x2x0);
end

endgenerate

endmodule
