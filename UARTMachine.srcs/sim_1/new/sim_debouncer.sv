`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 03:09:09 AM
// Design Name: 
// Module Name: sim_debouncer
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


module sim_debouncer();
    
logic clk = 0;
logic button = 0;
logic debounced = 1'bx;

button_debouncer dut(.clk(clk), .button(button), .debounced(debounced));

always begin #5 clk = ~clk; end

initial begin
#5
button = 1;
#5
button = 0;
end

endmodule
