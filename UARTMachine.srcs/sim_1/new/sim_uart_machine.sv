`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 06:23:26 AM
// Design Name: 
// Module Name: sim_uart_machine
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


module sim_uart_machine();

logic clk = 0;
logic TX = 1;
logic [4:0] msg_in = 5'b10111;
logic load = 0;
logic send = 0;
logic [7:0] led_rxbuf = 0;
logic [7:0] led_txbuf = 0;

uart_machine #(.BAUD_CYCLE_COUNT(30)) dut(.clk(clk), .load(load), .send(send), .RX(TX), .msg_in(msg_in), .TX(TX)); 

always begin #5 clk = ~clk; end

initial begin
#100 load = 1;
#50 msg_in = 5'b11000;
#250 load = 0;

#200 send = 1;
end

endmodule
