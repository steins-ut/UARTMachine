`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 09:14:24 PM
// Design Name: 
// Module Name: adder
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


module adder
#(SIZE = 1) (
    input logic [SIZE - 1: 0] lhs,
    input logic [SIZE - 1: 0] rhs,
    output logic [SIZE - 1: 0] sum
    );
    
    assign sum = lhs + rhs;
endmodule
