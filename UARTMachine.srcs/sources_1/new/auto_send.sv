`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2023 05:09:56 AM
// Design Name: 
// Module Name: auto_send
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


module auto_send (
    input logic clk,
    input logic send,
    input logic flag,
    output logic target
    );
    logic sending = 0;
    logic [3:0] counter = 0;
    
    always_ff @(posedge clk) begin
        if(send && ~sending) begin sending <= 1; counter <= 4; end
        if(sending) begin
            if(counter == 0) begin
                sending <= 0;
            end
            else begin
                counter <= counter - flag;
            end
        end
    end
    
    always_comb begin
        target = sending && flag;
    end
endmodule
