`timescale 1ns/1ns
`include "gcd_random.sv"
`include "covergroups.sv"

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;

parameter CYCLE = 100; 

reg clk, reset_n;
reg start, done;
reg [31:0] a_in, b_in; 
reg [31:0] result;


//clock generation for write clock
initial begin
  clk <= 0; 
  forever #(CYCLE/2) clk = ~clk;
end

//release of reset_n relative to two clocks
initial begin
  input_file  = $fopen("input_data", "rb");
    if (input_file==0) begin 
      $display("ERROR : CAN NOT OPEN input_file"); 
    end
  output_file = $fopen("output_data", "wb");
    if (output_file==0) begin 
      $display("ERROR : CAN NOT OPEN output_file"); 
    end
    a_in='x;
    b_in='x;
    start=1'b0;
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

  gcd gcd_0(.*); //instantiate the gcd unit
  
  gcd_random gcd_rdm; //create a class object
  
  
  //declare all covergroup
  cg1 cg1_inst = new();
  cg2 cg2_inst = new();
  cg3 cg3_inst = new();
  cg4 cg4_inst = new();
  

  integer gcd_value; // store the result from gcd.sv
  integer tb_value; // store the result from testbench
  integer tb_a_in;
  integer tb_b_in;
  
  integer bigger;
  integer smaller;
  integer temp;

initial begin
  
  $display ("--------------------------------------------------");
  $display ("Executing Part1.1 ... ");
  $display ("--------------------------------------------------");

  #(CYCLE*4);  //delay after reset
  while(! $feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   $fdisplay (output_file,"a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   $display ("a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  
  $fclose(input_file);
  $fclose(output_file);
  
  
  $display ("--------------------------------------------------");
  $display ("Executing Part1.2 ... ");
  $display ("--------------------------------------------------");
  
  input_file = $fopen("post_input_data", "rb");
  if (input_file) $display("SUCCESS: OPEN FILE -> post_input_data");
  else            $display("ERROR : CAN NOT OPEN -> post_input_data");
  
  output_file = $fopen("post_output_data", "wb");
  if (output_file) $display("SUCCESS: OPEN FILE -> post_output_data");
  else             $display("ERROR : CAN NOT OPEN -> post_output_data"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  #(CYCLE*4);  //delay after reset
  
  while(!$feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
    while(done != 1'b1) begin
      //$display("Hello!");
      #(CYCLE);
    end
   $fdisplay (output_file,"a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   $display ("a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  
  $fclose(input_file);
  $fclose(output_file);
  
  
  //////////////////////////////////////////////////////////////
  //PART 2: Generate 501 random pairs of 16'bit integers      //
  //Write out both numbers and GCD to file: random-outputs.txt//
  //////////////////////////////////////////////////////////////
  $display ("--------------------------------------------------");
  $display ("Executing Part2 ... ");
  $display ("--------------------------------------------------");
  
  gcd_rdm = new (); // instantiate the object
  
  // make sure the file opened successfully
  output_file = $fopen("random-outputs.txt", "wb");
  if (output_file)  $display("SUCCESS: OPEN FILE -> random-outputs.txt");
  else        $display("ERROR : CAN NOT OPEN -> random-outputs.txt"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  #(CYCLE*4);  //delay after reset
  
  // Generate 501 random pairs of 16'bit integers
  for (i = 1; i <= 501; i++) begin
    if (gcd_rdm.randomize() == 0) $display ("ERROR : FAIL TO RANDOMIZING ... ");
    
    //giving random number via the class function
    a_in = gcd_rdm.a; 
    b_in = gcd_rdm.b;
    
    start = 1'b1;
    #(CYCLE);
    start = 1'b0;
    while(done != 1'b1) begin
      #(CYCLE);
      //$display ("EXECUTING: a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
    end
    
    $fdisplay (output_file,"%d  %d  %d", a_in, b_in, result);
    $display ("a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
    #(CYCLE*2); //2 cycle delay between trials
    
  end // end for 501 iterations
  
  $fclose(output_file);
  
  ////////////////////////////////////////////////////
  //PART 3: Comparison with reference implementation//
  ////////////////////////////////////////////////////
  $display ("--------------------------------------------------");
  $display ("Executing Part3 ... ");
  $display ("--------------------------------------------------");
  
  //spec: 
  //1. read one line at a time from post_input_data
  //2. obtains its GCD from the gcd() module, and computes GCD in tb
  //3. compare the outputs where we get from gcd() module and tb
  //4. if they match, write to file: comparison.rpt (a_in b_in match)
  //5. if they don't match (a_in b_in gcd: ?? behavioral: ??)
  
  input_file = $fopen("post_input_data", "rb");
  if (input_file) $display("SUCCESS: OPEN FILE -> post_input_data");
  else            $display("ERROR : CAN NOT OPEN -> post_input_data");
  
  output_file = $fopen("comparison.rpt", "wb");
  if (output_file)  $display("SUCCESS: OPEN FILE -> comparison.rpt");
  else        $display("ERROR : CAN NOT OPEN -> comparison.rpt"); 
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  #(CYCLE*4);  //delay after reset
  
  while (!$feof(input_file)) begin
    $fscanf(input_file,"%d %d", a_in, b_in); // read the given data
    start=1'b1;
    #(CYCLE);
    start=1'b0;
    while(done != 1'b1) #(CYCLE); // GCD module is executing
    gcd_value = result;
    
    // computing in testbench
    //algorithm
    //function gcd(a, b)
    //while b ≠ 0
    //    t := b
    //    b := a mod b
    //    a := t
    //return a
    
    tb_a_in = a_in;
    tb_b_in = b_in;    
    
    // distinguish which is bigger
    if (tb_a_in >= tb_b_in) begin
      bigger = tb_a_in;
      smaller = tb_b_in;
    end
    else begin
      bigger = tb_b_in;
      smaller = tb_a_in;
    end
    
    // start to computing GCD
    while (smaller != 0) begin
      temp = smaller;
      smaller = (bigger % smaller);
      bigger = temp;
      tb_value = bigger;
    end 
    
    if (bigger == 0 && smaller == 0) tb_value = 0; // in case of a and b are '0' 
    
    // if match, the format: 'a_in b_in match'
    if (gcd_value == tb_value) begin
      $fdisplay (output_file,"%d  %d  match", a_in, b_in);
      $display ("a_in=%d   b_in=%d   match", a_in, b_in);
    end
    // if not match, the format: 'a_in b_in gcd: ?? behavioral: ??'
    else begin
      $fdisplay (output_file,"%d  %d   gcd: %d  behavioral: %d", a_in, b_in, gcd_value, tb_value);
      $display ("a_in=%d   b_in=%d   gcd: %d  behavioral: %d", a_in, b_in, gcd_value, tb_value);
    end
    
    
    #(CYCLE*2); //2 cycle delay between trials
  end // end for accessing all post_input_data
  
  $fclose(input_file);
  $fclose(output_file);
  
  ////////////////////////////////////////////////////
  //PART 5: Collect covergroup coverage via new file//
  //New File: covergroups.sv                        //
  ////////////////////////////////////////////////////
  $display ("--------------------------------------------------");
  $display ("Executing Part5 ... ");
  $display ("--------------------------------------------------");
   
  
  input_file = $fopen("post_input_data", "rb");
  if (input_file) $display("SUCCESS: OPEN FILE -> post_input_data");
  else            $display("ERROR : CAN NOT OPEN -> post_input_data");
  
  a_in='x;
  b_in='x;
  start=1'b0;
  reset_n <= 0;
  #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
  #(CYCLE*2);  //delay after reset
  
  while(!$feof(input_file)) begin 
   $fscanf(input_file,"%d %d", a_in, b_in);
   start=1'b1;
   #(CYCLE);
   start=1'b0;
   while(done != 1'b1) #(CYCLE);
   $display ("a_in=%d   b_in=%d   result=%d", a_in, b_in, result);
   #(CYCLE*2); //2 cycle delay between trials
  end
  
  $fclose(input_file);
  
$stop;
end

endmodule
