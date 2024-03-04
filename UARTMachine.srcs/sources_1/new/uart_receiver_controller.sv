`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 05:42:23 PM
// Design Name: 
// Module Name: uart_receiver_controller
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



module uart_receiver_controller(
    input logic clk,
    input logic reset,
    input logic RX,
    input logic loop_msg,
    input logic loop_stop,
    input logic T_Q,
    output logic half_baud,
    output logic T_ld,
    output logic T_en,
    output logic T_rst,
    output logic buf_ld,
    output logic buf_clr,
    output logic msg_ld,
    output logic msg_clr,
    output logic stop_ld,
    output logic stop_clr,
    output logic [3:0] S
    );
    typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10} state;
    state curr_state;
    
    always_ff @(posedge clk) begin
        if(reset) begin curr_state <= S0; end
        else begin
            case(curr_state)
                S0: curr_state <= S1;
                S1: begin
                        if(~RX) begin curr_state <= S2; end
                        else begin curr_state <= S1; end
                    end
                S2: begin
                        if(T_Q && ~RX) begin curr_state <= S3; end
                        else if(RX) begin curr_state <= S1; end
                        else if(~T_Q) begin curr_state <= S2; end
                    end
                S3: begin
                        if(T_Q) begin curr_state <= S4; end
                        else begin curr_state <= S3; end
                    end
                S4: curr_state <= S5;
                S5: begin
                        if(T_Q) begin curr_state <= S6; end
                        else begin curr_state <= S5; end
                    end
                S6: begin
                        if(loop_msg) begin curr_state <= S5; end
                        else begin curr_state <= S8; end
                    end
                S7: curr_state <= S10;
                S8: begin
                        if(T_Q) begin curr_state <= S9; end
                        else begin curr_state <= S8; end
                    end
                S9: begin
                        if(loop_stop && RX) begin curr_state <= S8; end
                        else if(loop_stop && ~RX) begin curr_state <= S7; end
                        else begin curr_state <= S10; end
                    end
                S10: curr_state <= S1;
                default: curr_state <= S0;
            endcase
        end
    end
    
    always_comb begin
        case(curr_state)
            S0: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    buf_clr = 1;
                    msg_ld = 0;
                    msg_clr = 1;
                    half_baud = 1;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 1;
                end
            S1: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    buf_clr = 1;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 1;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 1;
                end
            S2: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S3: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S4: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S5: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S6: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 1;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S7: begin
                    T_ld = 0;
                    T_en = 0;
                    T_rst = 0;
                    buf_clr = 1;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S8: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            S9: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 1;
                    stop_clr = 0;
                end
            S10: begin
                    T_ld = 0;
                    T_en = 0;
                    T_rst = 0;
                    buf_clr = 0;
                    msg_ld = 1;
                    msg_clr = 0;
                    half_baud = 0;
                    buf_ld = 0;
                    stop_ld = 0;
                    stop_clr = 0;
                end
            default: begin
                        T_ld = 1;
                        T_en = 0;
                        T_rst = 1;
                        buf_clr = 1;
                        msg_ld = 0;
                        msg_clr = 1;
                        half_baud = 1;
                        buf_ld = 0;
                        stop_ld = 0;
                        stop_clr = 1;
                     end
        endcase
    end

    assign S = curr_state;
endmodule
