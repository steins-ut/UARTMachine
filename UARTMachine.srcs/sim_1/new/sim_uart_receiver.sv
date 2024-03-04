`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 10:02:29 PM
// Design Name: 
// Module Name: sim_uart_receiver
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


module sim_uart_receiver();

logic clk = 0;
logic RX = 1;
logic [7:0] msg = 0;

uart_receiver dut(.clk(clk), .Baud_rate_us(1), .RX(RX), .msg(msg));

always begin #5 clk = ~clk; end

initial begin
   #200
   RX = 0;
   #100
   RX = 1;
   #100
   RX = 0;
   #100
   RX = 0;
   #100
   RX = 1;
   #100
   RX = 1;
   #100
   RX = 1;
   #100
   RX = 0;
   #100
   RX = 1;
   #100
   RX = 1;
   #100
   RX = 1;
end

endmodule
