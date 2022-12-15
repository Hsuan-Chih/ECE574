// the first covergroup has '3' coverpoints:
// 1. the present state of the controller FSM
// 2. the next state of the controller FSM
// 3. a cross between the first two

// TEST = 2'h0, SWAP = 2'h1, SUBT = 2'h2, DONE = 2'h3

covergroup cg1 @(posedge tb.clk);
  // present state
  cp_ps: coverpoint tb.gcd_0.gcd_ctrl_0.ps {
    bins test = {0};
    bins swap = {1};
    bins subt = {2};
    bins done = {3};
  }
  // next state
  cp_ns: coverpoint tb.gcd_0.gcd_ctrl_0.ns {
    bins test = {0};
    bins swap = {1};
    bins subt = {2};
    bins done = {3};
  }
  // cross between the first two
  // all missing bins: bin <subt,done>, bin <subt,subt>, bin <subt,swap>
  //bin <swap,done>, bin <swap,test>, bin <swap,swap>
  //bin <done,swap>, bin <done,subt>
  //bin <test,test>
  
  // set them to be illegal
  cp_psXns: cross cp_ps, cp_ns {
    illegal_bins ill_subt = binsof(cp_ps.subt) && (binsof(cp_ns.subt) || binsof(cp_ns.swap));
    illegal_bins ill_swap = binsof(cp_ps.swap) && (binsof(cp_ns.test) || binsof(cp_ns.swap));
    illegal_bins ill_done = binsof(cp_ps.done) && (binsof(cp_ns.swap) || binsof(cp_ns.subt));
    illegal_bins ill_test = binsof(cp_ps.test) && binsof(cp_ns.test);
    
    //if reset_n deassert, these transition are valid; therefore, set "ignore_bins"
    ignore_bins valid_subtXdone = binsof(cp_ps.subt) && binsof(cp_ns.done);
    ignore_bins valid_swapXdone = binsof(cp_ps.swap) && binsof(cp_ns.done);
    }
endgroup: cg1

// the second covergroup has '1' coverpoint and monitors output port of GCD module
// which has '4' bins: range (0:500) (1000:2000) (7000:8000) (only 5000)

covergroup cg2 @(posedge tb.clk);
  cp_GCD_port: coverpoint tb.gcd_0.result {
    bins range_0_500    = {[0:500]}; 
    bins range_1000_2000  = {[1000:2000]};
    bins range_7000_8000  = {[7000:8000]};
    bins range_5000     = {5000}; // missing bin
  }
endgroup: cg2

// the third covergroup has '1' coverpoint and monitors ps 
// which has '1' illegal transition bin (IDEL/DONE => SWAP)

covergroup cg3 @(posedge tb.clk);
  cp_illtrans: coverpoint tb.gcd_0.gcd_ctrl_0.ps {
    illegal_bins trans = (3 => 1); 
  }
endgroup: cg3

// the fourth covergroup declares a sequence:
// reset_n is assert, followed by start at most 2cc later,
// and followed by done at most 100cc later

covergroup cg4 @(posedge tb.clk);
  cp_sequence: coverpoint tb.gcd_0.gcd_ctrl_0.ps iff (tb.reset_n) {
    bins seq = (3[*1:2] => 0[->1:100] => 3); // 3... => 0 ...0 => 3
  }
endgroup: cg4

