module inv(input x, output y);
  supply1 vcc;
  supply0 gnd;

  pmos(y, vcc, x);
  nmos(y, gnd, x);
endmodule

 module rom_based(input [3:0] x, output y);
  supply0 gnd;
 supply1 vcc;
 wire[3:0] nx;// инверсии переменных
 wire[15:0] m;  // минтермы
 wire ny;// инверсии функций
 // ---------------------------------Фиксированнаяматрица «И»---------------------------------//
 pmos(nx[0],vcc,x[0]); pmos(nx[1],vcc,x[1]); pmos(nx[2],vcc,x[2]); pmos(nx[3],vcc,x[3]); 
 nmos(nx[0],gnd,x[0]); nmos(nx[1],gnd,x[1]); nmos(nx[2],gnd,x[2]); nmos(nx[3],gnd,x[3]);
 /* x[0], nx[0] */      /* x[1], nx[1] */      /* x[2], nx[2] */
 nmos(m[0],gnd, x[3]); nmos(m[0],gnd, x[2]); nmos(m[0],gnd, x[1]); nmos(m[0],gnd, x[0]); rnmos(m[0],vcc,vcc);// -> m0
 nmos(m[1],gnd, x[3]); nmos(m[1],gnd, x[2]); nmos(m[1],gnd, x[1]); nmos(m[1],gnd, nx[0]); rnmos(m[1],vcc,vcc);
 nmos(m[2],gnd, x[3]); nmos(m[2],gnd, x[2]); nmos(m[2],gnd, nx[1]); nmos(m[2],gnd, x[0]); rnmos(m[2],vcc,vcc);
 nmos(m[3],gnd, x[3]); nmos(m[3],gnd, x[2]); nmos(m[3],gnd, nx[1]); nmos(m[3],gnd, nx[0]); rnmos(m[3],vcc,vcc);
 nmos(m[4],gnd, x[3]); nmos(m[4],gnd, nx[2]); nmos(m[4],gnd, x[1]); nmos(m[4],gnd, x[0]); rnmos(m[4],vcc,vcc);
 nmos(m[5],gnd, x[3]); nmos(m[5],gnd, nx[2]); nmos(m[5],gnd, x[1]); nmos(m[5],gnd, nx[0]); rnmos(m[5],vcc,vcc);
 nmos(m[6],gnd, x[3]); nmos(m[6],gnd, nx[2]); nmos(m[6],gnd, nx[1]); nmos(m[6],gnd, x[0]); rnmos(m[6],vcc,vcc);
 nmos(m[7],gnd, x[3]); nmos(m[7],gnd, nx[2]); nmos(m[7],gnd, nx[1]); nmos(m[7],gnd, nx[0]); rnmos(m[7],vcc,vcc);
 nmos(m[8],gnd, nx[3]); nmos(m[8],gnd, x[2]); nmos(m[8],gnd, x[1]); nmos(m[8],gnd, x[0]); rnmos(m[8],vcc,vcc);
 nmos(m[9],gnd, nx[3]); nmos(m[9],gnd, x[2]); nmos(m[9],gnd, x[1]); nmos(m[9],gnd, nx[0]); rnmos(m[9],vcc,vcc);
 nmos(m[10],gnd, nx[3]); nmos(m[10],gnd, x[2]); nmos(m[10],gnd, nx[1]); nmos(m[10],gnd, x[0]); rnmos(m[10],vcc,vcc);
 nmos(m[11],gnd, nx[3]); nmos(m[11],gnd, x[2]); nmos(m[11],gnd, nx[1]); nmos(m[11],gnd, nx[0]); rnmos(m[11],vcc,vcc);
 nmos(m[12],gnd, nx[3]); nmos(m[12],gnd, nx[2]); nmos(m[12],gnd, x[1]); nmos(m[12],gnd, x[0]); rnmos(m[12],vcc,vcc);
 nmos(m[13],gnd, nx[3]); nmos(m[13],gnd, nx[2]); nmos(m[13],gnd, x[1]); nmos(m[13],gnd, nx[0]); rnmos(m[13],vcc,vcc);
 nmos(m[14],gnd, nx[3]); nmos(m[14],gnd, nx[2]); nmos(m[14],gnd, nx[1]); nmos(m[14],gnd, x[0]); rnmos(m[14],vcc,vcc);
 nmos(m[15],gnd, nx[3]); nmos(m[15],gnd, nx[2]); nmos(m[15],gnd, nx[1]); nmos(m[15],gnd, nx[0]); rnmos(m[15],vcc,vcc);

 // ---------------------------------------------------------------------------------------------//
 // ----Программируемая матрица «ИЛИ»----//
 /* y[1] */           /*  y[0]  */
 rnmos(ny,vcc,vcc);
 nmos(ny,gnd,m[0]);
 nmos(ny,gnd,m[2]);
 nmos(ny,gnd,m[6]);
 nmos(ny,gnd,m[7]);
 nmos(ny,gnd,m[9]);
 nmos(ny,gnd,m[11]);
 pmos(y,vcc,ny);
 nmos(y,gnd,ny);
 // ---------------------------------------//
 endmodule


