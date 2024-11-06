`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/05 14:52:47
// Design Name: 
// Module Name: uart_recv
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


module uart_recv(
    input                   clk,
    input                   rst,
    input                   din,        // connect to usb_uart rx pin
    (*mark_debug = "true"*)output reg              valid,      // indicates data is valid （logic high (1)）, last one clock
    output reg [7:0]        data
);

    localparam    IDLE  = 3'b000;
    localparam    START = 3'b001;
    localparam    DATA  = 3'b010;
    localparam    STOP  = 3'b011;

    reg [2:0] current_state, next_state;    // 当前状态和下一状态
    reg [3:0] bit_index;              // 位计数器，用于记录接收的数据位数
    reg [31:0] cnt;                 // 计数器，用于产生中间采样和结束位置
    reg cnt_half, cnt_end;          // 每位的中间位置和结束位置的标志

    localparam CLK_FREQ = 100_000_000;
    localparam BAUD_RATE = 9600;
    localparam DIVIDER = CLK_FREQ / BAUD_RATE;

    // 状态机和计数器的时序逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            cnt_half <= 0;
            cnt_end <= 0;
        end else begin
            if (cnt_end || current_state == IDLE) 
                cnt <= 0;          // 重置计数器
            else 
                cnt <= cnt + 1;    // 计数递增
                cnt_half <= (cnt == (DIVIDER >> 1));
                cnt_end <= (cnt == DIVIDER - 1);
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_index <= 0;
        end else begin
            if (cnt_end && current_state == DATA) begin
                if (bit_index < 8) begin
                bit_index <= bit_index + 1; // 数据位接收完毕，计数器递增
                end
            end
            else if (current_state == IDLE) begin
                bit_index <= 0; // 初始状态，计数器清零
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE; // 初始状态为IDLE
        end else begin
            current_state <= next_state;
        end
    end

    // 状态机组合逻辑
    always @(*) begin
        case (current_state)
            IDLE:  next_state = (din) ? IDLE : START;
            START: next_state = (cnt_end) ? DATA : START;
            DATA:  next_state = (bit_index >= 8) ? STOP : DATA;
            STOP:  next_state = (cnt_half && din) ? IDLE : STOP;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data <= 8'b0;
            valid <= 0;
        end else begin
            if (valid) begin
                valid <= 0;
            end
            case (current_state)
                IDLE: begin
                end

                START: begin
                end

                DATA: begin
                    if (cnt_half) begin
                        data[bit_index] <= din;
                    end
                end

                STOP: begin
                    if (cnt_half) begin
                        valid <= 1;
                    end
                end
                default: data[bit_index] <= 1'b1;
            endcase
        end
    end

    
endmodule