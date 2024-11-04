`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/10/23 09:53:54
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
    reg [7:0] sw;
    reg s1_raw;
    reg s2_raw;
    reg s3_raw;

    wire [6:0] segment_select;
    wire [7:0] digit_select;
    wire dp_select;

    led_display_ctrl uut (
        .clk(clk),
        .sw(sw),
        .s1_raw(s1_raw),
        .s2_raw(s2_raw),
        .s3_raw(s3_raw),
        .segment_select(segment_select),
        .digit_select(digit_select),
        .dp_select(dp_select)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        sw = 8'b00000000;
        s1_raw = 0;
        s2_raw = 0;
        s3_raw = 0;

        @(posedge clk);
        uut.digit_select = 8'b11111110;
        uut.segment_select = uut.get_segment(0);
        #20;
            
        uut.digit_select = 8'b11111101;
        uut.segment_select = uut.get_segment(1);
        #20;
            
        uut.digit_select = 8'b11111011;
        uut.segment_select = uut.get_segment(2);
        #20;
            
        uut.digit_select = 8'b11110111;
        uut.segment_select = uut.get_segment(3);
        #20;
            
        uut.digit_select = 8'b11101111;
        uut.segment_select = uut.get_segment(4);
        #20;
            
        uut.digit_select = 8'b11011111;
        uut.segment_select = uut.get_segment(5);
        #20;
            
        uut.digit_select = 8'b10111111;
        uut.segment_select = uut.get_segment(6);
        #20;
            
        uut.digit_select = 8'b01111111;
        uut.segment_select = uut.get_segment(7);
        #20;
        uut.segment_select = uut.get_segment(10);

        #100 s1_raw = 1;
        #2 s1_raw = 0;
        #1 s1_raw = 1;
        #1 s1_raw = 0;
        #2 s1_raw = 0;
        #1 s1_raw = 1;
        #20 s1_raw = 0;
        #2 s1_raw = 1;
        #1 s1_raw = 0;
        #2 s1_raw = 1;
        #1 s1_raw = 0;

        #20 s3_raw = 1;
        #10 s3_raw = 0;

        #20 s3_raw = 1;
        #10 s3_raw = 0;
    end


endmodule
