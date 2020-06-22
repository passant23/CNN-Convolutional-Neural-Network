`timescale 1ns / 1ps
module FC_CNN(clk,input_fc,output_fc,start,done);
 parameter       DATA_WIDTH = 32,
                 no_input= 2,
                 no_output= 2,
                 weight_file="C:/Users/passant/Desktop/m.txt"; 
                 
input [DATA_WIDTH-1:0] input_fc [no_input][1][1];
input clk;
input start;
output done; 
output  reg [DATA_WIDTH-1:0] output_fc [no_output][1][1];
reg [DATA_WIDTH-1:0] weights [no_input][no_output];
reg [6:0]i=0; // row 
reg [6:0]j=0; // col
reg [6:0]k=0;  //iter. for output
read #(weight_file,no_input,no_output)
reading_weights(weights);
reg restart_pe=0;
reg [DATA_WIDTH-1:0]current_input;
reg [DATA_WIDTH-1:0] current_weight;
reg [DATA_WIDTH-1:0] current_out;

PE_FC_ANN pe(current_input,current_weight,clk,restart_pe,current_out);

always @(posedge clk)
begin
//if (start==1)
//begin
if( i >= no_input )
begin
output_fc[k][0][0]=current_out;
k=k+1;
i=0;
j=j+1;
restart_pe=1;
 end
 
 if(i!=0  && restart_pe==1 )
 begin
 restart_pe=0;
 end
 else begin

current_input=input_fc[i][0][0];
current_weight=weights[i][j];

i=i+1;
//end
end
end
endmodule