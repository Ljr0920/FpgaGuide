`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/29 22:26:19
// Design Name: 
// Module Name: dive_clk
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


module dive_clk(
	    input clk,
	    input rst,
	    input en_even,
	    input [14:0]N,	
	    output reg clk_e
	    ); 
	    integer cnt; 
	    always @(posedge clk or posedge rst)	//clk�����ء�rst�����ش��� 
	        if (rst)					//rstΪ1��λ
	        begin
	            cnt <= 0;			//���ü�����cnt��λֵΪ0
	            clk_e <= 1'b0;		//����ż������Ƶ����ź�clk_e��ֵΪ0
	        end
	        else
	        begin
	            if (en_even)			//en_evenʹ���ź�Ϊ�ߣ�ִ��ż��Ƶ
	            begin 
	                if (cnt == 0) 		//cntΪ0ʱ��clk_e��ת��������ȡN/2-1
	                    begin 
	                        clk_e  <= ~clk_e;
	                        cnt    <= N/2-1; 
	                    end 
	                else				//cnt��0ʱ��clk_e���֣���������һ
	                    begin
	                        clk_e  <= clk_e; 
	                        cnt    <= cnt - 1'b1; 
	                    end
	            end
	            else					// en_evenʹ��Ϊ�ͣ�����ź�ʼ��Ϊ0��
	                begin 
	                clk_e  <= 1'b0;
	                cnt    <= 0;
	            end
	        end 
endmodule

