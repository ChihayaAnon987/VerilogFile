`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/9 8:54:16
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk;
    reg clr;
    reg en;
    reg [2:0] wsel;
    reg [2:0] rsel;
    reg [7:0] d;
    wire [7:0] q;

    reg8file uut (
        .clk(clk),
        .clr(clr),
        .en(en),
        .wsel(wsel),
        .rsel(rsel),
        .d(d),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        clr = 1;
        en = 0;
        wsel = 3'b000;
        rsel = 3'b000;
        d = 8'b00000000;

        #10 clr = 0;
        
        #10 en = 1; wsel = 3'b000; d = 8'b10101010;
        #10 wsel = 3'b001; d = 8'b01010101;
        #10 en = 0;

        #10 rsel = 3'b000;
        #10 rsel = 3'b001;

        #10 clr = 1;
        #10 clr = 0;

        #10 rsel = 3'b000;
        #10 rsel = 3'b001;

        #50 $finish;
    end

endmodule