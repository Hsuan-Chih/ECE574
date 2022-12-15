// Code your testbench here
`timescale 1ns/1ns

module tb_count();

parameter W = 8;

reg [W-1:0] a_in;
reg [1:0] sel;
reg clk;
reg start;
reg rst;
wire done;
wire [W-1:0] cntout;  


count_W8 COUNT(.*);


initial begin

  // start from IDLE
  clk = 1;
  rst = 1;
  start = 0;

  # 14 rst = 0;

  /////////////////////
  //correct cntout: 3//
  /////////////////////
  
  # 6 a_in = 8'b0000_1011; // count this
  start = 1;
  sel = 2'b10; // count 1
  # 10 start = 0;
  
  a_in = 8'b1111_1111; // this will not be counted
  # 100
  
  
  /////////////////////
  //correct cntout: 6//
  /////////////////////

  a_in = 8'b1101_1111; // this will not be counted

  # 10 a_in = 8'b0100_0010; // count this
  start = 1;
  
  // test that cntout will not be 'x'
  # 10 a_in = 8'bxxxx_xxxx; // this will not be counted
  sel = 2'b01; // count 0
  start = 0;
  
  # 40
  a_in = 8'b1010_x001; // this will be used in 'next' block
  # 80
  
  /////////////////////
  //correct cntout: x//
  /////////////////////
  
  // a_in is 8'b1010_x001 here!!
  start = 1;
  # 10 start = 0;
  # 30 sel = 2'b10; // count 1, but x is one of the bit
  # 70
    
  # 30 $dumpflush;
  $stop;


end

initial begin
$dumpfile("test.vcd");
$dumpvars(1, tb_count);

end

// one clock cycle is 10ns
always
  #5 clk = ~clk;

endmodule