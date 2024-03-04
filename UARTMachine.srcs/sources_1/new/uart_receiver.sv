`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 03:40:51 AM
// Design Name: 
// Module Name: uart_receiver
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


module uart_receiver
#(parameter DATA_SIZE = 8, parameter STOP_SIZE = 2)
 (
    input logic clk,
    input logic [31:0] Baud_rate,
    input logic RX,
    input logic [1:0] RXBUF_addr1,
    input logic [1:0] RXBUF_addr2,
    output logic [DATA_SIZE - 1: 0] display,
    output logic [DATA_SIZE - 1: 0] RXBUF_page1,
    output logic [DATA_SIZE - 1: 0] RXBUF_page2
    );
    wire _loop_msg, _loop_stop;
    wire _half_baud;
    wire _T_Q;
    wire _T_ld, _T_en, _T_rst;
    wire _buf_ld, _buf_clr;
    wire _msg_ld, _msg_clr;
    wire _stop_ld, _stop_clr;
    wire [3:0] _S;
    
    uart_receiver_controller controller(.clk(clk),
        .reset(0),
        .RX(RX),
        .loop_msg(_loop_msg),
        .loop_stop(_loop_stop),
        .T_Q(_T_Q),
        .half_baud(_half_baud),
        .T_ld(_T_ld),
        .T_en(_T_en),
        .T_rst(_T_rst),
        .buf_ld(_buf_ld),
        .buf_clr(_buf_clr),
        .msg_ld(_msg_ld),
        .msg_clr(_msg_clr),
        .stop_ld(_stop_ld),
        .stop_clr(_stop_clr),
        .S(_S));
        
    uart_receiver_datapath #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE)) 
    datapath(.clk(clk),
        .Baud_rate_us(Baud_rate - 5),
        .RX(RX),
        .RXBUF_addr1(RXBUF_addr1),
        .RXBUF_addr2(RXBUF_addr2),
        .half_baud(_half_baud),
        .T_ld(_T_ld),
        .T_en(_T_en),
        .T_rst(_T_rst),
        .buf_ld(_buf_ld),
        .buf_clr(_buf_clr),
        .msg_ld(_msg_ld),
        .msg_clr(_msg_clr),
        .stop_ld(_stop_ld),
        .stop_clr(_stop_clr),
        .T_Q(_T_Q),
        .loop_msg(_loop_msg),
        .loop_stop(_loop_stop),
        .display(display),
        .RXBUF_page1(RXBUF_page1),
        .RXBUF_page2(RXBUF_page2)
        );
endmodule
