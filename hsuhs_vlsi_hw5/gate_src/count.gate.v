/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP2
// Date      : Thu May 12 21:43:09 2022
/////////////////////////////////////////////////////////////


module count_W8 ( a_in, sel, clk, start, rst, done, cntout );
  input [7:0] a_in;
  input [1:0] sel;
  output [7:0] cntout;
  input clk, start, rst;
  output done;
  wire   \count_ns[0] , stopToCount, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, \r91/B[0] , n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n155, n156;

  DFFARX1 \count_ps_reg[1]  ( .D(done), .CLK(clk), .RSTB(n155), .QN(n136) );
  DFFARX1 \count_ps_reg[0]  ( .D(\count_ns[0] ), .CLK(clk), .RSTB(n155), .QN(
        n137) );
  DFFX1 \a_reg_reg[0]  ( .D(n54), .CLK(clk), .Q(n69) );
  DFFX1 \a_reg_reg[1]  ( .D(n53), .CLK(clk), .Q(n57) );
  DFFX1 \a_reg_reg[2]  ( .D(n52), .CLK(clk), .Q(n55) );
  DFFX1 \a_reg_reg[3]  ( .D(n51), .CLK(clk), .Q(n72), .QN(n132) );
  DFFX1 \a_reg_reg[4]  ( .D(n50), .CLK(clk), .Q(n59), .QN(n133) );
  DFFX1 \a_reg_reg[5]  ( .D(n49), .CLK(clk), .Q(n71), .QN(n134) );
  DFFX1 \a_reg_reg[6]  ( .D(n48), .CLK(clk), .Q(n56), .QN(n135) );
  DFFX1 \a_reg_reg[7]  ( .D(n47), .CLK(clk), .Q(n62) );
  DFFX1 \a_reg_reg[8]  ( .D(n46), .CLK(clk), .Q(n74), .QN(\r91/B[0] ) );
  DFFX1 \countOne_reg[0]  ( .D(n37), .CLK(clk), .Q(n60), .QN(n138) );
  DFFX1 \countOne_reg[1]  ( .D(n36), .CLK(clk), .Q(n75), .QN(n139) );
  DFFX1 \countOne_reg[2]  ( .D(n35), .CLK(clk), .Q(n76), .QN(n140) );
  DFFX1 \countOne_reg[3]  ( .D(n34), .CLK(clk), .Q(n78), .QN(n141) );
  DFFX1 \countOne_reg[4]  ( .D(n33), .CLK(clk), .Q(n58), .QN(n142) );
  DFFX1 \countOne_reg[5]  ( .D(n32), .CLK(clk), .Q(n73), .QN(n143) );
  DFFX1 \countOne_reg[6]  ( .D(n31), .CLK(clk), .Q(n77), .QN(n144) );
  DFFX1 \countOne_reg[7]  ( .D(n30), .CLK(clk), .Q(n79), .QN(n145) );
  DFFX1 \countZero_reg[0]  ( .D(n45), .CLK(clk), .Q(n70), .QN(n146) );
  DFFX1 \countZero_reg[1]  ( .D(n44), .CLK(clk), .Q(n63), .QN(n147) );
  DFFX1 \countZero_reg[2]  ( .D(n43), .CLK(clk), .Q(n64), .QN(n148) );
  DFFX1 \countZero_reg[3]  ( .D(n42), .CLK(clk), .Q(n66), .QN(n149) );
  DFFX1 \countZero_reg[4]  ( .D(n41), .CLK(clk), .Q(n68), .QN(n150) );
  DFFX1 \countZero_reg[5]  ( .D(n40), .CLK(clk), .Q(n61), .QN(n151) );
  DFFX1 \countZero_reg[6]  ( .D(n39), .CLK(clk), .Q(n65), .QN(n152) );
  DFFX1 \countZero_reg[7]  ( .D(n38), .CLK(clk), .Q(n67), .QN(n153) );
  DFFSSRX1 stopToCount_reg ( .SETB(n154), .RSTB(n156), .D(1'b0), .CLK(clk), 
        .Q(stopToCount), .QN(n80) );
  NOR4X0 U60 ( .IN1(n81), .IN2(n69), .IN3(n57), .IN4(n55), .QN(n156) );
  NAND4X0 U61 ( .IN1(n132), .IN2(n133), .IN3(n134), .IN4(n135), .QN(n81) );
  AO21X1 U62 ( .IN1(n82), .IN2(n69), .IN3(n83), .Q(n54) );
  AO222X1 U63 ( .IN1(n82), .IN2(n57), .IN3(a_in[0]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n69), .Q(n53) );
  AO222X1 U64 ( .IN1(n82), .IN2(n55), .IN3(a_in[1]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n57), .Q(n52) );
  AO222X1 U65 ( .IN1(n82), .IN2(n72), .IN3(a_in[2]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n55), .Q(n51) );
  AO222X1 U66 ( .IN1(n82), .IN2(n59), .IN3(a_in[3]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n72), .Q(n50) );
  AO222X1 U67 ( .IN1(n82), .IN2(n71), .IN3(a_in[4]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n59), .Q(n49) );
  AO222X1 U68 ( .IN1(n82), .IN2(n56), .IN3(a_in[5]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n71), .Q(n48) );
  AO222X1 U69 ( .IN1(n82), .IN2(n62), .IN3(a_in[6]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n56), .Q(n47) );
  AO222X1 U70 ( .IN1(n82), .IN2(n74), .IN3(a_in[7]), .IN4(n83), .IN5(
        \count_ns[0] ), .IN6(n62), .Q(n46) );
  NOR2X0 U71 ( .IN1(\count_ns[0] ), .IN2(n82), .QN(n83) );
  AOI21X1 U72 ( .IN1(n136), .IN2(n137), .IN3(\count_ns[0] ), .QN(n82) );
  MUX21X1 U73 ( .IN1(n84), .IN2(n85), .S(n146), .Q(n45) );
  MUX21X1 U74 ( .IN1(n86), .IN2(n87), .S(n147), .Q(n44) );
  NOR2X0 U75 ( .IN1(n146), .IN2(n88), .QN(n87) );
  AO21X1 U76 ( .IN1(n146), .IN2(n85), .IN3(n84), .Q(n86) );
  MUX21X1 U77 ( .IN1(n89), .IN2(n90), .S(n148), .Q(n43) );
  NOR2X0 U78 ( .IN1(n88), .IN2(n91), .QN(n90) );
  MUX21X1 U79 ( .IN1(n92), .IN2(n93), .S(n149), .Q(n42) );
  NOR3X0 U80 ( .IN1(n88), .IN2(n148), .IN3(n91), .QN(n93) );
  AO21X1 U81 ( .IN1(n148), .IN2(n85), .IN3(n89), .Q(n92) );
  AO21X1 U82 ( .IN1(n85), .IN2(n91), .IN3(n84), .Q(n89) );
  MUX21X1 U83 ( .IN1(n94), .IN2(n95), .S(n150), .Q(n41) );
  NOR2X0 U84 ( .IN1(n88), .IN2(n96), .QN(n95) );
  MUX21X1 U85 ( .IN1(n97), .IN2(n98), .S(n151), .Q(n40) );
  AND3X1 U86 ( .IN1(n85), .IN2(n68), .IN3(n99), .Q(n98) );
  AO21X1 U87 ( .IN1(n150), .IN2(n85), .IN3(n94), .Q(n97) );
  AO21X1 U88 ( .IN1(n85), .IN2(n96), .IN3(n84), .Q(n94) );
  INVX0 U89 ( .IN(n99), .QN(n96) );
  MUX21X1 U90 ( .IN1(n100), .IN2(n101), .S(n152), .Q(n39) );
  NOR2X0 U91 ( .IN1(n88), .IN2(n102), .QN(n101) );
  MUX21X1 U92 ( .IN1(n103), .IN2(n104), .S(n153), .Q(n38) );
  NOR3X0 U93 ( .IN1(n88), .IN2(n152), .IN3(n102), .QN(n104) );
  AO21X1 U94 ( .IN1(n152), .IN2(n85), .IN3(n100), .Q(n103) );
  AO21X1 U95 ( .IN1(n85), .IN2(n102), .IN3(n84), .Q(n100) );
  INVX0 U96 ( .IN(n105), .QN(n84) );
  NAND3X0 U97 ( .IN1(n61), .IN2(n68), .IN3(n99), .QN(n102) );
  NOR3X0 U98 ( .IN1(n149), .IN2(n148), .IN3(n91), .QN(n99) );
  NAND2X0 U99 ( .IN1(n63), .IN2(n70), .QN(n91) );
  INVX0 U100 ( .IN(n88), .QN(n85) );
  NAND2X0 U101 ( .IN1(n106), .IN2(n105), .QN(n88) );
  NAND2X0 U102 ( .IN1(n106), .IN2(n74), .QN(n105) );
  MUX21X1 U103 ( .IN1(n107), .IN2(n108), .S(n138), .Q(n37) );
  MUX21X1 U104 ( .IN1(n109), .IN2(n110), .S(n139), .Q(n36) );
  NOR2X0 U105 ( .IN1(n138), .IN2(n111), .QN(n110) );
  AO21X1 U106 ( .IN1(n138), .IN2(n108), .IN3(n107), .Q(n109) );
  MUX21X1 U107 ( .IN1(n112), .IN2(n113), .S(n140), .Q(n35) );
  NOR2X0 U108 ( .IN1(n111), .IN2(n114), .QN(n113) );
  MUX21X1 U109 ( .IN1(n115), .IN2(n116), .S(n141), .Q(n34) );
  NOR3X0 U110 ( .IN1(n111), .IN2(n140), .IN3(n114), .QN(n116) );
  AO21X1 U111 ( .IN1(n140), .IN2(n108), .IN3(n112), .Q(n115) );
  AO21X1 U112 ( .IN1(n108), .IN2(n114), .IN3(n107), .Q(n112) );
  MUX21X1 U113 ( .IN1(n117), .IN2(n118), .S(n142), .Q(n33) );
  NOR2X0 U114 ( .IN1(n111), .IN2(n119), .QN(n118) );
  MUX21X1 U115 ( .IN1(n120), .IN2(n121), .S(n143), .Q(n32) );
  AND3X1 U116 ( .IN1(n108), .IN2(n58), .IN3(n122), .Q(n121) );
  AO21X1 U117 ( .IN1(n142), .IN2(n108), .IN3(n117), .Q(n120) );
  AO21X1 U118 ( .IN1(n108), .IN2(n119), .IN3(n107), .Q(n117) );
  INVX0 U119 ( .IN(n122), .QN(n119) );
  MUX21X1 U120 ( .IN1(n123), .IN2(n124), .S(n144), .Q(n31) );
  NOR2X0 U121 ( .IN1(n111), .IN2(n125), .QN(n124) );
  MUX21X1 U122 ( .IN1(n126), .IN2(n127), .S(n145), .Q(n30) );
  NOR3X0 U123 ( .IN1(n111), .IN2(n144), .IN3(n125), .QN(n127) );
  AO21X1 U124 ( .IN1(n144), .IN2(n108), .IN3(n123), .Q(n126) );
  AO21X1 U125 ( .IN1(n108), .IN2(n125), .IN3(n107), .Q(n123) );
  INVX0 U126 ( .IN(n128), .QN(n107) );
  NAND3X0 U127 ( .IN1(n73), .IN2(n58), .IN3(n122), .QN(n125) );
  NOR3X0 U128 ( .IN1(n141), .IN2(n140), .IN3(n114), .QN(n122) );
  NAND2X0 U129 ( .IN1(n75), .IN2(n60), .QN(n114) );
  INVX0 U130 ( .IN(n111), .QN(n108) );
  NAND2X0 U131 ( .IN1(n106), .IN2(n128), .QN(n111) );
  NAND2X0 U132 ( .IN1(\r91/B[0] ), .IN2(n106), .QN(n128) );
  NOR2X0 U133 ( .IN1(n154), .IN2(rst), .QN(n106) );
  INVX0 U134 ( .IN(n154), .QN(\count_ns[0] ) );
  MUX21X1 U135 ( .IN1(stopToCount), .IN2(n129), .S(n137), .Q(n154) );
  NAND2X0 U136 ( .IN1(start), .IN2(n136), .QN(n129) );
  AO22X1 U137 ( .IN1(n130), .IN2(n79), .IN3(n131), .IN4(n67), .Q(cntout[7]) );
  AO22X1 U138 ( .IN1(n130), .IN2(n77), .IN3(n131), .IN4(n65), .Q(cntout[6]) );
  AO22X1 U139 ( .IN1(n130), .IN2(n73), .IN3(n131), .IN4(n61), .Q(cntout[5]) );
  AO22X1 U140 ( .IN1(n130), .IN2(n58), .IN3(n131), .IN4(n68), .Q(cntout[4]) );
  AO22X1 U141 ( .IN1(n130), .IN2(n78), .IN3(n131), .IN4(n66), .Q(cntout[3]) );
  AO22X1 U142 ( .IN1(n130), .IN2(n76), .IN3(n131), .IN4(n64), .Q(cntout[2]) );
  AO22X1 U143 ( .IN1(n130), .IN2(n75), .IN3(n131), .IN4(n63), .Q(cntout[1]) );
  AO22X1 U144 ( .IN1(n130), .IN2(n60), .IN3(n131), .IN4(n70), .Q(cntout[0]) );
  AND3X1 U145 ( .IN1(done), .IN2(n155), .IN3(sel[0]), .Q(n131) );
  AND3X1 U146 ( .IN1(done), .IN2(n155), .IN3(sel[1]), .Q(n130) );
  INVX0 U147 ( .IN(rst), .QN(n155) );
  NOR2X0 U148 ( .IN1(n80), .IN2(n137), .QN(done) );
endmodule

