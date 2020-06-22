`timescale 1ns / 1ps

//image size =2 for the sake of checking the output 
module tanh_2D_tb();
reg clk;
parameter datawidth=32,image_size=4; 
reg [datawidth-1:0]  in_tanh   [image_size] [image_size];
reg enable;
wire [datawidth-1:0]  out_tanh [image_size] [image_size] ;

tanh_2D_1f #(32,image_size)tanh_2D_instance(clk,enable,in_tanh,out_tanh);

initial begin
clk=1'b0;
in_tanh[0][0]=32'h3F000000;
in_tanh[0][1]=32'h3F200000;
in_tanh[0][2]=32'h3F000000;
in_tanh[0][3]=32'h3F200000;

in_tanh[1][0]=32'h3F800000;
in_tanh[1][1]=32'h3F000000;

in_tanh[1][2]=32'h3F200000;
in_tanh[1][3]=32'h3F200000;

in_tanh[2][0]=32'h3F666666;
in_tanh[2][1]=32'h3F800000;
in_tanh[2][2]=32'h3F000000;
in_tanh[2][3]=32'h3F300000;

in_tanh[3][0]=32'h3F666666;
in_tanh[3][1]=32'h3F800000;
in_tanh[3][2]=32'h3F000000;
in_tanh[3][3]=32'h3F300000;


#1800

$finish;
end

always begin
forever #10 clk = ~clk; // generate a clock

end 



endmodule
//