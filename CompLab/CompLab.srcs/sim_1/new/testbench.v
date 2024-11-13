`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/06 23:32:57
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


module testbench();

localparam CLK_FREQ = 100_000_000;          // clock frequency: 100 MHz
localparam PERIOD   = 1e9/CLK_FREQ;         // clock cycle: 10ns
localparam BAUD_RATE = 9600;      
localparam DIVIDER = CLK_FREQ / BAUD_RATE;  // clocks for one bit, should be 10416

reg         clk;
reg         rst;
reg         din;
wire        dout;
string_match uut (
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

always #(PERIOD/2) clk = ~clk;

reg [7:0] test_data[0:9];   // 10 test cases
integer i;                 


initial begin
    clk = 0;
    rst = 1;
    din = 1; 
    test_data[0] = 8'h73;  // 0101_0101
    test_data[1] = 8'h74;  // 1010_0011
    test_data[2] = 8'h61;  // 0000_1111
    test_data[3] = 8'h72;  // 1111_0000
    test_data[4] = 8'h74;  // 0011_0011
    test_data[5] = 8'hCC;  // 1100_1100
    test_data[6] = 8'hFF;  // 1111_1111
    test_data[7] = 8'h00;  // 0000_0000
    test_data[8] = 8'h5A;  // 0101_1010
    test_data[9] = 8'hA5;  // 1010_0101
    #(10*PERIOD) rst = 0; 
    
    for (i = 0; i < 10; i = i + 1) begin
        send_byte(test_data[i]);  
    end
    #(10*PERIOD)
    $finish;
end


task send_byte(input [7:0] byte);
    integer j;
    begin
        din = 0;  // start bit
        #(DIVIDER*PERIOD);

        for (j = 0; j < 8; j = j + 1) begin    // 8bit data
            din = byte[j];
            #(DIVIDER*PERIOD);
        end

        din = 1;    // stop bit
        #(DIVIDER*PERIOD);
    end
endtask

endmodule