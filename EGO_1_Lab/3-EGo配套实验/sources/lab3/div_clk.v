`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/29 22:22:36
// Design Name: 
// Module Name: div_clk
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

module div_clk(
	    input  clk,					//�ڲ�100Mʱ���ź�����
	    input rst_n,					//���帴λ�ź�
	    input  [14:0] N,				//����15λ��Ƶ������ͨ�����뿪�أ�
	    output clk_out					//��Ƶʱ���ź����
	    );
	    wire en_even,en_odd;
	    wire rst;
	    assign rst     = ~rst_n;
	    assign en_even = ~N[0];			//N[0]ȡ��������en_evenʹ��
	    assign en_odd  =  N[0];		//N[0]������en_oddʹ��
	    dive_clk e_clk(				//ż������Ƶ��e_clkʵ����
	        .clk(clk),
	        .rst(rst),
	        .en_even(en_even),
	        .N(N),
	        .clk_e(clk_e)
	 	);
	    divo_clk o_clk(				//��������Ƶ��o_clkʵ����
	        .clk(clk),
	        .rst(rst),
            .en_odd(en_odd),
	        .N(N),
	        .clka(clka),
	        .clkb(clkb),
	        .clk_o(clk_o)
	 	);
	    assign clk_out = clk_e | clk_o;  	//ȡclk_e��clk_o�е�ǰ��Ч�ź�Ϊ���
endmodule

