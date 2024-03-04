`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 08:11:00 PM
// Design Name: 
// Module Name: compare_less
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


module compare_less
#(parameter SIZE = 1) (
    input logic [SIZE - 1: 0] lhs,
    input logic [SIZE - 1: 0] rhs,
    output logic lt
);

assign lt = lhs < rhs;

endmodule
