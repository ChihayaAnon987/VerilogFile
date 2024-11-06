`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/11/05 14:52:47
// Design Name: 
// Module Name: digit_display
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

module digit_display (
    input                   clk,
    input wire              rst,
    input wire              valid,
    input wire [7:0]        data,
    output reg [7:0]        segment_select,
    output reg [7:0]        digit_select
);

    reg [7:0] display_data [7:0]; // 8字节移位寄存器，保存最近接收的8个字符
    // 更新显示缓冲区：新数据进入，老数据移位
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            display_data[0] <= 8'b11111111;  //复位关闭所有数码管
            display_data[1] <= 8'b11111111;
            display_data[2] <= 8'b11111111;
            display_data[3] <= 8'b11111111;
            display_data[4] <= 8'b11111111;
            display_data[5] <= 8'b11111111;
            display_data[6] <= 8'b11111111;
            display_data[7] <= 8'b11111111;
        end else if (valid) begin
            display_data[0] <= data;
            display_data[1] <= display_data[0];
            display_data[2] <= display_data[1];
            display_data[3] <= display_data[2];
            display_data[4] <= display_data[3];
            display_data[5] <= display_data[4];
            display_data[6] <= display_data[5];
            display_data[7] <= display_data[6];
        end
    end

    //value是ASCLL码的二进制表示
    function [7:0] get_segment;
        input [7:0] value;
        begin
            case (value)
            8'b00110000: get_segment = 8'b00000011;  // 显示 0
            8'b00110001: get_segment = 8'b10011111;  // 显示 1
            8'b00110010: get_segment = 8'b00100101;  // 显示 2
            8'b00110011: get_segment = 8'b00001101;  // 显示 3
            8'b00110100: get_segment = 8'b10011001;  // 显示 4
            8'b00110101: get_segment = 8'b01001001;  // 显示 5
            8'b00110110: get_segment = 8'b01000001;  // 显示 6
            8'b00110111: get_segment = 8'b00011111;  // 显示 7
            8'b00111000: get_segment = 8'b00000001;  // 显示 8
            8'b00111001: get_segment = 8'b00001001;  // 显示 9
            8'b01000001: get_segment = 8'b00010001;  // 显示 A
            8'b01000010: get_segment = 8'b11000001;  // 显示 B
            8'b01000011: get_segment = 8'b01100011;  // 显示 C
            8'b01000100: get_segment = 8'b10000101;  // 显示 D
            8'b01000101: get_segment = 8'b01100001;  // 显示 E
            8'b01000110: get_segment = 8'b01110001;  // 显示 F
            default:     get_segment = 8'b11111111;  // 默认关闭
            endcase
        end
    endfunction

    reg [2:0] scan_index;
    reg [16:0] refresh_counter;
    parameter REFRESH_RATE = 100000; // 1ms

    always @(posedge clk) begin
        if (refresh_counter >= REFRESH_RATE) begin
            refresh_counter <= 0;
            scan_index <= scan_index + 1;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_select <= 8'b11111111;
            segment_select <= 8'b11111111;
        end
        else begin
            case (scan_index)
            3'd0: begin
                digit_select <= 8'b11111110;
                segment_select <= get_segment(display_data[0]);
            end
            3'd1: begin
                digit_select <= 8'b11111101;
                segment_select <= get_segment(display_data[1]);
            end
            3'd2: begin
                digit_select <= 8'b11111011;
                segment_select <= get_segment(display_data[2]);
            end
            3'd3: begin
                digit_select <= 8'b11110111;
                segment_select <= get_segment(display_data[3]);
            end
            3'd4: begin
                digit_select <= 8'b11101111;
                segment_select <= get_segment(display_data[4]);
            end
            3'd5: begin
                digit_select <= 8'b11011111;
                segment_select <= get_segment(display_data[5]);
            end
            3'd6: begin
                digit_select <= 8'b10111111;
                segment_select <= get_segment(display_data[6]);
            end
            3'd7: begin
                digit_select <= 8'b01111111;
                segment_select <= get_segment(display_data[7]); 
            end
            endcase
        end
    end

endmodule
