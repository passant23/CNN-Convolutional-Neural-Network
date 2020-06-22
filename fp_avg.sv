`timescale 1ns / 1ps


module fp_avg(In1,clk,start,avg);
input [31:0] In1;  
input start,clk;
output reg [31:0] avg;
wire [31:0] divOut;
wire [31:0] outadd2;
reg [31:0] div;

assign div= 32'b00111110100000000000000000000000;

fpmul AVG(
.flpA(In1),
.flpB(div),     //  In1/4
. flpout(divOut)     
);

fp_add add2(
.A_FP(divOut), // Accumulate on avg;
.B_FP(avg),
.flpout(outadd2)
);




always@(posedge clk )
begin
	if (start==0) 
	begin
			avg=32'h00000000;
	end
	else 
	begin
	avg =outadd2;
end
end
endmodule
