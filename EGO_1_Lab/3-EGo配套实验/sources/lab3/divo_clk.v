`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/29 22:28:05
// Design Name: 
// Module Name: divo_clk
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


	module divo_clk(
	    input  clk,
	    input rst,
	    input en_odd,
	    input  [14:0]N,
	    output reg clka,clkb,
	    output wire clk_o
	    );
	    integer cnt1;
	    integer cnt2;
	    assign clk_o = clka | clkb;				//clka��clkb��λ�ࡰ��
	    always @(posedge clk or posedge rst)    //clk�����غ�rst�����ش��� 
	    begin
	        if (rst)					//rstΪ1��λ
	        begin
	            clka <= 1'b0; 			//����clk�����ش�������ź�clka��ֵΪ0 
	            cnt1 <= 0;      		//���ü�����cnt1��λֵΪ0
	        end
	        else
	        begin
	            if (en_odd)			//en_oddʹ���ź�Ϊ�ߣ�ִ�����Ƶ
	            begin
	                if (cnt1 == 0)     //cnt1Ϊ0ʱ��clkaȡ0��cnt1ȡN-1
	                begin
	                    clka <= 1'b0; 
	                    cnt1 <= N-1; 
	                end
	                else if (cnt1 > (N-1)/2 )     //cnt����(N-1)/2ʱ
	                    begin               //clkaȡ1��cnt1�Լ�һ
	                        clka <= 1'b1;
	                        cnt1 <=cnt1-1;
	                    end 
	                    else					//cntС�ڻ����(N-1)/2
	                    begin				//clkaȡ0��cnt1�Լ�һ
	                        clka <= 1'b0;
	                        cnt1 <=cnt1-1;
	                    end 
	            end 
	            else						// en_oddʹ��Ϊ�ͣ�clka�ź�ʼ��Ϊ0
	            begin
	                clka <= 1'b0;
	                cnt1 <= N-1;
	            end
	        end 
	    end 
	    ////////////////////////////////////////////////////////////////////////////////////////////
	    always @(negedge clk or posedge rst)	//clk�½��أ�rst�����ش���
	    begin
	        if (rst)
	        begin
	            clkb <= 1'b0; 
	            cnt2 <= 0;
	        end
	        else
	        begin
	            if (en_odd)
	            begin
	                if (cnt2 == 0)
	                begin
	                    clkb <= 1'b0;
	                    cnt2 <=N-1; 
	                end
	                else if (cnt2 > (N-1)/2 ) 
	                    begin
	                        clkb <= 1'b1;
	                        cnt2<=cnt2-1;
	                    end 
	                    else
	                    begin
	                        clkb <= 1'b0;
	                        cnt2<=cnt2-1;
	                    end
	            end
	            else
	            begin
	                clkb <= 1'b0;
	                cnt2 <= N-1;
	            end
	        end
	    end
endmodule

