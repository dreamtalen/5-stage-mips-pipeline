module top(
	input clk,
	input rst_n);//when rst_n==0, reset all

//IF-----------------------

	wire [31:0]IF_ID_PC_4_out;
	wire [31:0]IF_ID_instruction_out;

	IF IF(
		.clk(clk),
		.rst_n(rst_n),
		.PC_OUT(PC_OUT),
		.FLUSH(FLUSH),
		.PC_WRITE(PC_WRITE),
		.BRANCH(BRANCH),
		.PC_4(IF_ID_PC_4_out),
		.instruction(IF_ID_instruction_out));

	reg [31:0]IF_ID_PC_4;
	reg [31:0]IF_ID_instruction;

	always @(negedge clk or negedge rst_n) begin
		if(~rst_n) begin
			IF_ID_PC_4 <= 0;
			IF_ID_instruction <= 0;
		end else if(FLUSH) begin
			IF_ID_PC_4 <= 0;
			IF_ID_instruction <= 0;
		end else if(IFIDWRITE) begin
			IF_ID_PC_4 <= IF_ID_PC_4;
			IF_ID_instruction <= IF_ID_instruction;
		end else begin
			IF_ID_PC_4 <= IF_ID_PC_4_out;
			IF_ID_instruction <= IF_ID_instruction_out;
		end
	end

//ID---------------------------

	wire ID_EX_regWrite_out;
	wire ID_EX_memToReg_out;
	wire ID_EX_memRead_out;
	wire ID_EX_memWrite_out;
	wire ID_EX_aluSrc_out;
	wire [1:0]ID_EX_aluOp_out;
	wire ID_EX_regDst_out;

	wire [31:0]PC_OUT;
	wire FLUSH;
	wire PC_WRITE;
	wire BRANCH;
	wire IFIDWRITE;
	wire [5:0]ID_EX_regRt_out;
	wire [5:0]ID_EX_regRs_out;
	wire [5:0]ID_EX_regRd_out;
	wire [31:0]ID_EX_extended_imm_out;
	wire [31:0]ID_EX_readData_1_out;
	wire [31:0]ID_EX_readData_2_out;

	ID ID(
		.clk(clk),
		.rst_n(rst_n),
		.instruction(IF_ID_instruction),
		.PC_4(IF_ID_PC_4),
		.writeReg(MEM_WB_regRd),
		.writeData(writeData),
		.MEM_WB_regWrite(MEM_WB_regWrite),
		.ID_EX_regRt(ID_EX_regRt),
		.ID_EX_memRead(ID_EX_memRead),
		.PC_OUT(PC_OUT),
		.FLUSH(FLUSH),
		.BRANCH(BRANCH),
		.PC_WRITE(PC_WRITE),
		.IFIDWRITE(IFIDWRITE),
		.regRt(ID_EX_regRt_out),
		.regRs(ID_EX_regRs_out),
		.regRd(ID_EX_regRd_out),
		.extended_imm(ID_EX_extended_imm_out),
		.readData_1(ID_EX_readData_1_out),
		.readData_2(ID_EX_readData_2_out),
		.regWrite(ID_EX_regWrite_out),
		.memToReg(ID_EX_memToReg_out),
		.memRead(ID_EX_memRead_out),
		.memWrite(ID_EX_memWrite_out),
		.aluSrc(ID_EX_aluSrc_out),
		.aluOp(ID_EX_aluOp_out),
		.regDst(ID_EX_regDst_out));

	reg ID_EX_regWrite;
	reg ID_EX_memToReg;
	reg ID_EX_memRead;
	reg ID_EX_memWrite;
	reg ID_EX_aluSrc;
	reg [1:0]ID_EX_aluOp;
	reg ID_EX_regDst;

	reg [31:0]ID_EX_readData_1;
	reg [31:0]ID_EX_readData_2;
	reg [31:0]ID_EX_extended_imm;
	reg [4:0]ID_EX_regRt;
	reg [4:0]ID_EX_regRs;
	reg [4:0]ID_EX_regRd;

	always @(negedge clk or negedge rst_n) begin
		if(~rst_n) begin
			ID_EX_regWrite <= 0;
			ID_EX_memToReg <= 0;
			ID_EX_memRead <= 0;
			ID_EX_memWrite <= 0;
			ID_EX_aluSrc <= 0;
			ID_EX_aluOp <= 0;
			ID_EX_regDst <= 0;
			ID_EX_readData_1 <= 0;
			ID_EX_readData_2 <= 0;
			ID_EX_extended_imm <= 0;
			ID_EX_regRt <= 0;
			ID_EX_regRs <= 0;
			ID_EX_regRd <= 0;
		end else begin
			ID_EX_regWrite <= ID_EX_regWrite_out;
			ID_EX_memToReg <= ID_EX_memToReg_out;
			ID_EX_memRead <= ID_EX_memRead_out;
			ID_EX_memWrite <= ID_EX_memWrite_out;
			ID_EX_aluSrc <= ID_EX_aluSrc_out;
			ID_EX_aluOp <= ID_EX_aluOp_out;
			ID_EX_regDst <= ID_EX_regDst_out;
			ID_EX_readData_1 <= ID_EX_readData_1_out;
			ID_EX_readData_2 <= ID_EX_readData_2_out;
			ID_EX_extended_imm <= ID_EX_extended_imm_out;
			ID_EX_regRt <= ID_EX_regRt_out;
			ID_EX_regRs <= ID_EX_regRs_out;
			ID_EX_regRd <= ID_EX_regRd_out;
		end
	end

