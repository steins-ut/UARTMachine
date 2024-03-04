`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 02:08:58 AM
// Design Name: 
// Module Name: sim_uart_transmitter
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


module sim_uart_transmitter();

logic clk = 0;
logic TX = 1'bx;
logic [7:0] msg = 8'b10111001;
logic load = 0;
logic send = 0;

always begin #5 clk = ~clk; end

uart_transmitter dut(.clk(clk), .Baud_rate(10), .msg(msg), .load(load), .send(send), .TX(TX));

initial begin
#100 load = 1;
#100 load = 0;
#100 send = 1;
#100 send = 0;
end

endmodule
