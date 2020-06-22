module BasicConv 
( A,B,clk,start,C
 );
 parameter       elements = 5, 
                 DATA_WIDTH = 32;
                 
input [(DATA_WIDTH-1):0] A ;
input [(DATA_WIDTH-1):0] B ; 
input     clk ,start;
output reg[DATA_WIDTH-1:0] C ;

wire [DATA_WIDTH-1:0] out_mul;
wire [DATA_WIDTH-1:0] out_add;


     fpmul mul(
     .flpA  (A),
     .flpB  (B),
     .flpout (out_mul)
     );
     
     fp_add add(
     .flpA  (out_mul),
     .flpB (C),
     .flpout (out_add)
     );
     

always@(posedge clk)
begin

	if (start==0) 
	begin
			C=32'h00000000;
	end
	else 
	begin

	C =out_add;
end
end
endmodule