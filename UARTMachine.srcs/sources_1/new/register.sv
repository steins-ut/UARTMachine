`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 08:11:00 PM
// Design Name: 
// Module Name: register
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


module register
#(parameter SIZE = 1) (
    input logic clk,
    input logic clr,
    input logic ld,
    input logic [SIZE - 1: 0] D,
    output logic [SIZE - 1: 0] Q,
    output logic [SIZE - 1: 0] notQ
);

always_ff @(posedge clk) begin
    if(clr) begin Q <= 0; end
    else if(ld) begin Q <= D; end
    else begin Q <= Q; end
end

assign notQ = ~Q;

endmodule
