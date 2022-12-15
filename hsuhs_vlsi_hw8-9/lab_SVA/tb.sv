`include "property.sv"
`include "enums.sv"

module tb;
  //input
  logic [7:0] address;
  logic read;
  logic[1:0] hit_or_miss;
  bit clk;
  logic rst;
  
  //output
  logic read_memory;
  logic read_cache;
  logic check_cache;  
  
  parameter CYCLE = 10;
  
  cache_ctrl iDUT(.*);
  
  
  // Declare the property
  ap_1: assert property(s_check)
    $display ("Assertion: s_check pass!");
    else $display ("Assertion: s_check fail!");
  cp_1: cover property(s_check)
    $display ("Cover: s_check pass!");
    
  ap_2: assert property(s_read_when_miss)
    $display ("Assertion: s_read_when_miss pass!");
    else $display ("Assertion: s_read_when_miss fail!");
  cp_2: cover property(s_read_when_miss)
    $display ("Cover: s_read_when_miss pass!");
        
  ap_3: assert property(p_check_impl)
    $display ("Assertion: p_check_impl pass!");
    else $display ("Assertion: p_check_impl fail!");
  cp_3: cover property(p_check_impl)
    $display ("Cover: p_check_impl pass!");
    
  ap_4: assert property(s_read_mem)
    $display ("Assertion: s_read_mem pass!");
    else $display ("Assertion: s_read_mem fail!");
  cp_4: cover property(s_read_mem)
    $display ("Cover: s_read_mem pass!");
  
  
  initial begin
    read = 0;
    rst = 1;
    address = 'b0;
    hit_or_miss = 'b0;
    $display("==========================================================");
    $display("Scenario 1 Starts ... ");
    $display("Trace: IDLE => CHECK_CACHE => HIT => READ_CACHE => IDLE");
    $display("==========================================================");
    
    #(CYCLE) rst = 0;
    
    #(CYCLE) read = 1; // ns = CHECK_CACHE
    
    #(CYCLE) read = 0;
    hit_or_miss = 1; // 1 cycle later, ns = HIT
    read = 0;
    
    #(CYCLE*2) hit_or_miss = 0; // 2 cycle later, back to IDLE
    
    $display("==========================================================");
    $display("Scenario 1 Ends ... ");
    $display("==========================================================");
    
    #(CYCLE)
    
    $display("==========================================================");
    $display("Scenario 2 Starts ... ");
    $display("Trace: IDLE => CHECK_CACHE*2 => MISS => READ_MEM => IDLE");
    $display("==========================================================");
    
    #(CYCLE) read = 1; // ns = CHECK_CACHE
    #(CYCLE) read = 0;
    #(CYCLE) hit_or_miss = 2; // 2 cycle later, ns = MISS
    
    #(CYCLE*2) hit_or_miss = 0; // 2 cycle later, back to IDLE
       
    $display("==========================================================");
    $display("Scenario 2 Ends ... ");
    $display("==========================================================");
    
    #(CYCLE)
    
    $display("==========================================================");
    $display("Scenario 3 Starts ... ");
    $display("Violate all assertions ...  ");
    $display("Trace: IDLE => CHECK_CACHE*4 => rst asserted => IDLE");
    $display("==========================================================");
    
    #(CYCLE) read = 1; // ns = CHECK_CACHE
    #(CYCLE) read = 0;
    hit_or_miss = 0; 
    #(CYCLE*3) // // stay in CHECK_CACHE for 4 clock cycles
    
    rst = 1; // ns will be back to IDLE
    #(CYCLE*2)
    rst = 0;
    
    #(CYCLE*2)
    
    $display("==========================================================");
    $display("Scenario 3 Ends ... ");
    $display("==========================================================");
    
    
    $dumpflush;    
    $stop;
  end
    
  // Display the output at every clock cycle
  initial begin
    #5
    $display("[%0t] check_cahce = %d, read_memory = %d, read_cache = %d", $time, check_cache, read_memory, read_cache);
    
    forever #(CYCLE) $display("[%0t] check_cahce = %d, read_memory = %d, read_cache = %d", $time, check_cache, read_memory, read_cache);
  end
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(1, tb);
  end
  
  //clock cycle generation
  initial begin
    clk = 0; 
    forever #(CYCLE/2) clk = ~clk;
  end
endmodule