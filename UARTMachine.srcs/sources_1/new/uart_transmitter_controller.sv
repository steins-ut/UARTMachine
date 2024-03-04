`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 10:56:39 PM
// Design Name: 
// Module Name: uart_transmitter_controller
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


module uart_transmitter_controller(
    input logic clk,
    input logic reset,
    input logic load,
    input logic send,
    input logic loop_msg,
    input logic loop_stop,
    input logic T_Q,
    output logic T_ld,
    output logic T_en,
    output logic T_rst,
    output logic file_ld,
    output logic file_psh,
    output logic msg_ld,
    output logic msg_clr,
    output logic msg_shf,
    output logic cnt_msg,
    output logic clr_msg_cnt,
    output logic cnt_stop,
    output logic clr_stop_cnt,
    output logic send_s_0,
    output logic send_s_1,
    output logic available,
    output logic [2:0] S
    );
    
    typedef enum {S0, S1, S2, S3, S4, S5, S6, S7, S8} state;
    state curr_state;

    always_ff @(posedge clk) begin
        if(reset) begin curr_state <= S0; end
        else begin
            case(curr_state)
                S0: curr_state <= S1;
                S1: begin 
                        if(load) begin curr_state <= S2; end
                        else if(send) begin curr_state <= S3; end
                        else begin curr_state <= S1; end
                    end
                S2: curr_state <= S1;
                S3: begin
                        if(T_Q) begin curr_state <= S4; end
                        else begin curr_state <= S3; end
                    end
                S4: begin
                        if(T_Q) begin curr_state <= S5; end
                        else begin curr_state <= S4; end
                    end
                S5: begin
                        if(loop_msg) begin curr_state <= S4; end
                        else begin curr_state <= S6; end
                    end
                S6: begin
                        if(T_Q) begin curr_state <= S7; end
                        else begin curr_state <= S6; end
                    end
                S7: begin
                        if(loop_stop) begin curr_state <= S6; end
                        else begin curr_state <= S8; end
                    end
                S8: curr_state <= S1;
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
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 1;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 1;
                    clr_stop_cnt = 1;
                    send_s_0 = 0;
                    send_s_1 = 0;
                    available = 0;
                end

            S1: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 1;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 1;
                    clr_stop_cnt = 1;
                    send_s_0 = 0;
                    send_s_1 = 0;
                    available = 1;
                end

            S2: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    file_ld = 1;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 0;
                    send_s_1 = 0;
                    available = 0;
                end

            S3: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 1;
                    send_s_1 = 0;
                    available = 0;
                end

            S5: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 1;
                    msg_clr = 0;
                    msg_shf = 1;
                    cnt_msg = 1;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 0;
                    send_s_1 = 1;
                    available = 0;
                end

            S4: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 0;
                    send_s_1 = 1;
                    available = 0;
                end

            S7: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 1;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 1;
                    send_s_1 = 1;
                    available = 0;
                end

            S6: begin
                    T_ld = 0;
                    T_en = 1;
                    T_rst = 0;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 1;
                    send_s_1 = 1;
                    available = 0;
                end                
            S8: begin
                    T_ld = 0;
                    T_en = 0;
                    T_rst = 0;
                    file_ld = 1;
                    file_psh = 1;
                    msg_ld = 0;
                    msg_clr = 0;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 0;
                    clr_stop_cnt = 0;
                    send_s_0 = 0;
                    send_s_1 = 0;
                    available = 0;
                end 
            default: begin
                    T_ld = 1;
                    T_en = 0;
                    T_rst = 1;
                    file_ld = 0;
                    file_psh = 0;
                    msg_ld = 0;
                    msg_clr = 1;
                    msg_shf = 0;
                    cnt_msg = 0;
                    cnt_stop = 0;
                    clr_msg_cnt = 1;
                    clr_stop_cnt = 1;
                    send_s_0 = 0;
                    send_s_1 = 0;
                    available = 0;
                end
        endcase
    end

    assign S = curr_state;
endmodule
