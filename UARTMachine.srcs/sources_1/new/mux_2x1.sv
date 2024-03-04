`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 08:11:00 PM
// Design Name: 
// Module Name: mux_2x1
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


module mux_2x1
#(parameter WIDTH = 1)(
    input logic [WIDTH - 1:0] I0,
    input logic [WIDTH - 1:0] I1,
    input logic S,
    output logic [WIDTH - 1: 0] Y
);

assign Y = S ? I1 : I0;

endmodule
