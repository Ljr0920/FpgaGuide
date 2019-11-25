//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Sat Oct 22 01:53:11 2016
//Host        : DESKTOP-C1B76IV running 64-bit major release  (build 9200)
//Command     : generate_target System_wrapper.bd
//Design      : System_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module System_wrapper
   (clk,
    led_tri_o,
    uart_rtl_rxd,
    uart_rtl_txd);
  input clk;
  output [7:0]led_tri_o;
  input uart_rtl_rxd;
  output uart_rtl_txd;

  wire clk;
  wire [7:0]led_tri_o;
  wire uart_rtl_rxd;
  wire uart_rtl_txd;

  System System_i
       (.clk(clk),
        .led_tri_o(led_tri_o),
        .uart_rtl_rxd(uart_rtl_rxd),
        .uart_rtl_txd(uart_rtl_txd));
endmodule
