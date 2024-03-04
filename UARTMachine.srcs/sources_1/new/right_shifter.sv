`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 08:11:00 PM
// Design Name: 
// Module Name: right_shifter
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


module right_shifter
#(parameter WIDTH = 1, 
parameter SHIFT_AMOUNT = 1) (
    input logic [WIDTH - 1: 0] in,
    input logic [SHIFT_AMOUNT - 1: 0] sh_in,
    output logic [WIDTH - 1: 0] out,
    output logic [SHIFT_AMOUNT - 1: 0] sh_out
);

always_comb begin
    out = {sh_in, in} >> SHIFT_AMOUNT;
    sh_out = {sh_in, in[SHIFT_AMOUNT : 0]};
end

endmodule
