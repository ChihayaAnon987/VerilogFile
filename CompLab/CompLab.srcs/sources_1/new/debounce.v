`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/11/05 14:52:47
// Design Name: 
// Module Name: debounce
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

module debounce(
    input clk,
    input button_raw,
    output reg button_rising_edge
);

    parameter DEBOUNCE_TIME = 1000000; // 10ms
    reg [1:0] button_state;
    reg [27:0] button_timer;
    reg button_stable,button_last_stable;

    always @(posedge clk) begin
        button_state <= {button_state[0], button_raw};
        button_last_stable <= button_stable;
    end

    always @(posedge clk) begin
        if (button_state[1] == 1'b0 && button_state[0] == 1'b1) begin
            button_timer <= 0;
        end else if (button_state[1] == 1'b1) begin
            if (button_timer < DEBOUNCE_TIME) begin
                button_timer <= button_timer + 1;
            end else begin
                button_stable <= 1;
            end
        end else begin
            button_stable <= 0;
        end
    end
    always @(*) begin
        button_rising_edge = button_stable && !button_last_stable;
    end

endmodule