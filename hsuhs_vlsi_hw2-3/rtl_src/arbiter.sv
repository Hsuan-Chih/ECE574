// Code your design here
module arbiter(
	output logic 	gnt,
	output logic 	timeout,
	input 		clk, 	//clock input
	input 		rst_n,	//asynchronous active low request
	input 		dly,	//delay input
	input		done, 	//done input
	input		req,	//request input
	input		reset 	//used in TIMEOUT state
	);

	reg [4:0] 	count; 	// counter is at most 30 clock cycle

	// define enumerated types and vectors for present state(ps), next state(ns)
	enum logic [2:0]{
		IDLE  	= 3'b000,
		BBUSY 	= 3'b001,
		BWAIT 	= 3'b010,
		BFREE 	= 3'b011,
		TIMEOUT = 3'b100
	} 	arbiter_ps, arbiter_ns;

	// infer the present state vector flip-flops
	always_ff @(posedge clk, negedge rst_n)
		if (!rst_n)	arbiter_ps <= IDLE;
		else		arbiter_ps <= arbiter_ns;

	// set up a counter
	always_ff @(posedge clk)
		case (arbiter_ns)
			BBUSY:		count <= count + 5'b1;	// activate the counter only in BUSY state
			default:	count <= 5'b0;		// reset the counter to 0 in other states
		endcase
	// determine the Next State, triggered by listed sensitivity lists
	// sensitivity list: arbiter_ps, req, reset, count, done, dly
	always_comb begin
		gnt 	= 1'b0;	//default output signal
		timeout = 1'b0;	//default timeout signal
		unique case (arbiter_ps)
			IDLE: begin
				if (req)		arbiter_ns = BBUSY;	// go to BUSY if request 
				else			arbiter_ns = IDLE;	// otherwise, stay!
			end

			BBUSY: begin
				gnt = 1'b1;
              			if (count == 30)	arbiter_ns = TIMEOUT;	// go to TIMEOUT if count is up to 30; otherwise, ...
				else if (!done)		arbiter_ns = BBUSY;	// stay in BUSY if not done
				else if (dly)		arbiter_ns = BWAIT;	// go to WAIT if delay
				else			arbiter_ns = BFREE;	// go to FREE if not delay
			end

			// enter TIMEOUT at the 31st cycle
			TIMEOUT: begin
				timeout = 1'b1;
              			if (!reset)		arbiter_ns = TIMEOUT;	// stay in TIMEOUT if reset is not asserted; otherwise, ...
             			else if (!dly)		arbiter_ns = BFREE;	// go to FREE if not delay
              			else			arbiter_ns = BWAIT;	// go to WAIT if delay
			end

			BWAIT: begin
				gnt = 1'b1;
				if (!dly)		arbiter_ns = BFREE;	// go to FREE if not delay
				else			arbiter_ns = BWAIT;	// otherwise, stay!
			end

			BFREE: begin
				if (req)		arbiter_ns = BBUSY;	// go to BUSY if request
				else			arbiter_ns = IDLE;	// otherwise, go back to IDLE
			end
		endcase

	end
endmodule