`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/11/05 14:52:47
// Design Name: 
// Module Name: CompLab
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


module CompLab(
    input                   clk,
    input wire              s1_raw,     //rst
    input wire              s3_raw,
    input wire [7:0]        sw,
    input                   din,        // connect to usb_uart rx pin
    output wire             dout,       // connect to usb_uart tx pin
    output wire [7:0]        segment_select,
    output wire [7:0]        digit_select
);

    wire button1_rising_edge;
    wire button3_rising_edge;

    debounce debounce1(
        .clk(clk),
        .button_raw(s1_raw),
        .button_rising_edge(button1_rising_edge)
    );

    debounce debounce3(
        .clk(clk),
        .button_raw(s3_raw),
        .button_rising_edge(button3_rising_edge)
    );
    
    digit_display digit_display(
        .clk(clk),
        .rst(button1_rising_edge),
        .data(sw),
        .valid(button3_rising_edge),
        .segment_select(segment_select),
        .digit_select(digit_select)
    );

    string_match string_match(
        .clk(clk),
        .rst(button1_rising_edge),
        .din(din),
        .dout(dout)
    );

endmodule