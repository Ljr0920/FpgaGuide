`timescale 1 ns / 1 ns


module top_flyinglogo(clk, rst_n, hsync, vsync, vga_r, vga_g, vga_b);
   input           clk;
   input           rst_n;
   
   output          hsync;
   output          vsync;
   output [3:0]    vga_r;
   output [3:0]    vga_g;
   output [3:0]    vga_b;
   
   wire            rst;
   assign rst =   ~rst_n;
   
   wire            pclk;
   wire            valid;
   wire [9:0]      h_cnt;
   wire [9:0]      v_cnt;
   reg [11:0]       vga_data;
   
   reg [13:0]      rom_addr;
   wire [11:0]      douta;
   
   wire            logo_area;
   reg [9:0]       logo_x;
   reg [9:0]       logo_y;
   parameter [9:0] logo_length = 10'b0001000110;
   parameter [9:0] logo_hight  = 10'b0001000110;
   
   reg [7:0]       speed_cnt;
   wire            speed_ctrl;
   
   reg [3:0]       flag_edge;
   
   reg     [3:0] OutData [4899:0];  
          reg     finish;
          reg [13:0] out_addr;
      
      reg [2:0]       state,nextstate;
      
      reg     [2:0]        Row, Col;     // 5*5 Index's Row and Col          
      reg     [1:0]        flag;       
      reg     [1:0]        IntSignal;  
      reg     finish;
      reg     [8:0]    bRow,bCol;      // operating pixel's Row and Col
      wire     [11:0]     InData; 
      reg     hold;       
      
      reg     [3:0]    Out_gradient;      
      reg      [31:0]         Gx, Gy;

	  dcm_25m u0
         (
         // Clock in ports
          .clk_in1(clk),      // input clk_in1
          // Clock out ports
          .clk_out1(pclk),     // output clk_out1
          // Status and control signals
          .reset(rst));   
	
	logo_rom u1 (
                    .clka(pclk),    // input wire clka
                    .addra(rom_addr),  // input wire [13 : 0] addra
                    .douta(InData)  // output wire [11 : 0] douta
                         );

 
	vga_640x480 u2 (
		.pclk(pclk), 
		.reset(rst), 
		.hsync(hsync), 
		.vsync(vsync), 
		.valid(valid), 
		.h_cnt(h_cnt), 
		.v_cnt(v_cnt)
		);
		
	
           reg     [3:0]     regX[0:24];    // Index = Row*5+Col // Index <= [5][5]
           
           parameter                   S0=2'b00;  //load data from ram
           parameter                   S1=2'b01;  //transfer InData to regX,regY,regZ
           parameter                   S2=2'b10;  //pixels operating
           parameter                   S3=2'b11;  //save data to OutData
           
           always @(posedge pclk,posedge rst)
             begin
               if (rst == 1'b1) 
                 state <= S0;
               else 
                 state <= nextstate;
             end
           
           always @(*)
             case(state)
               S0:
                 if(flag == 2'b00)
                    nextstate=S1;
                 else 
                    nextstate=S0;
               S1:
                 if(flag == 2'b10)
                    nextstate=S2;
                 else if(flag == 2'b00)
                    nextstate=S0;
                 else 
                    nextstate=S1;
                S2:
                  if(flag == 2'b11) 
                    nextstate=S3;
                  else 
                    nextstate=S2;
                S3:
                  if(flag == 2'b00)
                    nextstate=S0;
                  else
                    nextstate=S3;
                
               default nextstate=S0;
             endcase
           
                 
           always @(posedge pclk or negedge rst)
                 begin
                     if(rst == 1'b1) 
                       begin
                         IntSignal <= 2'b00;
                         flag <= 2'b00;
                         bRow <= 2'b11;
                         bCol <= 2'b11;
                         Col <= 1'b0;
                         Row <= 1'b0;
                         rom_addr <= 1'b0;
                         finish <= 1'b0;
                         hold <= 1'b0;
                       end
                 
                     else if(finish == 0)
                       begin
                       case(state)
                         S0:                                           //load data from rom
                           begin
                             if(Col < 5 && Row < 5)
                               begin
                                 rom_addr <= 70*(bRow-3+Row)+(bCol-3+Col);    
                                 Col <= Col+1;
                                 flag <= 2'b01;
                               end
                                       
                             if(Col == 4)
                               begin
                                 Row <= Row+1;
                                 Col <= 0;
                               end
                                      
                             if(Row == 4 && bRow < 69)
                               begin
                                 Row <= 0;
                                 bCol <= bCol+1;
                                 flag <= 2'b10;
                               end
                                           
                             if(bCol == 69)
                               begin
                                 bCol <= 0;
                                 bRow <= bRow+1;
                               end
                                       
                             if(bRow == 69)
                               begin
                                 bRow <= 0;
                                 finish <= 1;                              //finish operation
                               end
                           end
                           
                         S1:                                            //transfer data to regX
                           begin
                             if (hold == 1'b0)
                               hold <= 1'b1;
                             else 
                               begin
                                 regX[Row*5+Col] <= InData[3:0];
                                 flag <= 2'b00;
                                 hold <= 1'b0;
                               end  
                           end
                         
                         S2:                                            //data operating
                           begin
                                 if(IntSignal == 2'b00)    
                                   begin
                                     // Calculate Gradiant for X and Y
                                     //Gx <= ;
                                     //Gy <= ;
                                     Gx <= (-regX[0]+regX[2]-2*regX[5]+2*regX[7]-regX[10]+regX[12]);
                                     Gy <= (regX[0]+2*regX[1]+regX[2]-regX[10]-2*regX[11]-regX[12]);
                                     IntSignal <= 2'b01;
                                   end
                                 else if(IntSignal == 2'b01) 
                                   begin
                                     //|G| = (|Gx|+|Gy|)/8
                                     if( Gx>=0 && Gy>=0)
                                       begin
                                         Out_gradient <= (Gx+Gy)>>3;
                                       end
                                     else if( Gx<0 && Gy>=0)
                                       begin
                                         Out_gradient <= (Gy-Gx)>>3;
                                       end
                                     else if( Gx>=0 && Gy<0)
                                       begin
                                         Out_gradient <= (Gx-Gy)>>3;
                                       end
                                     else
                                       begin
                                         Out_gradient <= (-Gy-Gx)>>3;
                                       end
                                     IntSignal <= 2'b10;
                                   end
                                 else
                                   begin
                                     flag <= 2'b11;
                                     IntSignal <= 2'b00;
                                   end 
                           end     
                      
                       S3:                                            //save operated data to output
                         begin  
                           OutData[rom_addr] <= Out_gradient;
                           flag <= 2'b00;
                         end
                     endcase
                     end
                 end

 
   assign logo_area = ((v_cnt >= logo_y) & (v_cnt <= logo_y + logo_hight - 1) & (h_cnt >= logo_x) & (h_cnt <= logo_x + logo_length - 1)) ? 1'b1 : 
                      1'b0;
   
   
   always @(posedge pclk)
   begin: logo_display
      if (rst == 1'b1)
         vga_data <= 12'b000000000000;
      else 
      begin
         if (valid == 1'b1)
         begin
            if (logo_area == 1'b1)
            begin
               out_addr <= out_addr + 14'b00000000000001;
               if(OutData[out_addr]>= 1'b1)
                 vga_data <= 12'b111111111111;
               else
                 vga_data <= 12'b000000000000;
            end
            else
            begin
               out_addr <= out_addr;
               vga_data <= 12'b000000000000;
            end
         end
         else
         begin
            vga_data <= 12'b111111111111;
            if (v_cnt == 0)
               out_addr <= 14'b00000000000000;
         end
      end
   end
   
   assign vga_r = vga_data[11:8];
   assign vga_g = vga_data[7:4];
   assign vga_b = vga_data[3:0];
   
   
   always @(posedge pclk)
   begin: speed_control
      if (rst == 1'b1)
         speed_cnt <= 8'h00;
      else 
      begin
         if ((v_cnt[5] == 1'b1) & (h_cnt == 1))
            speed_cnt <= speed_cnt + 8'h01;
      end
   end
   
   
   debounce u3(.sig_in(speed_cnt[5]), .clk(pclk), .sig_out(speed_ctrl));
   
   
   always @(posedge pclk)
   begin: logo_move
      
      reg [1:0]       flag_add_sub;
      
      if (rst == 1'b1)
      begin
         flag_add_sub = 2'b01;
         
         logo_x <= 10'b0110101110;
         logo_y <= 10'b0000110010;
      end
      else 
      begin
         
         if (speed_ctrl == 1'b1)
         begin
            if (logo_x == 1)
            begin
               if (logo_y == 1)
               begin
                  flag_edge <= 4'h1;
                  flag_add_sub = 2'b00;
               end
               else if (logo_y == 480 - logo_hight)
               begin
                  flag_edge <= 4'h2;
                  flag_add_sub = 2'b01;
               end
               else
               begin
                  flag_edge <= 4'h3;
                  flag_add_sub[1] = (~flag_add_sub[1]);
               end
            end
            
            else if (logo_x == 640 - logo_length)
            begin
               if (logo_y == 1)
               begin
                  flag_edge <= 4'h4;
                  flag_add_sub = 2'b10;
               end
               else if (logo_y == 480 - logo_hight)
               begin
                  flag_edge <= 4'h5;
                  flag_add_sub = 2'b11;
               end
               else
               begin
                  flag_edge <= 4'h6;
                  flag_add_sub[1] = (~flag_add_sub[1]);
               end
            end
            
            else if (logo_y == 1)
            begin
               flag_edge <= 4'h7;
               flag_add_sub[0] = (~flag_add_sub[0]);
            end
            else if (logo_y == 480 - logo_hight)
            begin
               flag_edge <= 4'h8;
               flag_add_sub[0] = (~flag_add_sub[0]);
            end
            else
            begin
               flag_edge <= 4'h9;
               flag_add_sub = flag_add_sub;
            end
            
            case (flag_add_sub)
               2'b00 :
                  begin
                     logo_x <= logo_x + 10'b0000000000;
                     logo_y <= logo_y + 10'b0000000000;
                  end
               2'b01 :
                  begin
                     logo_x <= logo_x + 10'b0000000000;
                     logo_y <= logo_y - 10'b0000000000;
                  end
               2'b10 :
                  begin
                     logo_x <= logo_x - 10'b0000000000;
                     logo_y <= logo_y + 10'b0000000000;
                  end
               2'b11 :
                  begin
                     logo_x <= logo_x - 10'b0000000000;
                     logo_y <= logo_y - 10'b0000000000;
                  end
               default :
                  begin
                     logo_x <= logo_x + 10'b0000000001;
                     logo_y <= logo_y + 10'b0000000001;
                  end
            endcase
         end
         
      end
   end
	
endmodule
