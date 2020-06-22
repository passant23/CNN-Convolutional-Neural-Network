`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2020 02:30:54 PM
// Design Name: 
// Module Name: tanh_2d_filters_tb
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


module tanh_2d_filters_tb(

    );


reg clk;
parameter datawidth=32,image_size=4,filter_size=2;
 
reg [datawidth-1:0]  in_tanh  [filter_size] [image_size] [image_size];
reg enable;
wire [datawidth-1:0]  out_tanh [filter_size] [image_size] [image_size] ;

tanh_2D_parallel_filters #(32,image_size,filter_size) tanh_2D_parallel_filters_instance(clk,enable,in_tanh,out_tanh);

initial begin
clk=1'b1;
in_tanh[0][0][0]=32'h3F000000;
in_tanh [0][0][1]=32'h3F200000;
in_tanh[0][0][2]=32'h3F000000;
in_tanh[0][0][3]=32'h3F200000;

in_tanh[0][1][0]=32'h3F800000;
in_tanh[0][1][1]=32'h3F000000;

in_tanh[0][1][2]=32'h3F200000;
in_tanh[0][1][3]=32'h3F200000;

in_tanh[0][2][0]=32'h3F666666;
in_tanh[0][2][1]=32'h3F800000;
in_tanh[0][2][2]=32'h3F000000;
in_tanh[0][2][3]=32'h3F300000;

in_tanh[0][3][0]=32'h3F666666;
in_tanh[0][3][1]=32'h3F800000;
in_tanh[0][3][2]=32'h3F000000;
in_tanh[0][3][3]=32'h3F300000;

in_tanh[1][0][0]=32'h3F666666;
in_tanh [1][0][1]=32'h3F666666;
in_tanh[1][0][2]=32'h3F000000;
in_tanh[1][0][3]=32'h3F200000;

in_tanh[1][1][0]=32'h3F800000;
in_tanh[1][1][1]=32'h3F300000;

in_tanh[1][1][2]=32'h3F000000;
in_tanh[1][1][3]=32'h3F200000;

in_tanh[1][2][0]=32'h3F666666;
in_tanh[1][2][1]=32'h3F800000;
in_tanh[1][2][2]=32'h3F000000;
in_tanh[1][2][3]=32'h3F300000;

in_tanh[1][3][0]=32'h3F666666;
in_tanh[1][3][1]=32'h3F400000;
in_tanh[1][3][2]=32'h3F000000;
in_tanh[1][3][3]=32'h3F300000;


#1000
$finish;
end

always begin
forever #10 clk = ~clk; // generate a clock

end 



endmodule
//