`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 09:00:40 PM
// Design Name: 
// Module Name: register_file_viewer
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


module register_file_viewer 
#(parameter PAGE_SIZE = 8)(
    input logic clk,
    input logic switch_page,
    input logic switch_reg,
    input logic [PAGE_SIZE - 1: 0] page0_reg0,
    input logic [PAGE_SIZE - 1: 0] page1_reg0,
    input logic [PAGE_SIZE - 1: 0] page0_reg1,
    input logic [PAGE_SIZE - 1: 0] page1_reg1,
    output logic current_reg,
    output logic current_page_offset,
    output logic [6:0] dsp_cathodes,
    output logic dsp_dp,
    output logic [3:0] dsp_anodes
);
    localparam UPDATE_CYCLE_COUNT = 99999;

    logic curr_page_offset = 0;
    logic curr_reg = 0;
    
    logic [31:0] counter = 0;    
    logic update = 0;
    logic [1:0] curr_digit = 0;
    logic [2 * PAGE_SIZE - 1: 0] full_page;
    logic [3:0] digit_index = 0;
    
    //seg7_control disp(clk, 0, full_page[3:0], full_page[7:4], full_page[11:8], full_page[15:12], dsp_cathodes, dsp_anodes); 
        
    always_ff @(posedge clk) begin
        if(switch_page) begin curr_page_offset = ~curr_page_offset; end;
        if(switch_reg) begin curr_reg = ~curr_reg; end
        
        if(counter == 0) begin
            counter <= UPDATE_CYCLE_COUNT;
            curr_digit <= curr_digit + 1 ;
        end
        else begin
            counter <= counter - 1;
        end
    end

    always_comb begin
        current_page_offset = curr_page_offset;
        current_reg = curr_reg;
        
        dsp_dp = 1;

        if(curr_reg) begin
            full_page[2 * PAGE_SIZE - 1: PAGE_SIZE] = page1_reg1;
            full_page[PAGE_SIZE - 1: 0] = page0_reg1;
        end
        else begin
            full_page[2 * PAGE_SIZE - 1: PAGE_SIZE] = page1_reg0;
            full_page[PAGE_SIZE - 1: 0] = page0_reg0;
        end

        case(curr_digit)
            2'b00: 
            begin
                dsp_anodes = 4'b1110;
                digit_index = (PAGE_SIZE >> 1) - 1;
            end
            2'b01: 
            begin
                dsp_anodes = 4'b1101;
                digit_index = PAGE_SIZE - 1;
            end
            2'b10:
            begin
                dsp_anodes = 4'b1011;
                digit_index = (PAGE_SIZE << 2) - (PAGE_SIZE >> 1) - 1;
            end    
            2'b11:
            begin
                dsp_anodes = 4'b0111;
                digit_index = (PAGE_SIZE << 2) - 1;
            end
        endcase
        
        
        
        case(full_page[digit_index -: 4])
            0: dsp_cathodes = ~7'b1111110;
            1: dsp_cathodes = ~7'b0110000;
            2: dsp_cathodes = ~7'b1101101;
            3: dsp_cathodes = ~7'b1111001;
            4: dsp_cathodes = ~7'b0110011;
            5: dsp_cathodes = ~7'b1011011;
            6: dsp_cathodes = ~7'b1011111;
            7: dsp_cathodes = ~7'b1110000;
            8: dsp_cathodes = ~7'b1111111;
            9: dsp_cathodes = ~7'b1111011;
            10: dsp_cathodes = ~7'b1110111;
            11: dsp_cathodes = ~7'b0011111;
            12: dsp_cathodes = ~7'b0001101;
            13: dsp_cathodes = ~7'b0111101;
            14: dsp_cathodes = ~7'b1001111;
            15: dsp_cathodes = ~7'b1000111;
            default: dsp_cathodes = ~7'b1111111;
        endcase
    end

endmodule