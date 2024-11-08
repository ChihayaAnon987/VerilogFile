`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/11/05 21:07:37
// Design Name: 
// Module Name: string_match
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


module string_match(
    input                   clk,            // 时钟信号
    input                   rst,            // 复位信号
    input                   din,            // UART 接收引脚
    output wire             dout           // UART 发送引脚
);

    reg [7:0]       buffer[15:0]; // 字符缓冲区，最多16个字符
    wire [7:0]      data;          // 接收的字符数据
    wire            valid;         // 数据有效标志
    reg [7:0]       response;      // 回复数据：1、2、0

    // UART 接收模块实例化
    uart_recv uart_recv(
        .clk(clk),
        .rst(rst),
        .din(din),
        .valid(valid),
        .data(data)
    );

    // 字符缓冲区，接收数据
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 复位时清空缓冲区
            buffer[0]  <= 8'h30;
            buffer[1]  <= 8'h30;
            buffer[2]  <= 8'h30;
            buffer[3]  <= 8'h30;
            buffer[4]  <= 8'h30;
            buffer[5]  <= 8'h30;
            buffer[6]  <= 8'h30;
            buffer[7]  <= 8'h30;
            buffer[8]  <= 8'h30;
            buffer[9]  <= 8'h30;
            buffer[10] <= 8'h30;
            buffer[11] <= 8'h30;
            buffer[12] <= 8'h30;
            buffer[13] <= 8'h30;
            buffer[14] <= 8'h30;
            buffer[15] <= 8'h30;
        end
        else if (valid) begin
            // 当数据有效时，将接收到的数据写入缓冲区，并进行滑动更新
            buffer[0]  <= data;
            buffer[1]  <= buffer[0];
            buffer[2]  <= buffer[1];
            buffer[3]  <= buffer[2];
            buffer[4]  <= buffer[3];
            buffer[5]  <= buffer[4];
            buffer[6]  <= buffer[5];
            buffer[7]  <= buffer[6];
            buffer[8]  <= buffer[7];
            buffer[9]  <= buffer[8];
            buffer[10] <= buffer[9];
            buffer[11] <= buffer[10];
            buffer[12] <= buffer[11];
            buffer[13] <= buffer[12];
            buffer[14] <= buffer[13];
            buffer[15] <= buffer[14];
        end
    end

    // 匹配字符串“start”和“stop”
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            response <= 8'h30;  // 复位时清空响应
        end 
        else begin
                if ((buffer[4] == 8'h73) &&            // 's'
                    (buffer[3] == 8'h74) &&            // 't'
                    (buffer[2] == 8'h61) &&            // 'a'
                    (buffer[1] == 8'h72) &&            // 'r'
                    (buffer[0] == 8'h74) && valid)    // 't'
                begin
                    response <= 8'h31;
                end

                else if ((buffer[3] == 8'h73) &&           // 's'
                        (buffer[2] == 8'h74) &&            // 't'
                        (buffer[1] == 8'h6F) &&            // 'o'
                        (buffer[0] == 8'h70) && valid)    // 'p'
                begin
                    response <= 8'h32;
                end
                // 如果都不匹配，回复0
                else begin
                    if (valid) begin   //收到消息才回复
                        response <= 8'h30;  // 无匹配，回复0
                    end
                end
        end
    end

    // UART 发送模块实例化
    uart_send uart_send(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .data(response),
        .dout(dout)
    );


endmodule











/*

module string_match(
    input                   clk,            // 时钟信号
    input                   rst,            // 复位信号
    input                   din,            // UART 接收引脚
    output reg              dout           // UART 发送引脚
);

    localparam    IDLE        = 3'b000;
    localparam    RECEIVE     = 3'b001;
    localparam    MATCH_START = 3'b010;
    localparam    MATCH_STOP  = 3'b011;
    localparam    NO_MATCH    = 3'b100;

    reg [7:0] buffer[15:0];  // 字符缓冲区，最多16个字符
    wire [7:0] data;          // 接收的字符数据
    wire valid;               // 数据有效标志
    reg [7:0] response;       // 回复数据：1、2、0
    reg [2:0] state, next_state; // 当前状态和下一个状态

    // UART 接收模块实例化
    uart_recv uart_recv(
        .clk(clk),
        .rst(rst),
        .din(din),
        .valid(valid),
        .data(data)
    );

    // 状态转移
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // 下一个状态逻辑
    always @(*) begin
        case (state)
            IDLE: begin
                if (valid) 
                    next_state = RECEIVE; 
                else 
                    next_state = IDLE;
            end
            
            RECEIVE: begin
                if (valid)
                    next_state = MATCH_START;  // 收到数据，开始匹配
                else
                    next_state = RECEIVE;
            end

            MATCH_START: begin
                if ((buffer[4] == 8'h73) &&  // 's'
                    (buffer[3] == 8'h74) &&  // 't'
                    (buffer[2] == 8'h61) &&  // 'a'
                    (buffer[1] == 8'h72) &&  // 'r'
                    (buffer[0] == 8'h74))    // 't'
                    next_state = IDLE;  // 匹配"start"
                else
                    next_state = MATCH_STOP;   // 匹配"stop"
            end

            MATCH_STOP: begin
                if ((buffer[3] == 8'h73) &&  // 's'
                    (buffer[2] == 8'h74) &&  // 't'
                    (buffer[1] == 8'h6F) &&  // 'o'
                    (buffer[0] == 8'h70))    // 'p'
                    next_state = IDLE;  // 匹配"stop"
                else
                    next_state = NO_MATCH;   // 不匹配
            end

            NO_MATCH: begin
                next_state = IDLE;  // 没有匹配，发送0
            end


            default: next_state = IDLE;
        endcase
    end

    // 字符缓冲区，接收数据
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 复位时清空缓冲区
            buffer[0]  <= 8'h30;
            buffer[1]  <= 8'h30;
            buffer[2]  <= 8'h30;
            buffer[3]  <= 8'h30;
            buffer[4]  <= 8'h30;
            buffer[5]  <= 8'h30;
            buffer[6]  <= 8'h30;
            buffer[7]  <= 8'h30;
            buffer[8]  <= 8'h30;
            buffer[9]  <= 8'h30;
            buffer[10] <= 8'h30;
            buffer[11] <= 8'h30;
            buffer[12] <= 8'h30;
            buffer[13] <= 8'h30;
            buffer[14] <= 8'h30;
            buffer[15] <= 8'h30;
        end
        else if (valid) begin
            // 当数据有效时，将接收到的数据写入缓冲区，并进行滑动更新
            buffer[0]  <= data;
            buffer[1]  <= buffer[0];
            buffer[2]  <= buffer[1];
            buffer[3]  <= buffer[2];
            buffer[4]  <= buffer[3];
            buffer[5]  <= buffer[4];
            buffer[6]  <= buffer[5];
            buffer[7]  <= buffer[6];
            buffer[8]  <= buffer[7];
            buffer[9]  <= buffer[8];
            buffer[10] <= buffer[9];
            buffer[11] <= buffer[10];
            buffer[12] <= buffer[11];
            buffer[13] <= buffer[12];
            buffer[14] <= buffer[13];
            buffer[15] <= buffer[14];
        end
    end

    // 状态机输出逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            response <= 8'h30;  // 复位时清空响应
        end
        else begin
            case (state)
                MATCH_START: response <= 8'h31;  // 匹配 "start"
                MATCH_STOP: response <= 8'h32;   // 匹配 "stop"
                NO_MATCH: response <= 8'h30;     // 无匹配
                default: response <= 8'h30;
            endcase
        end
    end

    // UART 发送模块实例化
    uart_send uart_send(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .data(response),
        .dout(dout)
    );

endmodule*/


/*
module string_match(
    input                   clk,            // 时钟信号
    input                   rst,            // 复位信号
    input                   din,            // UART 接收引脚
    output wire             dout           // UART 发送引脚
);


    localparam    IDLE        = 2'b000;
    localparam    MATCH_START = 2'b001;
    localparam    MATCH_STOP  = 2'b010;
    localparam    NO_MATCH    = 2'b011;
    localparam    STOP        = 3'b100;
    
    reg [2:0]       state, next_state; // 当前状态和下一个状态
    reg [7:0]       buffer[15:0]; // 字符缓冲区，最多16个字符
    wire [7:0]      data;          // 接收的字符数据
    wire            valid;         // 数据有效标志
    reg [7:0]       response;      // 回复数据：1、2、0

    // UART 接收模块实例化
    uart_recv uart_recv(
        .clk(clk),
        .rst(rst),
        .din(din),
        .valid(valid),
        .data(data)
    );

    // 字符缓冲区，接收数据
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 复位时清空缓冲区
            buffer[0]  <= 8'h30;
            buffer[1]  <= 8'h30;
            buffer[2]  <= 8'h30;
            buffer[3]  <= 8'h30;
            buffer[4]  <= 8'h30;
            buffer[5]  <= 8'h30;
            buffer[6]  <= 8'h30;
            buffer[7]  <= 8'h30;
            buffer[8]  <= 8'h30;
            buffer[9]  <= 8'h30;
            buffer[10] <= 8'h30;
            buffer[11] <= 8'h30;
            buffer[12] <= 8'h30;
            buffer[13] <= 8'h30;
            buffer[14] <= 8'h30;
            buffer[15] <= 8'h30;
        end
        else if (valid) begin
            // 当数据有效时，将接收到的数据写入缓冲区，并进行滑动更新
            buffer[0]  <= data;
            buffer[1]  <= buffer[0];
            buffer[2]  <= buffer[1];
            buffer[3]  <= buffer[2];
            buffer[4]  <= buffer[3];
            buffer[5]  <= buffer[4];
            buffer[6]  <= buffer[5];
            buffer[7]  <= buffer[6];
            buffer[8]  <= buffer[7];
            buffer[9]  <= buffer[8];
            buffer[10] <= buffer[9];
            buffer[11] <= buffer[10];
            buffer[12] <= buffer[11];
            buffer[13] <= buffer[12];
            buffer[14] <= buffer[13];
            buffer[15] <= buffer[14];
        end
    end

    // 状态转移
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

        // 下一个状态逻辑
    always @(*) begin
        case (state)
            IDLE: begin
                if (valid) 
                    next_state = MATCH_START; 
                else 
                    next_state = IDLE;
            end
            
            MATCH_START: begin
                if ((buffer[4] == 8'h73) &&  // 's'
                    (buffer[3] == 8'h74) &&  // 't'
                    (buffer[2] == 8'h61) &&  // 'a'
                    (buffer[1] == 8'h72) &&  // 'r'
                    (buffer[0] == 8'h74))    // 't'
                    next_state = STOP;  // 匹配"start"
                else
                    next_state = MATCH_STOP;   // 匹配"stop"
            end

            MATCH_STOP: begin
                if ((buffer[3] == 8'h73) &&  // 's'
                    (buffer[2] == 8'h74) &&  // 't'
                    (buffer[1] == 8'h6F) &&  // 'o'
                    (buffer[0] == 8'h70))    // 'p'
                    next_state = STOP;  // 匹配"stop"
                else
                    next_state = NO_MATCH;   // 不匹配
            end

            NO_MATCH: begin
                    next_state = STOP;  // 没有匹配，发送0
            end

            STOP: begin
                if (valid == 0) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // 状态机输出逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            response <= 8'h30;  // 复位时清空响应
        end
        else begin
            case (state)
                MATCH_START: response <= 8'h31;  // 匹配 "start"
                MATCH_STOP: response <= 8'h32;   // 匹配 "stop"
                NO_MATCH: response <= 8'h30;     // 无匹配
                default: response <= 8'h30;
            endcase
        end
    end


    // UART 发送模块实例化
    uart_send uart_send(
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .data(response),
        .dout(dout)
    );


endmodule*/
