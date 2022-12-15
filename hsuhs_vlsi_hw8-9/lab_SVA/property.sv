// s_check: at every posedge of the clock, state CHECK_CACHE is followed by HIT one clock cycle later
  sequence s_check;
    @(posedge tb.clk) (tb.iDUT.ps == CHECK_CACHE) ##1 (tb.iDUT.ps == HIT);
  endsequence
  
// s_read_when_miss: read_memory is only raised in MISS state
  sequence s_read_when_miss;
    @(posedge tb.clk) $rose(tb.read_memory) && (tb.iDUT.ps == MISS);
  endsequence
  
// p_check_impl: at every posedge of the clock, if current state is CHECK_CACHE, then it is followed by either HIT or MISS one to two clock cycles later
  property p_check_impl;
    @(posedge tb.clk) 
    (tb.iDUT.ps == CHECK_CACHE) |-> ##[1:2] (tb.iDUT.ps == HIT || tb.iDUT.ps == MISS);
  endproperty
// This is to be defined as a property, using property...endproperty, not sequence...endsequence

// s_read_mem: every time current state is READ_MEM then read_memory is also asserted  
  sequence s_read_mem;
    @(posedge tb.clk) (tb.iDUT.ps == READ_MEM) ##0 (tb.read_memory == 1);
  endsequence

/*
// make sure the ps is MISS, then check if read_memory is only raised there
  property s_read_miss;
    @(posedge tb.clk) (tb.iDUT.ps == MISS) |-> s_read_when_miss;
    //@(posedge tb.clk) s_read_when_miss |-> (tb.iDUT.ps == MISS);
  endproperty
  */