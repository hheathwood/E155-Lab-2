// Henry Heathwood
// hheathwood@hmc.edu
 // 9/8/24 
// Top-level Verilog Module

module top(
     input   logic reset, 
	 input logic [7:0] data,
     output  logic [1:0] selector, logic [6:0] seg, logic [4:0] sum
);

   logic int_osc;
   logic [17:0] counter;
   logic [3:0] current_data;
  
   // Internal high-speed oscillator
   HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
  
   // Counter
   always_ff @(posedge int_osc) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 1;
		 
     if (counter[17] == 1) current_data <= data[3:0];
	 else current_data <= data[7:4];
   end
  
   // Assign selector output
   assign selector[0] = counter[17];
   assign selector[1] = ~counter[17];
   
    // call seven segment decoders
   seven_segment_decoder s1(current_data[3:0], seg[6:0]);
   seven_segment_decoder s2(current_data[3:0], seg[6:0]);
   
  // call sum logic
  sum_logic s3(data[7:0], sum[4:0]);
   
  
endmodule
