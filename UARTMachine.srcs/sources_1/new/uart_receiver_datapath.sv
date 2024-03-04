`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 05:39:27 PM
// Design Name: 
// Module Name: uart_receiver_datapath
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


module uart_receiver_datapath
#(parameter DATA_SIZE = 8, parameter STOP_SIZE = 2)(
    input logic clk,
    input logic [31:0] Baud_rate_us,
    input logic RX,
    input logic [1:0] RXBUF_addr1,
    input logic [1:0] RXBUF_addr2,
    input logic half_baud,
    input logic T_ld,
    input logic T_en,
    input logic T_rst,
    input logic buf_ld,
    input logic buf_clr,
    input logic msg_ld,
    input logic msg_clr,
    input logic stop_ld,
    input logic stop_clr,
    output logic T_Q,
    output logic loop_msg,
    output logic loop_stop,
    output logic [DATA_SIZE - 1: 0] display,
    output logic [DATA_SIZE - 1: 0] RXBUF_page1,
    output logic [DATA_SIZE - 1: 0] RXBUF_page2
    );
    wire [31:0] _T, _Thalf;
    wire [DATA_SIZE - 1: 0] _RXBUF, _RXBUFshift;
    wire [$clog2(DATA_SIZE) - 1: 0] _r_buf_cnt, _r_buf_cnt_add;
    wire [$clog2(STOP_SIZE) - 1: 0] _r_stop_cnt, _r_stop_cnt_add;
    
    right_shifter #(.WIDTH(32), .SHIFT_AMOUNT(1)) Baud_shift(.in(Baud_rate_us), .sh_in(0), .out(_Thalf));
    mux_2x1 #(.WIDTH(32)) half_mux(.I0(Baud_rate_us), .I1(_Thalf), .S(half_baud), .Y(_T));
    timer T(.clk(clk), .M_us(_T), .ld(T_ld), .en(T_en), .rst(T_rst), .clr(0), .Q(T_Q));
    
    right_shifter #(.WIDTH(DATA_SIZE), .SHIFT_AMOUNT(1)) RXBUF_shift(.in(_RXBUF), .sh_in(RX), .out(_RXBUFshift));
    register #(.SIZE(DATA_SIZE)) TMP_BUF(.clk(clk), .ld(buf_ld), .clr(buf_clr), .D(_RXBUFshift), .Q(_RXBUF));
    
    fifo_register_file #(.WIDTH(DATA_SIZE), .DEPTH(4)) RXBUF(.clk(clk), .in(_RXBUF), .r_addr(3), .ld(msg_ld), .clr(msg_clr), .discard(display),
                        .r_addr1(RXBUF_addr1), .r_addr2(RXBUF_addr2), .out1(RXBUF_page1), .out2(RXBUF_page2));
    
    compare_less #(.SIZE($clog2(DATA_SIZE))) r_buf_cnt_lt(.lhs(_r_buf_cnt), .rhs(DATA_SIZE - 1), .lt(loop_msg));
    adder #(.SIZE($clog2(DATA_SIZE))) r_buf_cnt_inc(.lhs(_r_buf_cnt), .rhs(1), .sum(_r_buf_cnt_add));
    register #(.SIZE($clog2(DATA_SIZE))) r_buf_cnt(.clk(clk), .ld(buf_ld), .clr(buf_clr), .D(_r_buf_cnt_add), .Q(_r_buf_cnt));
    
    compare_less #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt_lt(.lhs(_r_stop_cnt), .rhs(STOP_SIZE - 1), .lt(loop_stop));
    adder #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt_inc(.lhs(_r_stop_cnt), .rhs(1), .sum(_r_stop_cnt_add));
    register #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt(.clk(clk), .ld(stop_ld), .clr(stop_clr), .D(_r_stop_cnt_add), .Q(_r_stop_cnt));
endmodule
