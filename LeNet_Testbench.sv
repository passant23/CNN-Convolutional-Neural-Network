`timescale 1ns / 1ps

module LeNet_Testbench( );
reg clk;
reg start;
wire [31:0] FINAL_OUTPUT [10][1][1];
wire [31:0] Max_S;
wire [3:0] Index_S; 
reg [31:0] image[32][32];
reg [31:0] filter1[6][5][5];
reg [31:0] filter2[16][5][5];
reg [31:0] filter3[120][5][5];
reg [31:0] weights1[120][84];
reg [31:0] weights2[84][10];

parameter image_file="D:/Image.txt",
          filter1_file="D:/Filter1_IEEE.txt",
          filter2_file="D:/Filter2_IEEE.txt",
          filter3_file="D:/Filter3_IEEE.txt",
          weights1_file="D:/Weights1_IEEE.txt",
          weights2_file="D:/Weights2_IEEE.txt";
          
//Instantiation of the integration file
LeNet_CNN LeNet(clk,start,image,filter1,filter2,filter3,FINAL_OUTPUT,Max_S,Index_S);          
          
          
//Reading the image file
read #(image_file,32,32)
reading_image(image);

//Reading filter1
read3D #(filter1_file,5,5,6)
reading_filter1(filter1);

//Reading filter2
read3D #(filter2_file,5,5,16)
reading_filter2(filter2);

//Reading filter3
read3D #(filter3_file,5,5,120)
reading_filter3(filter3);


//Reading weights1
//read #(weights1_file,120,84)
//reading_imageweight_file1(weights1);


//Reading weights2
//read #(weights2_file,84,10)
//reading_weight_file2(weights2);



endmodule