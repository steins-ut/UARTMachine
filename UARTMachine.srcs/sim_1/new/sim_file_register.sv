`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 06:52:53 PM
// Design Name: 
// Module Name: sim_file_register
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


module sim_file_register(

    );
logic clk = 0;
logic ld = 0;
logic [7:0] out;
logic [7:0] discard;

fifo_register_file #(.WIDTH(8) , .DEPTH(4)) dut(.clk(clk), .in(8'b10101010), .r_addr(0), .ld(ld), .clr(0), .out(out), .discard(discard));
always begin #5 clk = ~clk; end

initial begin
    ld = 1;
end

endmodule
