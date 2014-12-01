module EX(
	input clk,
	input rst_n,
	input aluSrc,
	input [1:0]aluOp,
	input regDst,
	input [31:0]EX_MEM_aluOut,
	input [31:0]writeData,
	input [31:0]readData_1,
	input [31:0]readData_2,
	input [31:0]extended_imm,
	input [4:0]ID_EX_regRt,
	input [4:0]ID_EX_regRs,
	input [4:0]ID_EX_regRd,
	input [4:0]EX_MEM_regRd,
	input EX_MEM_regWrite,
	input [4:0]MEM_WB_regRd,
	input MEM_WB_regWrite,
	output [31:0]aluRes,
	output [4:0]regRd,
	output [31:0]MEM_writeData);

//TODO

endmodule