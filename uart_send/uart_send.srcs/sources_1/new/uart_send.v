`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/10/29 21:34:39
// Design Name: 
// Module Name: uart_send
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

module uart_send(
    input        clk,        
    input        rst,        
    input        valid,       // indicates data is valid (logic high (1)), lasts one clock
    input [7:0]  data,        // data to send
    output reg   dout         // connect to USB_UART tx pin
);

    // 状态定义
    localparam IDLE  = 2'b00;   // 空闲态，发送高电平
    localparam START = 2'b01;   // 起始态，发送起始位
    localparam DATA  = 2'b10;   // 数据态，发送8位数据
    localparam STOP  = 2'b11;   // 停止态，发送停止位

    // 波特率和计数器参数
    localparam BAUD_RATE = 9600;           // 波特率9600
    localparam CLOCK_FREQ = 100_000_000;   // 系统时钟100MHz
    localparam DIVIDER = CLOCK_FREQ / BAUD_RATE -1;  // 波特率计数器最大值
    //localparam DELAY_CNT_MAX = CLOCK_FREQ / 10;        // 发送间隔计数器最大值（0.1秒）

    reg [7:0] data_valid; // 数据有效
    reg [1:0] current_state, next_state;    // 当前状态和次态
    reg [3:0] bit_cnt;                      // 数据位计数器
    reg [31:0] baud_cnt;                    // 波特率计数器
    // 数据位计数逻辑
    always @(posedge clk) begin
        if (valid) begin
            data_valid <= data;
        end
    end

    always @(posedge clk) begin
        if (current_state == DATA && baud_cnt >= DIVIDER) begin
            if (bit_cnt < 8) begin
                bit_cnt <= bit_cnt + 1; // 数据位计数
            end
        end
        else if (current_state == IDLE) begin
            bit_cnt <= 0; // 重置位计数
        end
    end

    // 次态逻辑：组合逻辑判断状态转移条件
    always @(*) begin
        case (current_state)
            IDLE:  next_state = (valid) ? START : IDLE;
            START: next_state = (baud_cnt >= DIVIDER) ? DATA : START;
            DATA:  next_state = (bit_cnt >= 8) ? STOP : DATA;
            STOP:  next_state = (baud_cnt >= DIVIDER) ? IDLE : STOP;
            default: next_state = IDLE;
        endcase
    end
    
    // 状态寄存器：同步时序电路，更新当前状态
    always @(posedge clk) begin
        if (rst) begin
            current_state <= IDLE; // 初始状态为IDLE
            dout <= 1'b1;          // 初始高电平
            bit_cnt <= 0;
            baud_cnt <= 0;
        end else begin
            current_state <= next_state;

            // 波特率计数器更新
            if (baud_cnt < DIVIDER)
                baud_cnt <= baud_cnt + 1;
            else
                baud_cnt <= 0;

            // 输出逻辑
            case (current_state)
                IDLE: begin
                    dout <= 1'b1; // 空闲状态保持高电平
                    baud_cnt <= 0; // 重置波特率计数器
                end

                START: begin
                    dout <= 1'b0; // 发送起始位
                end

                DATA: begin
                    dout <= data_valid[bit_cnt]; // 发送数据位
                    if (bit_cnt >= 8) begin
                        dout <= 1'b1; // 发送完数据位后，保持高电平
                    end
                end

                STOP: begin
                    dout <= 1'b1; // 发送停止位
                end
            endcase
        end
    end


endmodule