module mdnt_transistors (input [3:0] x, output y);
  supply1 vcc;
  supply0 gnd;

  wire nx1, nx2, nx3, nx0, w1, w2, w3;

  inv i1 (x[2], nx2);
  inv i2 (x[3], nx3);
  inv i3 (x[0], nx0);
  inv i4 (x[1], nx1);

  pmos(w1, vcc, x[3]);  pmos(w1, vcc, nx0);
  pmos(w2, w1, x[3]);  pmos(w2, w1, x[2]);
  pmos(w3, w2,  x[2]);  pmos(w3, w2,  nx1);
  pmos(y,  w3,  nx3);   pmos(y,  w3,  nx2);  pmos(y, w3, x[0]);

  pulldown(y);
endmodule

module mdnf_primitives (input [3:0] x, output z);

wire nx3, nx2, nx0, y1, y2, y3;

not (nx3, x[3]);
not (nx2, x[2]);
not (nx0, x[0]);

and (y1, nx3, nx2, nx0);
and (y2, x[3], nx2, x[0]);
and (y3, nx3, x[2], x[1]);
or  (z,  y2, y1, y3);

endmodule

module y_mdnf_assign(input [3:0] x, output z);

assign z = (x[3] & ~x[2] & x[0])
         | (~x[3] & x[2] & x[1])
         | (~x[3] & ~x[2] & ~x[0]);

endmodule

module zhegalkin_primitives (input [3:0] x, output z);

wire y1, y2, y3, y4, nx0, nx1, nx2, nx3;

not(nx0, x[0]);
not(nx1, x[1]);
not(nx2, x[2]);
not(nx3, x[3]);

and(y1, x[0], x[2]);
and(y2, x[1], x[2]);
and(y3, x[2], x[3]);
and(y4, x[1], x[2], x[3]);

