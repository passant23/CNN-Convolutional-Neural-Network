`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2020 08:17:12 AM
// Design Name: 
// Module Name: tanh_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tanh_tb();
reg clk;
parameter datawidth=32; 
reg [datawidth-1:0] input_data;
wire [datawidth-1:0] output_data;
tanh tanh_instance(clk,input_data,output_data);

initial begin
clk=1'b1;

input_data=32'hBF000000;
#20
input_data=32'h3F000000;
#20
input_data=32'h00000000;
#20
input_data=32'h3E4CCCCD;
#20
input_data=32'h3F800000;
#20
input_data=32'h3E99999A;
#20


#120
$finish;
end

always begin
forever #10 clk = ~clk; // generate a clock

end 



endmodule
