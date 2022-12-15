// Code your design here
module count #(parameter W = 8) (
  input [W-1:0] a_in,
  input [1:0] sel,
  input clk,
  input start,
  input rst,
  output logic done,
  output logic [W-1:0] cntout
);
  
  // Define enumerated types and vectors for present state and next state
  enum logic [1:0] {
    IDLE = 2'b00,
    BUSY = 2'b01,
    DONE = 2'b10
  } count_ps, count_ns;
  
  logic [W-1:0] countZero; // Initialize
  logic [W-1:0] countOne; // Initialize
  
  logic [W-1:0] finCount0;
  logic [W-1:0] finCount1;
  
  // Infer the count_ps vector flip-flops
  // rst is asynchronous active high reset
  always_ff @(posedge clk, posedge rst) begin
    if (rst) count_ps <= IDLE;
    else     count_ps <= count_ns;
  end

  
  logic startToCount; // State Machine output (trigger)
  logic stopToCount; // stop to count and force the next state to be DONE
  logic [W:0] a_reg; // Store a_in value in temporary register [W:1]
  
  //////////////////
  // STATE MACHINE//
  //////////////////
  
  always_comb begin
    
    // ONLY 3 states: IDLE, BUSY, DONE
    unique case (count_ps)      
      IDLE: begin
        
        // start to count and tell a_reg to shift
        if (start) begin 
          count_ns = BUSY;
          {done, startToCount} = 2'b0_1;
        end
        
        else begin
          count_ns = IDLE;
          {done, startToCount} = 2'b0_0;
        end        
      end
      
      BUSY: begin
        
        // stop to count and the cntout will be available
        if (stopToCount) begin
          count_ns = DONE;
          {done, startToCount} = 2'b1_0; 
        end
        
        // keep counting and shifting
        else begin
          count_ns = BUSY;
          {done, startToCount} = 2'b0_0;
        end
      end
      
      // Next state will "always" be IDLE
      DONE: begin
        count_ns = IDLE;
        {done, startToCount} = 2'b0_0;
      end            
    endcase  
  end
  
  //////////////
  // DATA PATH//
  //////////////
  
  
  // Store a_in into the register if startToCount asserts
  // Set a_reg[0] = 1 and the rest of the bits is a_in 
  // Shift left if it is in the BUSY state and haven't done yet 
  always @(posedge clk) begin
    if (count_ps == IDLE) a_reg <= {a_in, 1'b1};
    if (count_ns == BUSY && !done) a_reg <= (a_reg << 1); 
  end
  

  
  // Count 0's and 1's
  always_ff @(posedge clk) begin
    if (rst) begin
      countZero <= 'b0;
      countOne <= 'b0;
    end
    
    // Counting function is only needed if next state is BUSY and not done yet
    else if (count_ns == BUSY && !done) begin       
      if (a_reg[W] == 1'b0) countZero <= countZero + 1'b1; //MSB = 0
      else if (a_reg[W] == 1'b1)   countOne <= countOne + 1'b1; // MSB = 1
      else begin
        // MSB detect 'x or z' and force result to be 'x'
        countZero <= countZero + 1'bx;
        countOne <= countOne + 1'bx;
      end
    end
    
    // reset the counter to '0' if present state is DONE
    else /*if (count_ps == IDLE)*/ {countOne, countZero} <= 'b0;
  end
  
  // Trigger the stopToCount signal
  always @(posedge clk) begin
    if (count_ns == BUSY) begin
      if (a_reg[W-2:0] == 'b0) stopToCount = 'b1; // to stop counting and telling FSM
    end  
    else stopToCount = 'b0; // still need to count and shift left
    
    
  end
  

  // Store the final value
  always_comb begin
    if (rst) begin
      finCount0 = 'b0;
      finCount1 = 'b0;
    end
    else if (count_ns == DONE) begin
      finCount0 = countZero;
      finCount1 = countOne;
    end    
    else begin
      finCount0 = 'b0; // reset to 0
      finCount1 = 'b0; // reset to 0
    end
    
  end
  
  // 1-hot encoding
  always_comb begin    
    if (count_ns == DONE) begin
      unique case (1'b1)
        
        // counting '0'
        sel[0]: begin
          cntout = finCount0;
        end
        
        // counting '1'
        sel[1]: begin
          cntout = finCount1;
        end
      endcase
    end
    
  else cntout = 'b0; // reset to 0
  end
  
endmodule