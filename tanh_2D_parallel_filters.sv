module tanh_2D_parallel_filters(clk,enable,in_tanh_2D,out_tanh_2D);
parameter  datawidth=32;
parameter  image_size=28, filter_size=6;

input clk;
output reg enable;
 reg [6:0] counter=0;
input  [datawidth-1:0] in_tanh_2D  [filter_size][image_size] [image_size] ;
output reg [datawidth-1:0]out_tanh_2D [filter_size] [image_size] [image_size];


genvar j;
 generate
     for(j=0; j<filter_size; j=j+1)
     begin


tanh_2D_1f #(datawidth,image_size) tanh_2D_obj1 (clk,enable,in_tanh_2D[j],out_tanh_2D[j]);

           end
endgenerate
always @(posedge clk)
begin
counter=counter+1;
if (filter_size==6)
begin
if(counter== 90)begin
enable=1;
end
end
else  if(filter_size==120)
begin
if(counter== 10)
enable=1;
end
else
begin
if(filter_size==16) begin
if(counter== 40)
enable=1;
end

end
end


endmodule