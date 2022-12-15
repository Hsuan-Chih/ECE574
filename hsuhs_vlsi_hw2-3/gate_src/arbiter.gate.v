/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP2
// Date      : Mon Apr 25 19:46:15 2022
/////////////////////////////////////////////////////////////


module arbiter ( gnt, timeout, clk, rst_n, dly, done, req, reset );
  input clk, rst_n, dly, done, req, reset;
  output gnt, timeout;
  wire   N16, N17, N18, N19, N20, n3, n5, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49;
  wire   [2:0] arbiter_ns;

  DFFX1 \count_reg[0]  ( .D(N16), .CLK(clk), .QN(n47) );
  DFFARX1 \arbiter_ps_reg[1]  ( .D(arbiter_ns[1]), .CLK(clk), .RSTB(rst_n), 
        .Q(n19), .QN(n45) );
  DFFARX1 \arbiter_ps_reg[0]  ( .D(arbiter_ns[0]), .CLK(clk), .RSTB(rst_n), 
        .Q(n18), .QN(n3) );
  DFFX1 \count_reg[1]  ( .D(N17), .CLK(clk), .Q(n20), .QN(n5) );
  DFFX1 \count_reg[2]  ( .D(N18), .CLK(clk), .QN(n48) );
  DFFX1 \count_reg[3]  ( .D(N19), .CLK(clk), .Q(n17), .QN(n49) );
  DFFX1 \count_reg[4]  ( .D(N20), .CLK(clk), .QN(n46) );
  DFFARX1 \arbiter_ps_reg[2]  ( .D(arbiter_ns[2]), .CLK(clk), .RSTB(rst_n), 
        .Q(timeout), .QN(n21) );
  AO21X1 U26 ( .IN1(n3), .IN2(n19), .IN3(n22), .Q(gnt) );
  INVX0 U27 ( .IN(n23), .QN(arbiter_ns[2]) );
  NOR2X0 U28 ( .IN1(n24), .IN2(n25), .QN(N20) );
  XNOR2X1 U29 ( .IN1(n46), .IN2(n26), .Q(n25) );
  NAND2X0 U30 ( .IN1(n27), .IN2(n17), .QN(n26) );
  NOR2X0 U31 ( .IN1(n24), .IN2(n28), .QN(N19) );
  XOR2X1 U32 ( .IN1(n49), .IN2(n27), .Q(n28) );
  NOR3X0 U33 ( .IN1(n48), .IN2(n47), .IN3(n5), .QN(n27) );
  MUX21X1 U34 ( .IN1(n29), .IN2(n30), .S(n48), .Q(N18) );
  NOR3X0 U35 ( .IN1(n24), .IN2(n47), .IN3(n5), .QN(n30) );
  AO21X1 U36 ( .IN1(n5), .IN2(n31), .IN3(N16), .Q(n29) );
  MUX21X1 U37 ( .IN1(N16), .IN2(n32), .S(n5), .Q(N17) );
  NOR2X0 U38 ( .IN1(n47), .IN2(n24), .QN(n32) );
  AND2X1 U39 ( .IN1(n31), .IN2(n47), .Q(N16) );
  INVX0 U40 ( .IN(n24), .QN(n31) );
  NAND3X0 U41 ( .IN1(n33), .IN2(n23), .IN3(arbiter_ns[0]), .QN(n24) );
  AO222X1 U42 ( .IN1(n34), .IN2(req), .IN3(n35), .IN4(n22), .IN5(n36), .IN6(
        n37), .Q(arbiter_ns[0]) );
  OA21X1 U43 ( .IN1(n38), .IN2(n37), .IN3(n39), .Q(n35) );
  INVX0 U44 ( .IN(dly), .QN(n37) );
  INVX0 U45 ( .IN(done), .QN(n38) );
  MUX21X1 U46 ( .IN1(n18), .IN2(n40), .S(n45), .Q(n34) );
  NOR2X0 U47 ( .IN1(timeout), .IN2(n18), .QN(n40) );
  OA22X1 U48 ( .IN1(n21), .IN2(reset), .IN3(n41), .IN4(n39), .Q(n23) );
  INVX0 U49 ( .IN(arbiter_ns[1]), .QN(n33) );
  NAND2X0 U50 ( .IN1(n42), .IN2(n43), .QN(arbiter_ns[1]) );
  NAND3X0 U51 ( .IN1(n22), .IN2(n39), .IN3(done), .QN(n43) );
  NAND4X0 U52 ( .IN1(n47), .IN2(n20), .IN3(n44), .IN4(n17), .QN(n39) );
  NOR2X0 U53 ( .IN1(n46), .IN2(n48), .QN(n44) );
  INVX0 U54 ( .IN(n41), .QN(n22) );
  NAND2X0 U55 ( .IN1(n45), .IN2(n18), .QN(n41) );
  INVX0 U56 ( .IN(n36), .QN(n42) );
  AO22X1 U57 ( .IN1(reset), .IN2(timeout), .IN3(n3), .IN4(n19), .Q(n36) );
endmodule

