`timescale 1ns / 1ps

module softmax_max_index(clock,reset,inputS,outputS,max_S,index_S,done);

    parameter datawidth=32;
    input clock;
    input reset;
    input [datawidth-1:0] inputS [10][1][1];  
    output reg [datawidth-1:0] outputS [10][1][1];
    output reg [datawidth-1:0] max_S;
    output reg [3:0] index_S;
    output reg done;

  wire [datawidth-1:0] outputStemp[9:0][1][1];
  
  
 softmaxLayer SL(clock, 1,inputS,outputStemp);
 comparingSoftmax comps(clock,outputStemp,max_S,index_S);   
 
assign  outputS=outputStemp;
always@(negedge clock)
begin
done=1;
end

endmodule