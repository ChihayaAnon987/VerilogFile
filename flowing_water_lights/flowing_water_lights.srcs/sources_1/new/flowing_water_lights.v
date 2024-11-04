`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/16 14:13:32
// Design Name: 
// Module Name: flowing_water_lights
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

module flowing_water_lights (
    input wire clk,
    input wire rst,
    input wire button,
    input wire [1:0] freq_set,
    input wire dir_set,
    output reg [7:0] led
);
    wire cnt_end;
    reg [27:0] cnt;
    reg is_running = 0;
    reg [2:0] button_state;

    wire [27:0] cnt_max;
    assign cnt_max = (freq_set == 2'b00) ? 28'd1000000 :   //100Hz=0.01s
                     (freq_set == 2'b01) ? 28'd10000000 :  //10Hz=0.1s
                     (freq_set == 2'b10) ? 28'd25000000 : //4Hz=0.25s
                                           28'd50000000;  //2Hz=0.5s

    assign cnt_end = (cnt == cnt_max);

    always @(posedge clk or posedge rst) begin
        if (rst)
            cnt <= 0;
        else if (cnt_end)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end

    always @(posedge clk) begin
        button_state <= {button_state[1:0], button};
    end
    wire button_edge_rising = (button_state[2:1] == 2'b01);  //检测上升沿
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            is_running <= 0;
        else if (button_edge_rising)
            is_running <= ~is_running;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            led <= 8'b00000001;
        else if (cnt_end && is_running) begin
            led <= (dir_set) ? {led[6:0], led[7]} : {led[0], led[7:1]};
        end
    end

endmodule
