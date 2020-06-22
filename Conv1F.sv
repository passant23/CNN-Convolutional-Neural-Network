module Conv1F (Image,Filter,clk,start,Out);

 parameter       FDim = 5, //5x5
                 IDim = 32, //32x32
                 ODim = 28, //28x28
                 DATA_WIDTH = 32;
                 
input [(DATA_WIDTH-1):0] Image [IDim][IDim];
input [(DATA_WIDTH-1):0] Filter [FDim][FDim]; 
input     clk ,start;
output reg [(DATA_WIDTH-1):0] Out [ODim][ODim];

reg start_basic;
reg [DATA_WIDTH-1:0] crnt_pixel;
reg [DATA_WIDTH-1:0] crnt_filter;
wire [DATA_WIDTH-1:0] out_conv;

reg [4:0] i; //5 bits for 28 iterations (2^5=32)
reg [4:0] j;
reg [4:0] m;
reg [4:0] n;
reg [4:0] count;

     BasicConv conv(
     .A (crnt_pixel), 
     .B (crnt_filter),
     .clk (clk),
     .start (start_basic),
     .C (out_conv)
      );


	always@(posedge clk)
	begin
	
	   if(start==0)
	   begin
	    m=0; //for filter check
	    n=0;
	    count=0; //for 25 count check
	    start_basic=0;
		i=2; //for image rows
		j=2; //for image columns
	    end
	    
	else 
	begin
	start_basic=1;
	    if (i<(IDim-2) && count<25)//loops of image
	    begin
	    if(j<(IDim-2) && count<25)
	    begin                     

			   if(n<5 && m<5)
			   begin
			   crnt_pixel= Image   [i-2+m][j-2+n];     
               crnt_filter= Filter [m][n];  
               count=count+1; //inc count of elements 
               n=n+1;			   
			   end
			   else if(n==5 && m<5)
			   begin
			   n=0;
			   m=m+1;
			   crnt_pixel= Image   [i-2+m][j-2+n];     
               crnt_filter= Filter [m][n];  
               count=count+1; //inc count of elements   
			   end
			   else if (m==5)
                begin
                m=0;
                n=0;
                j=j+1;
                crnt_pixel= Image   [i-2+m][j-2+n];     
                crnt_filter= Filter [m][n];  
                count=count+1; //inc count of elements    
                end			   
        
        
        end
		else
		begin
		i=i+1;
		j=2;
        if(n<5 && m<5)
        begin
        crnt_pixel= Image   [i-2+m][j-2+n];     
        crnt_filter= Filter [m][n];  
        count=count+1; //inc count of elements 
        n=n+1;               
        end
        else if(n==5 && m<5)
        begin
        n=0;
        m=m+1;
        crnt_pixel= Image   [i-2+m][j-2+n];     
        crnt_filter= Filter [m][n];  
        count=count+1; //inc count of elements   
        end
        else if (m==5)
        begin
        m=0;
        n=0;
        j=j+1;
        crnt_pixel= Image   [i-2+m][j-2+n];     
        crnt_filter= Filter [m][n];  
        count=count+1; //inc count of elements    
        end               
		end
		end	
		
			if (count==25) //stalling one cycle to get the correct output and write it in the out array
			begin
			crnt_pixel=0;     
            crnt_filter=0;
	        start_basic=0;            
            count=count+1;
			end
			
	        if(count==26)
	        begin
	        Out[i-2][j-2]=out_conv;
	        count=0;
	        end
	           
	 end
    end	 

endmodule