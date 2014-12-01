module ID(
	input clk,
	input rst_n,
	input [31:0]instruction,
	input [31:0]PC_4,
	input [4:0]writeReg,
	input [31:0]writeData,
	input MEM_WB_regWrite,
	input [4:0]ID_EX_regRt,
	input [4:0]ID_EX_memRead,
	output [31:0]PC_OUT,
	output FLUSH,
	output BRANCH,
	output PC_WRITE,
	output IFIDWRITE,
	output [4:0]regRt,
	output [4:0]regRs,
	output [4:0]regRd,
	output [31:0]extended_imm,
	output [31:0]readData_1,
	output [31:0]readData_2,
	output regWrite,
	output memToReg,
	output memRead,
	output memWrite,
	output aluSrc,
	output [1:0]aluOp,
	output regDst);

//TODO

endmodule