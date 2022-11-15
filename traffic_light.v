module traffic_light( output reg [2:0] light_highway, output reg [2:0] light_farm, input S,input clk, input rst);
  
  reg[1:0] current_state, next_state;
  reg [2:0] count =0;

  
  
  localparam [1:0] highG_farmR=2'b00, 
   highY_farmR = 2'b01,
   highR_farmG=2'b10,
   highR_farmY=2'b11;
  
  
  always @(posedge clk or negedge rst)
begin
  if(~rst) begin
 current_state <= 2'b00;
  count <= 0 ;
  end
else begin
  
  	if(current_state == highY_farmR || current_state == highR_farmY)
		  count <= count + 1;
   if(current_state == highY_farmR && count == 3 )
    count <= 0;

   if(current_state == highR_farmY && count == 3 )
    count <= 0;

	 
	 current_state <= next_state; 
	end
end
  
  always @(current_state , S ,count)begin

case(current_state)
  
highG_farmR: 
  begin
 light_highway <= 3'b001;
 light_farm <= 3'b100;
  
  if(S) 
   next_state <= highY_farmR; 
  
 else next_state <=highG_farmR;
    end
  
  
  highY_farmR : 
    begin
      light_highway <= 3'b010;
      light_farm <= 3'b100;
  
      if (count == 3)begin
        next_state <= highR_farmG;
        
      end
      else
        next_state <=  highY_farmR;
    end
       
   highR_farmG :
     begin
      light_highway <= 3'b100;
      light_farm <= 3'b001; 
    
       
       if (S == 0)
         next_state <= highR_farmY ;
       else
         next_state <= highR_farmG ; 
     end
  
  
  highR_farmY :
    begin
      light_highway <= 3'b100;
      light_farm <= 3'b010; 
    
       
      if (count == 3)begin
        next_state <= highG_farmR ;
      
    end
      else
        next_state <= highR_farmY ; 
    end
    
      endcase
    
    end
      
      
      endmodule
  
  
  
  
