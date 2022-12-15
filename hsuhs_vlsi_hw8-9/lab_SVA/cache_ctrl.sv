//`include "enums.sv"
//`include "property.sv"

module cache_ctrl(
  // address from which the data is to be read
  input logic [7:0] address,
  // input instructing a read from the cache
  input logic read,
  // input that tells the ctrl whether the data is in cache (1) , memory (2) .
  // if no read is in progress, value is 0
  input logic[1:0] hit_or_miss,
  input bit clk,
  // active high asynchronous reset
  input logic rst,
  // ctrl instructs to read from memory
  output logic read_memory,
  // ctrl instructs to read from cache
  output logic read_cache,
  // an information signal that tells the chip it is checking the cache
  output logic check_cache
);
  
  enum logic[3:0] {
    IDLE = 0,
    CHECK_CACHE = 1,
    READ_MEM = 2,
    HIT = 3,
    MISS = 4,
    READ_CACHE = 5
  } ps,ns;

  
  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      ps <= IDLE; 
    end else
      ps <= ns;
  end
  
  always_comb begin
    case (ps)
      IDLE: begin
        ns = read? CHECK_CACHE:IDLE;
        check_cache = 1;
        read_memory = 0;
        read_cache = 0;
      end
      CHECK_CACHE: begin
        check_cache = 0;
        if (hit_or_miss == 0) ns = CHECK_CACHE;
        else if (hit_or_miss == 1) ns = HIT;
        else ns = MISS;
      end
      HIT: begin
        read_cache = 1;
        ns = READ_CACHE;
      end
      MISS: begin
        read_memory = 1;
        ns = READ_MEM;
      end
      READ_CACHE: begin
        ns = IDLE;
        read_cache = 0;
      end
      READ_MEM: begin
        ns = IDLE;
        read_memory = 0;
      end
      
    endcase
    
  end
    
endmodule
