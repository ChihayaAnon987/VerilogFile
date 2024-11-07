`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/10/29 13:42:37
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input            clk,
    input            rst,  
    output reg       dout         // connect to USB_UART tx pin(V18)
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    localparam BAUD_RATE = 9600;
    localparam CLOCK_FREQ = 100000000;
    localparam DIVIDER = CLOCK_FREQ / BAUD_RATE;
    localparam DELAY_CNT_MAX = CLOCK_FREQ / 10;

    reg [1:0] current_state, next_state;
    reg [7:0] data;
    reg [3:0] bit_cnt;
    reg [31:0] baud_cnt;
    reg [31:0] delay_cnt;
    reg [4:0] index;

    reg [7:0] student_id[9:0];


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_cnt <= 0;
        end else begin
        if (current_state == DATA && baud_cnt >=  DIVIDER) begin
            if (bit_cnt < 8) begin
                bit_cnt <= bit_cnt + 1;
            end
        end
        else if (current_state == IDLE) begin
            bit_cnt <= 0;
        end
        end
    end


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE; // 初始状态为IDLE
            student_id[0] = 8'h32;  //2023311627
            student_id[1] = 8'h30;
            student_id[2] = 8'h32;
            student_id[3] = 8'h33;
            student_id[4] = 8'h33;
            student_id[5] = 8'h31;
            student_id[6] = 8'h31;
            student_id[7] = 8'h36;
            student_id[8] = 8'h32;
            student_id[9] = 8'h37;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            IDLE:  next_state = (delay_cnt >= DELAY_CNT_MAX) ? START : IDLE;
            START: next_state = (baud_cnt >= DIVIDER) ? DATA : START;
            DATA:  next_state = (bit_cnt >= 8) ? STOP : DATA;
            STOP:  next_state = (baud_cnt >= DIVIDER) ? IDLE : STOP;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dout <= 1'b1;          // 初始高电平
            baud_cnt <= 0;
            delay_cnt <= 0;
            index <= 0;
            data <= 1'b0;
        end else begin
        if (baud_cnt < DIVIDER) begin
            baud_cnt <= baud_cnt + 1;
        end else begin
            baud_cnt <= 0;
        end
        
        case (current_state)
            IDLE: begin
                dout <= 1'b1;
                baud_cnt <= 0;
                delay_cnt <= (delay_cnt >= DELAY_CNT_MAX) ? 0 : (delay_cnt + 1);
                if (delay_cnt >= DELAY_CNT_MAX) begin
                    data <= student_id[index];
                    index <= (index + 1) % 10;
                end
            end

            START: begin
                dout <= 1'b0;
            end

            DATA: begin
                dout <= data[bit_cnt];
                if (bit_cnt >= 8) begin
                    dout <= 1'b1;
                end
            end

            STOP: begin
                dout <= 1'b1;
            end
            
            default: dout <= 1'b1;
        endcase
        end
    end
endmodule

