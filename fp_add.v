`timescale 1ns / 1ps
module fp_add (
input [31:0] flpA, 
input [31:0] flpB, 
output reg [31:0] flpout);
reg sign_a, sign_b,sign_c;
reg [7:0] exponentA, exponentB;
reg [23:0] mantissa_a, mantissa_b,mantissa_c;
reg [7:0] shift_cnt;
reg cout;

always @ (flpA or flpB)
begin
	sign_a  = flpA [31];
	sign_b  = flpB [31];
	exponentA      = flpA [30:23];
	exponentB      = flpB [30:23];
	mantissa_a  = {1'b1,flpA [22:0]};
	mantissa_b  = {1'b1,flpB [22:0]};
	
	if(flpA[30:0] == flpB[30:0] && flpA[31] != flpB[31]) begin
	flpout = 0;
	end
	else
	begin

	if (exponentA < exponentB)
    begin
    
	  shift_cnt  = exponentB - exponentA;
     mantissa_a   = mantissa_a >> shift_cnt;
     exponentA       = exponentA + shift_cnt;  
        
    end 
	else if (exponentB < exponentA)
    begin
		shift_cnt  = exponentA - exponentB;
    	mantissa_b  = mantissa_b >> shift_cnt;
	   exponentB  = exponentB + shift_cnt;
   end 
   
   if (sign_a < sign_b) 
   begin
     
        {cout, mantissa_c} = mantissa_a - mantissa_b;
        
        if (cout == 1) begin
        mantissa_c = -mantissa_c;
        end
        
        if(mantissa_c[23] ==  1)
            shift_cnt = 0;
        else if (mantissa_c[22] ==  1)
            shift_cnt = 1;
        else if (mantissa_c[21] ==  1)
            shift_cnt = 2;
        else if (mantissa_c[20] ==  1)
            shift_cnt = 3;
        else if (mantissa_c[19] ==  1)
            shift_cnt = 4;
        else if (mantissa_c[18] ==  1)
            shift_cnt = 5;
        else if (mantissa_c[17] ==  1)
            shift_cnt = 6;
        else if (mantissa_c[16] ==  1)
            shift_cnt = 7;
        else if (mantissa_c[15] ==  1)
            shift_cnt = 8;
        else if (mantissa_c[14] ==  1)
            shift_cnt = 9;
        else if (mantissa_c[13] ==  1)
            shift_cnt = 10;            
        else if (mantissa_c[12] ==  1)
            shift_cnt = 11;
        else if (mantissa_c[11] ==  1)
            shift_cnt = 12;
        else if (mantissa_c[10] ==  1)
            shift_cnt = 13;
        else if (mantissa_c[9] ==  1)   
            shift_cnt = 14;                    
        else if (mantissa_c[8] ==  1)    
            shift_cnt = 15;                    
        else if (mantissa_c[7] ==  1)    
            shift_cnt = 16;                    
        else if (mantissa_c[6] ==  1)
            shift_cnt = 17;
        else if (mantissa_c[5] ==  1)      
            shift_cnt = 18;  
        else if (mantissa_c[4] ==  1)      
            shift_cnt = 19;  
        else if (mantissa_c[3] ==  1)      
            shift_cnt = 20;  
        else if (mantissa_c[2] ==  1)
            shift_cnt = 21;
        else if (mantissa_c[1] ==  1)      
            shift_cnt = 22;
                                                                 
        mantissa_c  = mantissa_c << shift_cnt;               
        flpout[31] = cout;
        flpout[30:23] = exponentB - shift_cnt;
        flpout[22:0] = mantissa_c[22:0];                                                                                 
   end 
   else if ( sign_a > sign_b) 
   begin
        {cout, mantissa_c} = mantissa_b - mantissa_a;
        if (cout == 1) begin
        mantissa_c = -mantissa_c;
        end
        
                if(mantissa_c[23] ==  1)
                    shift_cnt = 0;
                else if (mantissa_c[22] ==  1)
                    shift_cnt = 1;
                else if (mantissa_c[21] ==  1)
                    shift_cnt = 2;
                else if (mantissa_c[20] ==  1)
                    shift_cnt = 3;
                else if (mantissa_c[19] ==  1)
                    shift_cnt = 4;
                else if (mantissa_c[18] ==  1)
                    shift_cnt = 5;
                else if (mantissa_c[17] ==  1)
                    shift_cnt = 6;
                else if (mantissa_c[16] ==  1)
                    shift_cnt = 7;
                else if (mantissa_c[15] ==  1)
                    shift_cnt = 8;
                else if (mantissa_c[14] ==  1)
                    shift_cnt = 9;
                else if (mantissa_c[13] ==  1)
                    shift_cnt = 10;            
                else if (mantissa_c[12] ==  1)
                    shift_cnt = 11;
                else if (mantissa_c[11] ==  1)
                    shift_cnt = 12;
                else if (mantissa_c[10] ==  1)
                    shift_cnt = 13;
                else if (mantissa_c[9] ==  1)   
                    shift_cnt = 14;                    
                else if (mantissa_c[8] ==  1)    
                    shift_cnt = 15;                    
                else if (mantissa_c[7] ==  1)    
                    shift_cnt = 16;                    
                else if (mantissa_c[6] ==  1)
                    shift_cnt = 17;
                else if (mantissa_c[5] ==  1)      
                    shift_cnt = 18;  
                else if (mantissa_c[4] ==  1)      
                    shift_cnt = 19;  
                else if (mantissa_c[3] ==  1)      
                    shift_cnt = 20;  
                else if (mantissa_c[2] ==  1)
                    shift_cnt = 21;
                else if (mantissa_c[1] ==  1)      
                    shift_cnt = 22;
                                                                      
                 mantissa_c  = mantissa_c << shift_cnt;
                 flpout[31] = cout;
                 flpout[30:23] = exponentB - shift_cnt;
                 flpout[22:0] = mantissa_c[22:0];
   end     
   else
   begin         
	{cout, mantissa_c}  = mantissa_a + mantissa_b;
	if (cout == 1)
    begin
        {cout, mantissa_c}  = {cout, mantissa_c} >> 1;
        mantissa_b  = mantissa_b + 1;
    end
    flpout[31] = sign_a;
    flpout[30:23] = exponentB;
    flpout[22:0] = mantissa_c[22:0];
   end
	end
end
endmodule