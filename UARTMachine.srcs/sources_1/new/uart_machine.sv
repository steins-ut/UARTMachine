`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 03:40:51 AM
// Design Name: 
// Module Name: uart_machine
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


module uart_machine #(parameter DATA_SIZE = 8, parameter STOP_SIZE = 2)(
    input logic clk,
    input logic load,
    input logic send,
    input logic switch_page_left,
    input logic switch_page_right,
    input logic switch_reg,
    input logic a_send,
    input logic RX,
    input logic [7:0] msg_in,
    output logic TX,
    output logic [7:0] led_txbuf,
    output logic current_reg_led,
    output logic [1:0] current_page_led,
    output logic [6:0] dsp_cathodes,
    output logic dsp_dp,
    output logic [3:0] dsp_anodes
    );
    localparam BAUD_RATE = 115200;
    localparam BAUD_CYCLE_COUNT = 1000000 * 100 / BAUD_RATE;
//    parameter BAUD_CYCLE_COUNT = 100;
    
    wire available;
    wire load_debounced, send_debounced, send_auto, send_final;
    wire page_left_debounced, page_right_debounced, reg_debounced;
    wire [DATA_SIZE - 1: 0] rx_page0, rx_page1;
    wire [DATA_SIZE - 1: 0] tx_page0, tx_page1;
    wire current_reg, current_page_offset;
    wire switch_page;
    wire [1:0] page_addr;
    
    button_debouncer db_load(.clk(clk), .button(load), .debounced(load_debounced));
    button_debouncer db_send(.clk(clk), .button(send), .debounced(send_debounced));
    button_debouncer db_page_left(.clk(clk), .button(switch_page_left), .debounced(page_left_debounced));
    button_debouncer db_page_right(.clk(clk), .button(switch_page_right), .debounced(page_right_debounced));
    button_debouncer db_reg(.clk(clk), .button(switch_reg), .debounced(reg_debounced));
 
    uart_receiver #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE))
    receiver(.clk(clk), .Baud_rate(BAUD_CYCLE_COUNT), .RX(RX), .display(),
        .RXBUF_addr1(page_addr), .RXBUF_addr2(page_addr + 1), .RXBUF_page1(rx_page0), .RXBUF_page2(rx_page1));
    
    uart_transmitter #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE))
    transmitter(.clk(clk), .Baud_rate(BAUD_CYCLE_COUNT), .load(load_debounced), .send(send_final), .msg(msg_in[DATA_SIZE - 1: 0]), .TX(TX), .display(led_txbuf),
        .TXBUF_addr1(page_addr), .TXBUF_addr2(page_addr + 1), .TXBUF_page1(tx_page0), .TXBUF_page2(tx_page1), .available(available));

//    uart_receiver #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE))
//    receiver(.clk(clk), .Baud_rate(BAUD_CYCLE_COUNT), .RX(RX), .display(),
//        .RXBUF_addr1(0), .RXBUF_addr2(1), .RXBUF_page1(rx_page0), .RXBUF_page2(rx_page1));
        
//    uart_transmitter #(.DATA_SIZE(DATA_SIZE), .STOP_SIZE(STOP_SIZE))
//    transmitter(.clk(clk), .Baud_rate(BAUD_CYCLE_COUNT), .load(load), .send(send), .msg(msg_in), .TX(TX), .display(led_txbuf),
//        .TXBUF_addr1(0), .TXBUF_addr2(1), .TXBUF_page1(tx_page0), .TXBUF_page2(tx_page1));

    register_file_viewer file_viewer(.clk(clk), .switch_page(switch_page), .switch_reg(reg_debounced), 
    .page0_reg0(tx_page0), .page1_reg0(tx_page1), .page0_reg1(rx_page0), .page1_reg1(rx_page1), 
    .current_reg(current_reg), .current_page_offset(current_page_offset), 
    .dsp_cathodes(dsp_cathodes), .dsp_dp(dsp_dp), .dsp_anodes(dsp_anodes));
    
    auto_send auto(.clk(clk), .send(send_debounced), .flag(available), .target(send_auto));
    
    assign send_final = (send_auto && a_send) || send_debounced;
    assign switch_page = page_left_debounced || page_right_debounced;
    assign current_reg_led = current_reg;
    assign current_page_led = current_page_offset ? 2'b01 : 2'b10;
    assign page_addr = current_page_offset ? 2 : 0;
    
endmodule
