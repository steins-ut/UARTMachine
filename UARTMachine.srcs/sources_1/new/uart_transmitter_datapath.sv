`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 10:56:39 PM
// Design Name: 
// Module Name: uart_transmitter_datapath
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


module uart_transmitter_datapath
#(parameter DATA_SIZE = 8, parameter STOP_SIZE = 2)(
    input logic clk,
    input logic [31:0] Baud_rate_us,
    input logic [DATA_SIZE - 1:0] msg,
    input logic [1:0] TXBUF_addr1,
    input logic [1:0] TXBUF_addr2,
    input logic T_ld,
    input logic T_en,
    input logic T_rst,
    input logic file_ld,
    input logic file_psh,
    input logic msg_ld,
    input logic msg_clr,
    input logic msg_shf,
    input logic cnt_msg,
    input logic cnt_stop,
    input logic clr_msg_cnt,
    input logic clr_stop_cnt,
    input logic send_s_0,
    input logic send_s_1,
    output logic loop_msg,
    output logic loop_stop,
    output logic T_Q,
    output logic TX,
    output logic [DATA_SIZE - 1: 0] display,
    output logic [DATA_SIZE - 1: 0] TXBUF_page1,
    output logic [DATA_SIZE - 1: 0] TXBUF_page2
    );
    wire [DATA_SIZE - 1:0] _TXBUF, _TXBUFmux, _TXBUFshift;
    wire [DATA_SIZE - 1:0] _SEND_BUFmux;
    wire _TXBUFsh_out;
    wire [DATA_SIZE - 1:0] _msgmux;
    wire [DATA_SIZE - 1:0] _discard;
    wire [$clog2(DATA_SIZE) - 1:0] _r_msg_cnt, _r_msg_cnt_add;
    wire [$clog2(STOP_SIZE) - 1:0] _r_stop_cnt, _r_stop_cnt_add;

    timer T(.clk(clk), .M_us(Baud_rate_us), .ld(T_ld), .en(T_en), .rst(T_rst), .clr(0), .Q(T_Q));

    right_shifter #(.WIDTH(DATA_SIZE), .SHIFT_AMOUNT(1)) shifter(.in(_TXBUF), .sh_in(0), .out(_TXBUFshift), .sh_out(_TXBUFsh_out));
    mux_2x1 #(.WIDTH(DATA_SIZE)) mux_TXBUF(msg, _TXBUFshift, msg_shf, _TXBUFmux);
    
    mux_2x1 #(.WIDTH(DATA_SIZE)) mux_file(msg, 0, file_psh, _msgmux);
    mux_2x1 #(.WIDTH(DATA_SIZE)) mux_SEND_BUF(_TXBUFmux, _discard, ~cnt_msg, _SEND_BUFmux);
    fifo_register_file #(.WIDTH(DATA_SIZE), .DEPTH(4)) TXBUF(.clk(clk), .in(_msgmux), .r_addr(0), .ld(file_ld), .clr(msg_clr), .out(display), .discard(_discard),
                        .r_addr1(TXBUF_addr1), .r_addr2(TXBUF_addr2), .out1(TXBUF_page1), .out2(TXBUF_page2));
                        
    register #(.SIZE(DATA_SIZE)) SEND_BUF(.clk(clk), .ld(msg_ld), .clr(msg_clr), .D(_SEND_BUFmux), .Q(_TXBUF));
    
    mux_4x1 #(.WIDTH(1)) mux_send(1, 0, _TXBUFsh_out, 1, {send_s_1, send_s_0}, TX);

    compare_less #(.SIZE($clog2(DATA_SIZE))) r_msg_cnt_lt(.lhs(_r_msg_cnt), .rhs(DATA_SIZE - 1), .lt(loop_msg));
    adder #(.SIZE($clog2(DATA_SIZE))) r_msg_cnt_inc(.lhs(_r_msg_cnt), .rhs(1), .sum(_r_msg_cnt_add));
    register #(.SIZE($clog2(DATA_SIZE))) r_msg_cnt(.clk(clk), .ld(cnt_msg), .clr(clr_msg_cnt), .D(_r_msg_cnt_add), .Q(_r_msg_cnt));

    compare_less #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt_lt(.lhs(_r_stop_cnt), .rhs(STOP_SIZE - 1), .lt(loop_stop));
    adder #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt_inc(.lhs(_r_stop_cnt), .rhs(1), .sum(_r_stop_cnt_add));
    register #(.SIZE($clog2(STOP_SIZE))) r_stop_cnt(.clk(clk), .ld(cnt_stop), .clr(clr_stop_cnt), .D(_r_stop_cnt_add), .Q(_r_stop_cnt));
endmodule
