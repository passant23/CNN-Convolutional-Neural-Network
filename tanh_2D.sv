module tanh_2D_1f (clk,enable,in_tanh,out_tanh);
parameter  datawidth=32;
parameter  image_size=28;

input clk,enable;
input   [datawidth-1:0]  in_tanh   [image_size] [image_size];
output reg [datawidth-1:0]  out_tanh [image_size] [image_size] ;
reg  [datawidth-1:0] tanh_pixel_in1;
reg [datawidth-1:0] tanh_pixel_out1;
reg  [datawidth-1:0] tanh_pixel_in2;
reg [datawidth-1:0] tanh_pixel_out2;
reg [4:0] row=0;
reg [4:0]  col=-2;
reg [4:0] rowo=0;
reg [4:0]  colo=-2;
//reg [:0]start=5'b0;

//generating two tanh modules for parallelism 
genvar j;
 generate
    for(j=0; j<1; j=j+1)
     begin
tanh tanh_obj1(clk,tanh_pixel_in1,tanh_pixel_out1);
tanh tanh_obj2(clk,tanh_pixel_in2,tanh_pixel_out2);
          end
endgenerate

always @(posedge clk)
begin

if (row< image_size) begin
col=col+2;

if (col < image_size) begin
//Setting input tanh1 and 2
tanh_pixel_in1<=in_tanh[row][col];

tanh_pixel_in2<=in_tanh[row][col+1];
end 
else begin
col=-2;
row=row+1;
end
end

if (rowo <=image_size  && rowo >=0) begin

 if(colo <= image_size-2  && colo >=0) begin
 //writing the tanh1 and tanh2 out
out_tanh[rowo-1][colo]<=tanh_pixel_out1;

out_tanh[rowo-1][colo+1]<=tanh_pixel_out2;  end


else
begin
 if(colo > image_size-2) begin
rowo=rowo+1;
colo=-2;
end

end
colo=colo+2;
end


end



endmodule