xor(z, 1'b1, x[0], x[2], x[3], y1, y2, y3, y4);

endmodule

module zhegalkin_assign(input [3:0] x, output y);
  assign y =  1'b1^ x[0] ^ x[2] ^ x[3] ^ (x[0] & x[2]) ^ 
             (x[2] & x[1]) ^ (x[3] & x[2]) ^ 
             (x[3] & x[2] & x[1]);
endmodule

module pierce (input [3:0] x, output z);

wire y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, nx0, nx1, nx2, nx3;

not(nx0, x[0]);
not(nx1, x[1]);
not(nx2, x[2]);
not(nx3, x[3]);

and(y1, nx3, nx2, nx1, x[0]);
and(y2, nx3, nx2, x[1], x[0]);
and(y3, nx3, x[2], nx1, nx0);
and(y4, x[3], nx2, nx1, nx0);
and(y5, x[3], nx2, x[1], nx0);
and(y6, x[3], x[2], nx1, nx0);
and(y7, x[3], x[2], nx1, x[0]);
and(y8, x[3], x[2], x[1], nx0);
and(y9, x[3], x[2], x[1], x[0]);
and(y10, nx3, x[2], nx1, x[0]);

nor(z, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10);

endmodule

module sheffer (input [3:0] x, output z);

wire y1, y2, y3, y4, y5, y6, nx0, nx1, nx2, nx3;

not (nx0, x[0]);
not (nx1, x[1]);
not (nx2, x[2]);
not (nx3, x[3]);

or (y1, x[3], x[2], x[1], x[0]);
or (y2, x[3], x[2], nx1, x[0]);
or (y3, x[3],nx2, nx1, x[0]);
or (y4, x[3], nx2, nx1, nx0);
or (y5, nx3, x[2], x[1], nx0);
or (y6, nx3, x[2], nx1, nx0);

nand (z, y1, y2, y3, y4, y5, y6);

endmodule

primitive tabl(y, x3, x2, x1, x0);
  output y;
  input  x3, x2, x1, x0;

  table
    0 0 0 0 : 1;
    0 0 0 1 : 0;
    0 0 1 0 : 1;
    0 0 1 1 : 0;
    0 1 0 0 : 0;
    0 1 0 1 : 0;
    0 1 1 0 : 1;
    0 1 1 1 : 1;
    1 0 0 0 : 0;
    1 0 0 1 : 1;
    1 0 1 0 : 0;
    1 0 1 1 : 1;
    1 1 0 0 : 0;
    1 1 0 1 : 0;
    1 1 1 0 : 0;
    1 1 1 1 : 0;
  endtable
endprimitive

module udp_module(input [3:0] x, output y);
  tabl udp_inst(y, x[3], x[2], x[1], x[0]);
endmodule

module udp_with_buffer(input [3:0] x, input z, output y);
  wire w;
  tabl udp_inst(w, x[3], x[2], x[1], x[0]);
  bufif1 b(y, w, z);
endmodule

module comprehensive_test;

  reg [3:0] x = 0;
  reg z = 0;
  wire y_mdnt_trans, y_rom, y_mdnf_prim, y_mdnf_assign;
  wire y_zheg_prim, y_zheg_assign, y_pierce, y_sheffer;
  wire y_udp, y_udp_buf;
  
  mdnt_transistors        m1(x, y_mdnt_trans);
  rom_based               m2(x, y_rom);
  mdnf_primitives         m3(x, y_mdnf_prim);
  y_mdnf_assign             m4(x, y_mdnf_assign);
  zhegalkin_primitives    m5(x, y_zheg_prim);
  zhegalkin_assign        m6(x, y_zheg_assign);
  pierce                  m7(x, y_pierce);
  sheffer                 m8(x, y_sheffer);
  udp_module              m9(x, y_udp);
  udp_with_buffer         m10(x, z, y_udp_buf);

  initial begin
    $display("==================================================================================================");
    $display("| i | x3 x2 x1 x0|MDNT_TR|  ROM  | MDNF_P| MDNF_A| ZHEG_P| ZHEG_A| PIERCE| SHEFF |  UDP  |UDP_BUF|");
    $display("==================================================================================================");
    
    for (integer i = 0; i <= 15; i++) begin
      x = i;
      #1;
      $display("|%2d | %b  %b  %b  %b |   %b   |   %b   |   %b   |   %b   |   %b   |   %b   |   %b   |   %b   |   %b   |   %b   |", 
               i, x[3], x[2], x[1], x[0],
               y_mdnt_trans, y_rom, y_mdnf_prim, y_mdnf_assign,
               y_zheg_prim, y_zheg_assign, y_pierce, y_sheffer,
               y_udp, y_udp_buf);
    end
    $display("==================================================================================================");
  end  
endmodule