//EX-------------------------

	wire EX_MEM_regWrite_out;
	wire EX_MEM_memToReg_out;
	wire EX_MEM_memRead_out;
	wire EX_MEM_memWrite_out;

	wire [31:0]EX_MEM_aluOut_out;
	wire [4:0]EX_MEM_regRd_out;
	wire [31:0]EX_MEM_writeData_out;

	EX EX(
		.clk(clk),
		.rst_n(rst_n),
		.aluSrc(ID_EX_aluSrc),
		.aluOp(ID_EX_aluOp),
		.regDst(ID_EX_regDst),
		.EX_MEM_aluOut(EX_MEM_aluOut),
		.writeData(writeData),
		.readData_1(ID_EX_readData_1),
		.readData_2(ID_EX_readData_2),
		.extended_imm(ID_EX_extended_imm),
		.ID_EX_regRt(ID_EX_regRt),
		.ID_EX_regRs(ID_EX_regRs),
		.ID_EX_regRd(ID_EX_regRd),
		.EX_MEM_regRd(EX_MEM_regRd),
		.EX_MEM_regWrite(EX_MEM_regWrite),
		.MEM_WB_regRd(MEM_WB_regRd),
		.MEM_WB_regWrite(MEM_WB_regWrite),
		.aluRes(EX_MEM_aluOut_out),
		.regRd(EX_MEM_regRd_out),
		.MEM_writeData(EX_MEM_writeData_out));

	reg EX_MEM_regWrite;
	reg EX_MEM_memToReg;
	reg EX_MEM_memRead;
	reg EX_MEM_memWrite;

	reg [31:0]EX_MEM_aluOut;
	reg [31:0]EX_MEM_writeData;
	reg [4:0]EX_MEM_regRd;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			EX_MEM_regWrite_out <= 0;
			EX_MEM_memToReg_out <= 0;
			EX_MEM_memRead_out <= 0;
			EX_MEM_memWrite_out <= 0;
		end else begin
			EX_MEM_regWrite_out <= ID_EX_regWrite;
			EX_MEM_memToReg_out <= ID_EX_memToReg;
			EX_MEM_memRead_out <= ID_EX_memRead;
			EX_MEM_memWrite_out <= ID_EX_memWrite;
		end
	end

	always @(negedge clk or negedge rst_n) begin
		if(~rst_n) begin
			EX_MEM_regWrite <= 0;
			EX_MEM_memToReg <= 0;
			EX_MEM_memRead <= 0;
			EX_MEM_memWrite <= 0;
			EX_MEM_aluOut <= 0;
			EX_MEM_writeData <= 0;
			EX_MEM_regRd <= 0;
		end else begin
			EX_MEM_regWrite <= EX_MEM_regWrite_out;
			EX_MEM_memToReg <= EX_MEM_memToReg_out;
			EX_MEM_memRead <= EX_MEM_memRead_out;
			EX_MEM_memWrite <= EX_MEM_memWrite_out;
			EX_MEM_aluOut <= EX_MEM_aluOut_out;
			EX_MEM_writeData <= EX_MEM_writeData_out;
			EX_MEM_regRd <= EX_MEM_regRd_out;
		end
	end

//MEM---------------------

	wire MEM_WB_regWrite_out;
	wire MEM_WB_memToReg_out;
	wire [31:0]MEM_WB_aluOut_out;
	wire [4:0]MEM_WB_regRd_out;

	wire [31:0]MEM_WB_data_out;

	MEM MEM(
		.clk(clk),
		.rst_n(rst_n),
		.EX_MEM_aluOut(EX_MEM_aluOut),
		.EX_MEM_writeData(EX_MEM_writeData),
		.memWrite(EX_MEM_memWrite),
		.memRead(EX_MEM_memRead),
		.memReadData(MEM_WB_data_out));

	reg MEM_WB_regWrite;
	reg MEM_WB_memToReg;
	reg [31:0]MEM_WB_aluOut;
	reg [4:0]MEM_WB_regRd;

	reg [31:0]MEM_WB_data;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			MEM_WB_regWrite_out <= 0;
			MEM_WB_memToReg_out <= 0;
			MEM_WB_aluOut_out <= 0;
			MEM_WB_regRd_out <= 0;
		end else begin
			MEM_WB_regWrite_out <= EX_MEM_regWrite;
			MEM_WB_memToReg_out <= EX_MEM_memToReg;
			MEM_WB_aluOut_out <= EX_MEM_aluOut;
			MEM_WB_regRd_out <= EX_MEM_regRd;
		end
	end

	always @(negedge clk or negedge rst_n) begin
		if(~rst_n) begin
			MEM_WB_regWrite <= 0;
			MEM_WB_memToReg <= 0;
			MEM_WB_aluOut <= 0;
			MEM_WB_regRd <= 0;
			MEM_WB_data <= 0;
		end else begin
			MEM_WB_regWrite <= MEM_WB_regWrite_out;
			MEM_WB_memToReg <= MEM_WB_memToReg_out;
			MEM_WB_aluOut <= MEM_WB_aluOut_out;
			MEM_WB_regRd <= MEM_WB_regRd_out;
			MEM_WB_data <= MEM_WB_data_out;
		end
	end

//WB--------------------

	wire [31:0]writeData;

	WB WB(
		.MEM_WB_aluOut(MEM_WB_aluOut),
		.memReadData(MEM_WB_data),
		.MEM_WB_memToReg(MEM_WB_memToReg),
		.writeData(writeData));

endmodule