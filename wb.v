module WB(
	input [31:0]MEM_WB_aluOut,
	input [31:0]MEM_WB_data,
	input MEM_WB_memToReg,
	output [31:0]writeData);

	assign writeData = MEM_WB_memToReg?MEM_WB_data:MEM_WB_aluOut;
	
endmodule