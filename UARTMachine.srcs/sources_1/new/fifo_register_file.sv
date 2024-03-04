`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 05:22:38 PM
// Design Name: 
// Module Name: fifo_register_file
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


module fifo_register_file 
#(parameter WIDTH = 1, parameter DEPTH = 2)(
    input logic clk,
    input logic [WIDTH - 1: 0] in,
    input logic [$clog2(DEPTH) - 1: 0] r_addr,
    input logic [$clog2(DEPTH) - 1: 0] r_addr1,
    input logic [$clog2(DEPTH) - 1: 0] r_addr2,
    input logic [$clog2(DEPTH) - 1: 0] r_addr3,
    input logic ld,
    input logic clr,
    output logic [WIDTH - 1: 0] out,
    output logic [WIDTH - 1: 0] out1,
    output logic [WIDTH - 1: 0] out2,
    output logic [WIDTH - 1: 0] out3,
    output logic [WIDTH - 1: 0] discard
    );
    integer i = 0;
    logic [WIDTH - 1: 0] memory [DEPTH: 0] = '{default:'0};
    
    always_ff @(posedge clk) begin
        if(clr) begin memory <= '{default:'0}; end
        else if(ld) begin
            memory[0] <= in;
            for(i = 0; i < DEPTH; i = i + 1) begin
                memory[i + 1] <= memory[i]; 
            end
        end
        else begin memory <= memory; end
    end
    
    always_comb begin
        out = memory[r_addr];
        out1 = memory[r_addr1];
        out2 = memory[r_addr2];
        out3 = memory[r_addr3];
        discard = memory[DEPTH];
    end
    
endmodule
