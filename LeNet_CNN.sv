`timescale 1ns / 1ps
module LeNet_CNN(clk,start,ImageIn,FilterIn1,FilterIn2,FilterIn3,FINAL_OUTPUT,Max_S,Index_S);
parameter weights1_file="D:/Weights1_IEEE.txt",
         weights2_file="D:/Weights2_IEEE.txt";
//LeNetOutput,Index_Maximum);
/////////////Parameters/////////////
//parameter file_layer1="",
  //        file_layer2="";
/////////////////////////////////////
input clk,start;
input [31:0] ImageIn [32][32];
input [31:0] FilterIn1 [6][5][5];
input [31:0] FilterIn2 [16][5][5];
input [31:0] FilterIn3 [120][5][5];

//output reg [31:0] LeNetOutput [10];

//output [3:0] Index_Maximum;
reg  [31:0]  ImageOut [120][1][1];
//
wire start_layer1,start_layer2;
wire [31:0]  out_conv1 [6][28][28];
wire [31:0] out_tanh1 [6][28][28];
wire [31:0] out_avg1 [6][14][14];
//
wire [31:0]  out_conv2 [16][10][10];
wire [31:0] out_tanh2 [16][10][10];
wire [31:0] out_avg2 [16][5][5];
//
wire [31:0]  out_conv3 [120][1][1];
wire [31:0] out_tanh3 [120][1][1];

wire [31:0] out_tanh4 [84][1][1];
wire valid_tanh1, valid_tanh2,valid_tanh3,valid_tanh4, valid_avg1, valid_avg2;
wire [31:0] output_layer1 [84][1][1];
wire [31:0] output_layer2 [10][1][1];
wire [31:0] output_softmax [9:0][1][1];
//reg  [31:0] Fc_In [120];
wire Fc1_done, Fc2_done,softmax_done;
wire [31:0] max_s;
wire [3:0] index_s; 

output reg [31:0] FINAL_OUTPUT [9:0][1][1];
output reg [31:0] Max_S;
output reg [3:0] Index_S;

//////////////////////////////////////////////////////////////////////////////////
// -------------- 1st Convolution stage --------------  //
ConvMF #(5,32,28,6,32)conv1(
.Image(ImageIn),
.Filters(FilterIn1),
.start(start),
.clk(clk),
.Out(out_conv1)
);
////////////////////////////////////////////////////////////////////////////////
// ------------- 1st Average Pool stage------------- //
avg_3D # (6,28) avg1(
.ImagesIn(out_tanh1),
.clk(clk),
.start(valid_tanh1),
.ImagesOut(out_avg1),
.valid(valid_avg1)
);
// --------------------------------------------------------- //
// --------------  2nd Convolution Stage -------------- //
ConvMF #(5,14,10,16,32) conv2(
.Image(out_avg1[0]),
.Filters(FilterIn2),
.start(valid_avg1),
.clk(clk),
.Out(out_conv2)
);

// --------------  2nd Average Pool stage --------------  //
avg_3D # (16,10) avg2(
.ImagesIn(out_tanh2),
.clk(clk),
.start(valid_tanh2), 
.ImagesOut(out_avg2),
.valid(valid_avg2)
);
// ------------------------------------------------------------------- //
// --------------  3rd Convolution stage --------------  //
ConvMF #(5,5,1,120,32) conv3(
.Image(out_avg2[0]),
.Filters(FilterIn3),
.start(valid_avg2), 
.clk(clk),
.Out(out_conv3)
);
// ------------------ The 3 Tanh Stages ------------------ //
tanh_2D_parallel_filters#(32,28,6) tanh1(
.clk(clk),
.enable(valid_tanh1),
.in_tanh_2D(out_conv1),
.out_tanh_2D(out_tanh1)
);
///
tanh_2D_parallel_filters#(32,10,16) tanh2(
.clk(clk),
.enable(valid_tanh2),
.in_tanh_2D(out_conv2),
.out_tanh_2D(out_tanh2)
);
///
tanh_2D_parallel_filters#(32,1,120) tanh3(
.clk(clk),
.enable(valid_tanh3),
.in_tanh_2D(out_conv3),
.out_tanh_2D(out_tanh3)
);


// --------------- FC Layer 1 --------------- //
FC_CNN #(32,120,84,weights1_file)
Layer1(
.clk(clk),
.input_fc(out_tanh3),
.output_fc(output_layer1),
.start(valid_tanh3),
. done (Fc1_done)
);

// --------------- Tanh After 1st Fc Layer --------------- //
tanh_2D_parallel_filters#(32,1,84) tanh4(
.clk(clk),
.enable(valid_tanh4),
.in_tanh_2D(output_layer1),
.out_tanh_2D(out_tanh4)
);

// --------------- FC Layer 2 --------------- //

FC_CNN #( 32,84,10,weights2_file )
Layer2(
.clk(clk),
.input_fc(out_tanh4),
.output_fc(output_layer2),
.start(valid_tanh4),
. done (Fc2_done)
);

// --------------- Softmax --------------- //

softmax_max_index#(32)
softmax_instance(
.clock(clk),
.reset(Fc2_done),
.inputS(output_layer2),
.outputS(output_softmax),
.max_S (max_s),
.index_S (index_s),
.done (softmax_done)
 );

// --------------------------------------------- //

always @(posedge clk)
begin
if (softmax_done==1)
FINAL_OUTPUT = output_softmax;
Max_S= max_s;
Index_S = index_s;
end

endmodule