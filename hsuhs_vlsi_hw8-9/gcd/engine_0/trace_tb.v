`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  reg [31:0] PI_b_in;
  reg [0:0] PI_start;
  reg [31:0] PI_a_in;
  wire [0:0] PI_clk = clock;
  reg [0:0] PI_reset_n;
  reg [0:0] PI_clck;
  gcd UUT (
    .b_in(PI_b_in),
    .start(PI_start),
    .a_in(PI_a_in),
    .clk(PI_clk),
    .reset_n(PI_reset_n),
    .clck(PI_clck)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$auto$async2sync.cc:104:execute$104 = 1'b0;
    // UUT.$auto$async2sync.cc:104:execute$86 = 1'b0;
    // UUT.$auto$async2sync.cc:104:execute$90 = 32'b00000000000000000000000000000000;
    // UUT.$auto$async2sync.cc:148:execute$94 = 1'b1;
    // UUT.gcd_ctrl_0.$auto$async2sync.cc:104:execute$108 = 2'b00;
    UUT.result = 32'b10000000000000000000000000000000;

    // state 0
    PI_b_in = 32'b00000000000000000000000000000000;
    PI_start = 1'b0;
    PI_a_in = 32'b00000000000000000000000000000000;
    PI_reset_n = 1'b0;
    PI_clck = 1'b0;
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
