module fpmul (flpA,flpB,flpout);
input [31:0] flpA,flpB;
//output [7:0] exponent,unbiasedexp;
//output [8:0] sumexp;
//output [22:0] prod;
//output sign;
output reg[31:0] flpout;

reg [7:0] expA,expB,biasedA,biasedB,exponent,unbiasedexp;
reg sign,signA,signB;
reg [8:0] sumexp;
reg [22:0] prod,fractA,fractB;
reg [47:0] prod_dbl;
reg [4:0] shiftamnt;
reg check;

always @(flpA or flpB)
begin
signA=flpA[31];
signB=flpB[31];
expA=flpA[30:23];
expB=flpB[30:23];
fractA=flpA[22:0];
fractB=flpB[22:0];
check = 0;


sumexp=expA+expB- 8'b01111111;
flpout[30:23]=sumexp;
//unbiasedexp=exponent-8'b0111_1111;

// 11.1  >> 1.11 *2^1   
prod_dbl= {1'b1, fractA} * {1'b1,fractB};

if(flpA==32'b00000000000000000000000000000000)
flpout = 32'b00000000000000000000000000000000;
else if (flpB==32'b00000000000000000000000000000000)
flpout = 32'b00000000000000000000000000000000;
else if(prod_dbl[47]==0)
    flpout[22:0] = prod_dbl[45:23];//I skip prod_db1[47,46]  45-23+1
else 
begin
    sumexp   =  sumexp + 1;
    flpout[22:0] = prod_dbl[46:24];//I skip prod_db1[47,46]  45-23+1
end
 
 flpout[31]=signA^signB;
end
endmodule