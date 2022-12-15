// Code your testbench here
`timescale 1ns/1ns

module tb_controller();


logic [2:0] req;
logic [2:0] done;
logic clk, rst;  // Input signals to the DUT.

logic [1:0] mstate;
logic [1:0] accmodule;
  
string S1 = "Scenario 1";
string S2 = "Scenario 2";
string S3 = "Scenario 3";

controller iDUT(.req(req), .done(done), .reset(rst), .clk(clk), .mstate(mstate), .accmodule(accmodule));


initial begin

clk = 0;
rst = 1;
req = 3'b000;
done = 3'b000;

# 14 rst = 0;

//////////////////////////////////////////////////
// Scenario 1: M2 requests, 1 clk cycle later; 
// M1 requests, 1 clk cycle later that M1 is done.
//////////////////////////////////////////////////
  
  $display ("Time: %0t, %s starts ... ", $realtime, S1);
  
  //M2 requests
# 2 req = 3'b010;
  
  //M1 requests and "interupts" M2 after 1 cycle
# 10 req = 3'b001;
# 10 req = 3'b000;

  //M1 only accesses the memory for "1" cycle
# 5 done = 3'b001;
# 5 done = 3'b000;

  $display ("Time: %0t, %s ends ... ", $realtime, S1);

//////////////////////////////////////////////////  
// Scenario 2: M3 requests, 1 clk cycle later; 
// M2 tries to interupt but fail.
//////////////////////////////////////////////////
  $display ("Time: %0t, %s starts ... ", $realtime, S2);
  
  // M3 requests
# 30 req = 3'b100;

  // M2 requests, but "fails" to interupts M3
# 10 req = 3'b010;
# 10 req = 3'b000;
  $display ("Time: %0t, %s ends ... ", $realtime, S2);
  
//////////////////////////////////////////////////
// Scenario 3: M3 requests again, 1 clk cycle later, M3 is done.
// M2 and M3 both request, access given to M2.
//////////////////////////////////////////////////  
  $display ("Time: %0t, %s starts ... ", $realtime, S3);
  
  // M3 requests
# 30 req = 3'b100;

  // M2 requests, but "fails" to interupts M3
# 10 req = 3'b010;
  
  // M3 requests, but it won't be in the memory in the next cycle
  // because M3 can only be in the memory for at most 2 cycle.
  // Therefore, this M3 request is "invalid"
  // and will be back to "IDLE"
# 10 req = 3'b100;
# 10 req = 3'b000;


  // later on, M2 and M3 request at the same time
  // M2 can access the memory because this is the first time they request simultaneously
# 10 req = 3'b110;
# 10 req = 3'b000;
  
  $display ("Time: %0t, %s ends ... ", $realtime, S3);

# 30 $dumpflush;
$stop;

end

  // show the wave form
initial begin
$dumpfile("test.vcd");
$dumpvars(1, tb_controller);

end

// one cycle = 10ns
always
  #5 clk = ~clk;

endmodule