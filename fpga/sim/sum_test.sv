
// Henry Heathwood
// hheathwood@hmc.edu
// 9/8/24 
// Hex Sum calculation and led logic module

module sum_logic(input logic [7:0] data,
		output logic [4:0] sum
);

	assign sum = data[7:4] + data[3:0];

endmodule
	