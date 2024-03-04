`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 03:40:51 AM
// Design Name: 
// Module Name: uart_transmitter
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
module uart_transmitter 
#(parameter DATA_SIZE = 8, parameter STOP_SIZE = 2)(
    input logic clk,
    input logic [31:0] Baud_rate,
    input logic load,
    input logic send,
    input logic [7:0] msg,
    input logic [1:0] TXBUF_addr1,
    input logic [1:0] TXBUF_addr2,
    output logic available,
    output logic TX,
    output logic [7:0] display,
    output logic [7:0] TXBUF_page1,
    output logic [7:0] TXBUF_page2
    );
    wire _loop_msg, _cnt_msg, _clr_msg_cnt;
    wire _loop_stop, _cnt_stop, _clr_stop_cnt;
    wire _T_Q, _T_ld, _T_en, _T_rst;
    wire _file_ld, _file_psh;
    wire _msg_ld, _msg_clr, _msg_shf;
    wire _send_s_0, _send_s_1;
    wire [2:0] _S;

    uart_transmitter_controller controller(.clk(clk),
        .reset(0),
        .load(load),
        .send(send),
        .loop_msg(_loop_msg),
        .loop_stop(_loop_stop),
        .T_Q(_T_Q),
        .T_ld(_T_ld),
        .T_en(_T_en),
        .T_rst(_T_rst),
        .file_ld(_file_ld),
        .file_psh(_file_psh),
        .msg_ld(_msg_ld),
        .msg_clr(_msg_clr),
        .msg_shf(_msg_shf),
        .cnt_msg(_cnt_msg),
        .clr_msg_cnt(_clr_msg_cnt),
        .cnt_stop(_cnt_stop),
        .clr_stop_cnt(_clr_stop_cnt),
        .send_s_0(_send_s_0),
        .send_s_1(_send_s_1),
        .available(available),
        .S(_S)
    );

    uart_transmitter_datapath #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE)) 
    datapath(.clk(clk),
        .msg(msg),
        .TXBUF_addr1(TXBUF_addr1),
        .TXBUF_addr2(TXBUF_addr2),
        .Baud_rate_us(Baud_rate),
        .loop_msg(_loop_msg),
        .loop_stop(_loop_stop),
        .T_Q(_T_Q),
        .T_ld(_T_ld),
        .T_en(_T_en),
        .T_rst(_T_rst),
        .file_ld(_file_ld),
        .file_psh(_file_psh),
        .msg_ld(_msg_ld),
        .msg_clr(_msg_clr),
        .msg_shf(_msg_shf),
        .cnt_msg(_cnt_msg),
        .clr_msg_cnt(_clr_msg_cnt),
        .cnt_stop(_cnt_stop),
        .clr_stop_cnt(_clr_stop_cnt),
        .send_s_0(_send_s_0),
        .send_s_1(_send_s_1),
        .TX(TX),
        .display(display),
        .TXBUF_page1(TXBUF_page1),
        .TXBUF_page2(TXBUF_page2)
    );
endmodule
