`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/29 17:23:43
// Design Name: 
// Module Name: flash_led_ctl
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


module flash_led_ctl(
 	 	input clk,
 	 	input rst,
 	 	input s0,
 	 	input clk_bps,
 	 	output reg[15:0]led
 	 	);
 	    reg mode1;
 	 	reg[3:0] flag1,flag2;
 	 	reg [3:0]cnt;
                               
 	 	
 	 	always @( posedge clk or posedge rst )
 	 	  begin
 	 	    if(flag1==4'b1001)
              flag1<=4'b0000;          
            
            if(s0)
              cnt<=cnt+4'b0001;
              
            if(cnt==4'b1111)
              begin
                cnt<=4'b0000;
                flag1<= flag1+4'b0001;
              end 
              
 	 	    if(led==16'hffff)         //如果全亮则mode1为1
              mode1<=1;
            else if(led==16'h0000)    //如果全灭则mode1为0
              mode1<=0;
              
 	 		if( rst )
 	 		  begin
 	 			led <= 16'h0000;
 	 			flag1<=4'b0000;
 	 			flag2<=4'b0000;
 	 			mode1<=0;
 	 	      end
 	 	    else if(flag2!=flag1)
 	 	        begin
 	 	          flag2<=flag1;
 	 	          case(flag1)
 	 	            4'b0000:
 	 	                led<=16'h0000;
 	 	            4'b0001:
 	 	                led<=16'h8000;
 	 	            4'b0010:
 	 	                led<=16'h0001;
 	 	            4'b0011:
 	 	                led<=16'h0180;
 	 	            4'b0100:
 	 	                led<=16'h8001;
 	 	            4'b0101:
 	 	              begin
 	 	                led<=16'h8000;
 	 	                mode1<=0;
 	 	              end
 	 	            4'b0110:
 	 	              begin
 	 	                led<=16'h0180;
 	 	                mode1<=0;
 	 	              end
 	 	            4'b0111:
 	 	              begin
 	 	                led<=16'h8001;
 	 	                mode1<=0;
 	 	              end
 	 	            4'b1000:
 	 	                led<=16'h0000;
 	 	          endcase       
 	 	        end     	        
 	 		else 
 	 			case( flag1 )
 	 				4'b0000:  			 
 	 					led <= 16'h0000;
 	 				4'b0001:  			 
 	 			 		if( clk_bps )
 	 						if( led != 16'h0001 )
 	 							led <= led >> 1'b1;
 	 						else
 	 							led <= 16'h8000;
 	 				4'b0010:
 	 				   if( clk_bps )
                              if( led != 16'h8000 )
                                led <= led << 1'b1;
                              else
                                led <= 16'd1;

 	 				4'b0011:                                                         //模式3
 	 				    if( clk_bps )                                                //当clk_bps有效
 	 				        if( led != 16'h8001 )                                    //如果未到最左最右
 	 				            begin
 	 				              led[15:8] <= led[15:8] << 1'b1;                    //左八位向左移
 	 				              led[7:0] <= led[7:0] >> 1'b1;                      //右八位向右移
 	 				            end
 	 				         else
 	 				            led <= 16'h0180;                                     //如果到了最左最右则重新开始
 	 				4'b0100:
 	 				     if( clk_bps )
                            if( led != 16'h0180 )
                                begin
                                  led[15:8] <= led[15:8] >> 1'b1;
                                  led[7:0] <= led[7:0] << 1'b1;
                                end
                            else
                               led <= 16'h8001;
                    4'b0101:                                           //模式5
                          if( clk_bps )                                //如果clk_bps有效
                                begin
                                  if(mode1==0)                         //如果mode1为0
                                    led <= (led>>1'b1)+16'h8000;       //实现向右依次点亮
                                  else if(mode1==1)                    //如果mode1为1
                                    led <= led<<1'b1;                  //实现向左依次点亮
                                end
                    4'b0110:
                          if( clk_bps )
                                begin
                                  if(mode1==0)
                                    begin
                                      led[15:8] <= (led[15:8]<<1'b1)+8'b00000001;
                                      led[7:0] <= (led[7:0]>>1'b1)+8'b10000000;
                                    end
                                  else if(mode1==1)
                                    begin
                                      led[15:8] <= led[15:8]>>1'b1;
                                      led[7:0] <= led[7:0]<<1'b1;
                                    end
                                end
                    4'b0111:
                          if(clk_bps )
                                begin
                                  if(mode1==0)
                                    begin
                                      led[15:8] <= (led[15:8]>>1'b1)+8'b10000000;
                                      led[7:0] <= (led[7:0]<<1'b1)+8'b00000001;
                                    end
                                  if(mode1==1)
                                    begin
                                      led[15:8] <= led[15:8]<<1'b1;
                                      led[7:0] <= led[7:0]>>1'b1;
                                    end
                                 end
                     4'b1000:
                           if(clk_bps)
                                 led <= ~led;
                endcase              
          end                                             	 				     
 	 				    
endmodule



