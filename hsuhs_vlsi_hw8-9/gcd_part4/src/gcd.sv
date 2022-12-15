module gcd(	input [31:0] a_in,          //operand a
			input [31:0] b_in,          //operand b
			input start,                //validates the input data
			input reset_n,              //reset
			input clk,                  //clock
			input clck,                 //slower clock  			
			output reg [31:0] result,  //output of GCD engine
			output reg done);          //validates output value

	logic			registers_equal		;
	logic			register_a_smaller	;
	logic			swap_registers		;
	logic			subtract_registers	;
	logic			done_flag			;
	logic			[31:0]	register_b	;
	logic 			register_b_equal	;


	`ifdef FORMAL
        always @(posedge clk) begin
          // $fell(reset_n) |-> (result == 0);
          // using boolean to express the upper sequential implication
          // fail: if reset_n is fell and result is not reset to 0
          cover property((!$fell(reset_n)) | (result == 0));
            
          // $rose(done_flag) |-> (done == 1);
          // using same boolean method to express this sequential implication
          // fail: if done_flag rose, done is not 1  
          cover property(!$rose(done_flag) | (done == 1));  
        end
            
            // using @(*) to represent that not only clk is the sensitivity list, but the condition is also the sensitivity list: reset_n
  			always @(*) begin
        	if (!reset_n) begin
              //assert that if reset_n is asserted, result should be '0'
              assert(result == 'b0); 
         	end
         	
           // if reg has following condition, should cover these expressions
         	if (registers_equal) cover(result == register_b);
         	if (register_a_smaller) cover(result < register_b);
  			end
  	`endif

	//register_b
	always_ff @(posedge clck, negedge reset_n) begin
		if (~reset_n)					register_b <= 0;
		else if (start)					register_b <= b_in;
		else if (swap_registers)		register_b <= result;
	end

	//result: add new sensitivity list: reset_n
	// because it is asynchronous reset
	always_ff @(posedge clk, negedge reset_n) begin
		if (~reset_n)	result <= 0; // if reset_n is asserted, result should be 0
		else begin 
			if (start) result <= a_in;
			else if (swap_registers)		result <= register_b;
			else if (subtract_registers)	result <= result - register_b;
		end
	end

	//done
	always_ff @(posedge clk, negedge reset_n) begin
		if (~reset_n)					done <= 0;
		else if (done_flag)				done <= 1;
		else							done <= 0;
	end

	assign registers_equal		= (result == register_b);
	assign register_a_smaller	= (result < register_b);
	assign register_b_equal 	= (register_b == b_in);

	gcd_ctrl gcd_ctrl_0(
		.start					,
		.reset_n				,
		.clk(clck)				,
		.registers_equal		,
		.register_a_smaller		,
		.swap_registers			,
		.subtract_registers		,
		.done_flag				);

endmodule
