module PE_FC_ANN 
( input_fc,iweight_FC,clk,start_newcol,output_fc
 );
parameter DATA_WIDTH = 32; //
input [DATA_WIDTH-1:0]       input_fc ;
input [DATA_WIDTH-1:0]      iweight_FC; 
input     clk ,start_newcol;
output reg[DATA_WIDTH-1:0] output_fc;

wire [DATA_WIDTH-1:0] out_mul;
wire [DATA_WIDTH-1:0] out_add;
reg [DATA_WIDTH-1:0] output_fc_int=32'h0;

fpmul mul(input_fc,iweight_FC,out_mul);
fp_add add(out_mul,output_fc_int,out_add);
always@(posedge clk)
begin

if(start_newcol==1)
begin
output_fc_int=32'h0;
output_fc=output_fc_int;
end
else begin

	output_fc_int =out_add;
	
	output_fc=output_fc_int;
end
end




endmodule