`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/10/16 14:14:02
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
    reg rst;
    reg button;
    reg [1:0] freq_set;
    reg dir_set;
    wire [7:0] led;

    flowing_water_lights uut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .freq_set(freq_set),
        .dir_set(dir_set),
        .led(led)
    );


    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        button = 0;
        freq_set = 2'b00;
        dir_set = 0;

        // 仿真过程
        #10 rst = 0;
        #20000000;
        #20 button = 1;
        #10 button = 0; //启动1
        #10000000;
        #10 rst = 1;    //复位
        #20000000;
        #10 rst = 0;    //取消复位
        #20 button = 1;
        #10 button = 0; //启动2
        #10000000;
        #20 button = 1;
        #10 button = 0; //暂停3
        #30000000;
        #20 button = 1;
        #10 button = 0; //启动4
        #10000000;
        #200 freq_set = 2'b01;   //间隔切换
        #20000000;
        #200 dir_set = 1;        //方向切换
        #20000000;
        #100000000 $finish;
    end
endmodule