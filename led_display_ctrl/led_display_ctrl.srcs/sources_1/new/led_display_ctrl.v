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

module led_display_ctrl (
    input wire clk,
    input wire [7:0] sw,
    input wire s1_raw,
    input wire s2_raw,
    input wire s3_raw,
    output reg [6:0] segment_select,
    output reg [7:0] digit_select,
    output reg dp_select
);


    reg [3:0] ones_count;
    reg [4:0] count_to_20;
    reg [6:0] s3_count;

    parameter DEBOUNCE_TIME = 1000000; // 10ms
    reg [1:0] button1_state, button2_state, button3_state;
    reg [27:0] button1_timer, button2_timer, button3_timer;
    reg button1_stable, button2_stable, button3_stable;
    reg button1_last_stable, button2_last_stable, button3_last_stable;
    
    always @(posedge clk) begin
        button1_state <= {button1_state[0], s1_raw};
        button2_state <= {button2_state[0], s2_raw};
        button3_state <= {button3_state[0], s3_raw};
    end
    
    always @(posedge clk) begin
        if (button1_state[1] == 1'b0 && button1_state[0] == 1'b1) begin
            button1_timer <= 0;
        end else if (button1_state[1] == 1'b1) begin
            if (button1_timer < DEBOUNCE_TIME) begin
                button1_timer <= button1_timer + 1;
            end else begin
                button1_stable <= 1;
            end
        end else begin
            button1_stable <= 0;
        end
        if (button2_state[1] == 1'b0 && button2_state[0] == 1'b1) begin
            button2_timer <= 0;
        end else if (button2_state[1] == 1'b1) begin
            if (button2_timer < DEBOUNCE_TIME) begin
                button2_timer <= button2_timer + 1;
            end else begin
                button2_stable <= 1;
            end
        end else begin
            button2_stable <= 0;
        end
        if (button3_state[1] == 1'b0 && button3_state[0] == 1'b1) begin
            button3_timer <= 0;
        end else if (button3_state[1] == 1'b1) begin
            if (button3_timer < DEBOUNCE_TIME) begin
                button3_timer <= button3_timer + 1;
            end else begin
                button3_stable <= 1;
            end
        end else begin
            button3_stable <= 0;
        end
    end
    
    wire button1_edge_rising = button1_stable && !button1_last_stable;
    wire button2_edge_rising = button2_stable && !button2_last_stable;
    wire button3_edge_rising = button3_stable && !button3_last_stable;
    
    always @(posedge clk) begin
        button1_last_stable <= button1_stable;
        button2_last_stable <= button2_stable;
        button3_last_stable <= button3_stable;
    end


    always @(posedge clk) begin
        dp_select <= 1'b1;
    end

    reg [23:0] timer_count;
    wire [27:0] count_max;
    wire count_end;
    assign count_max = 28'd10000000; // 100ms
    assign count_end = (timer_count == count_max);


    always @(posedge clk) begin
        if (button1_edge_rising) begin           
            timer_count <= 0;
            count_to_20 <= 0;
        end
        if (count_to_20 == 20 && button2_edge_rising) begin
            count_to_20 <= 0;
        end
        if (count_end) begin
            if (count_to_20 < 20) begin 
                count_to_20 <= count_to_20 + 1;
            end 
            else begin
                count_to_20 <= 20;
            end
            timer_count <= 0;
        end
        else begin
            timer_count <= timer_count + 1;
        end
    end

    always @(posedge clk) begin
        if (button1_edge_rising) begin
            ones_count <= 0;
        end 
        else begin
            ones_count <= sw[0] + sw[1] + sw[2] + sw[3] + sw[4] + sw[5] + sw[6] + sw[7];
        end
    end


    always @(posedge clk) begin
        if (button1_edge_rising) begin
            s3_count <= 0;
        end
        else if (button3_edge_rising) begin
            s3_count <= s3_count + 1;
        end
        if (s3_count == 100) begin
            s3_count <= 0;
        end
    end


    function [6:0] get_segment;
        input [3:0] value;
        begin
            case (value)
                0: get_segment = 7'b0000001;
                1: get_segment = 7'b1001111;
                2: get_segment = 7'b0010010;
                3: get_segment = 7'b0000110;
                4: get_segment = 7'b1001100;
                5: get_segment = 7'b0100100;
                6: get_segment = 7'b0100000;
                7: get_segment = 7'b0001111;
                8: get_segment = 7'b0000000;
                9: get_segment = 7'b0000100;
                default: get_segment = 7'b1111111;
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

    always @(posedge clk) begin
        if(button1_edge_rising) begin
            digit_select <= 8'b11111111;
            segment_select <= 7'b1111111;
        end
        else begin
            case (scan_index)
                3'd0: begin
                    digit_select <= 8'b11111110;
                    segment_select <= get_segment(count_to_20 % 10);
                end
                3'd1: begin
                    digit_select <= 8'b11111101;
                    segment_select <= get_segment(count_to_20 / 10);
                end
                3'd2: begin
                    digit_select <= 8'b11111011;
                    segment_select <= get_segment(s3_count % 10);
                end
                3'd3: begin
                    digit_select <= 8'b11110111;
                    segment_select <= get_segment(s3_count / 10);
                end
                3'd4: begin
                    digit_select <= 8'b11101111;
                    segment_select <= get_segment(ones_count % 10);
                end
                3'd5: begin
                    digit_select <= 8'b11011111;
                    segment_select <= get_segment(ones_count / 10);
                end
                3'd6: begin
                    digit_select <= 8'b10111111;
                    segment_select <= get_segment(7);
                end
                3'd7: begin
                    digit_select <= 8'b01111111;
                    segment_select <= get_segment(2); 
                end
            endcase
        end
    end

endmodule
