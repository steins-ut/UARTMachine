`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 08:11:00 PM
// Design Name: 
// Module Name: timer
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


module timer(
    input logic clk,
    input logic [31:0] M_us,
    input logic ld,
    input logic en,
    input logic rst,
    input logic clr,
    output logic Q
);
logic [31:0] start, counter;

always_ff @(posedge clk) begin
    if(counter == 0) begin
        counter <= start;
    end
    else if(en) begin
        counter <= counter - 1;
    end
    
    if(ld) begin start <= M_us; counter <= M_us; end
    else if(rst) begin counter <= start; end
    else if(clr) begin start <= 0; counter <= 0; end
end

always_comb begin
    Q = counter == 0;
end

endmodule
