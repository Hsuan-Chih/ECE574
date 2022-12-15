// Code your design here
module controller(
  input logic [2:0]   req,
  input logic [2:0]   done,
  input         reset,
  input         clk,
  output logic [1:0]  mstate,
  output logic [1:0]  accmodule
  );
  
  reg [1:0] count;  // at most 2 clock cycle in the memory
  logic [1:0] alt = 2'b10;  // initialize alternating fashion to M2
  logic interupt = 'b0;
  
  // define enumerated types and vectors for next state(controller_ns)
  enum logic [1:0]{
    IDLE = 2'b00,
    M1   = 2'b01,
    M2   = 2'b10,
    M3   = 2'b11
  } controller_ns;
  
  // infer the mstate vector flip-flops
  // asynchronous reset activates high
  always_ff @(posedge clk, posedge reset)
    if (reset) mstate <= IDLE;
    else     mstate <= controller_ns;
  
  // set up a counter
  // force the counter to start from '1' if needed
  always_ff @(posedge clk)
    case (controller_ns)
      M1: begin     
        if (interupt && req[0] == 1) count <= 'b1; // M1 interupts others
        else if (count == 'b1)     count <= count + 'b1;  
        else             count <= 'b0;
      end
      
      // M2 and M3 always need to activate the counter
      M2: begin
        if (req[1]) count <= 'b1;
        else      count <= count + 'b1;
      end
      
      M3: begin
        if (req[2]) count <= 'b1;
        else    count <= count + 'b1;
      end
      
      default:  count <= 'b0;
    endcase
  
  // set up a alternating fashion register
  // M2 and M3 request at the same time
  always_ff @(posedge clk)
    if (req == 3'b110) begin
      if (alt == M2) alt <= M3; // next time, M3 have the chance to access memory
      else       alt <= M2; // vice versa
    end
  
  always_comb begin
    interupt = 'b0; // default value
    unique case (mstate)
      IDLE: begin
        casez (req) 
          3'b??1:       controller_ns = M1; // M1 has the highest priority to access memory
          3'b010:       controller_ns = M2;
          3'b100:       controller_ns = M3;
          
          // M2 and M3 request at the same time
          3'b110: begin
            if (alt == M2)  controller_ns = M2;
            else      controller_ns = M3;
          end
          default:      controller_ns = IDLE;
        endcase        
      end
      
      M1: begin
        // M1 is done using the memory
        if (done[0]) begin
          unique case (req)
            3'b000:       controller_ns = IDLE; // back to IDLE if no other requests
            3'b010:       controller_ns = M2; // M2 requests
            3'b100:       controller_ns = M3; // M3 requests
            
            // M2 and M3 request at the same time
            3'b110: begin
              if (alt == M2)  controller_ns = M2;
              else        controller_ns = M3;
            end
          endcase          
        end 
        
        // M1 interupts others; therefore, it can be in the memory at most 2 cycles
        else if (count == 2) begin
          controller_ns = IDLE;
          //interupt = 0;
        end
        else          controller_ns = M1;
      end
      
      M2: begin
        if (done[1] && (req == 'b0)) controller_ns = IDLE; // no others request
        
        // M1 interupts
        else if (req[0]) begin
          controller_ns = M1;
          interupt = 1;
        end
        
        // at most 2 cycles in the memory 
        else if (count == 2) begin
          if (req[2])       controller_ns = M3; // go to M3 if it requests
          else          controller_ns = IDLE;
        end
        
        else          controller_ns = M2;
      end
      
      M3: begin
        if (done[2] && req == 'b0) controller_ns = IDLE; // no others request
        
        // M1 interupts
        else if (req[0]) begin
          controller_ns = M1;
          interupt = 1;
        end
        
        // at most 2 cycles in the memory
        else if (count == 2) begin
          if (req[1])     controller_ns = M2; // go to M2 if it requests
          else          controller_ns = IDLE;
        end
        
        else          controller_ns = M3;
      end
    
    endcase
  end
  
  // spec: accmodule will record which module is now accessing the memory
  always_ff @(posedge clk)
    unique case (controller_ns)
      IDLE: accmodule <= 2'b00;
      M1: accmodule <= M1;
      M2: accmodule <= M2;
      M3: accmodule <= M3;
    endcase

endmodule