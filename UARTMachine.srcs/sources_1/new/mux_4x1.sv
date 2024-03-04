`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 10:59:49 PM
// Design Name: 
// Module Name: mux_4x1
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


module mux_4x1
#(parameter WIDTH = 1)(
    input logic [WIDTH - 1:0] I0,
    input logic [WIDTH - 1:0] I1,
    input logic [WIDTH - 1:0] I2,
    input logic [WIDTH - 1:0] I3,
    input logic [1:0] S,
    output logic [WIDTH - 1: 0] Y
);

always_comb begin
    case(S)
        2'b00: Y = I0;
        2'b01: Y = I1;
        2'b10: Y = I2;
        2'b11: Y = I3;
    endcase
end

endmodule
