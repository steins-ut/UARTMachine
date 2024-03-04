`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 03:05:42 AM
// Design Name: 
// Module Name: button_debouncer
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


module button_debouncer(
    input logic clk,
    input logic button,
    output logic debounced
    );
    logic triggered = 0;
    logic waiting = 0;
    logic [63:0] counter = 0;
    
    always_ff @(posedge clk) begin
        if(button && ~triggered && ~waiting) 
        begin
            triggered <= 1;
        end
        else if(triggered) begin
            triggered <= 0;
            waiting <= 1;
            counter <= 50000000;
        end
        
        if(waiting) begin
            if(counter == 0) begin waiting <= 0; end
            else begin counter <= counter - 1; end
        end
    end
    
    always_comb begin
        debounced = triggered && ~waiting;
    end
    
endmodule
