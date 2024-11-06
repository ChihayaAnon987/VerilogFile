`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChihayaAnon987
// 
// Create Date: 2024/10/29 14:06:02
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

module testbench;

reg clk;
wire dout;

state_machine uut (
    .clk(clk),
    .dout(dout)
);

localparam CLOCK_FREQ = 100*1e6;         //clock freq: 100MHz
localparam PERIOD     = 1e9/CLOCK_FREQ;  // clock ycle: 10ns
localparam BAUD_RATE  = 9600;
localparam DIVIDER    = 10416; // 9600:10416, 115200:867

always #(PERIOD/2) clk = ~clk;

initial begin
    clk = 0;

end

endmodule
/*
module testbench;


reg clk;
wire dout;

state_machine uut (
    .clk(clk),
    .dout(dout)
);

localparam CLOCK_FREQ = 100*1e6;         //clock freq: 100MHz
localparam PERIOD     = 1e9/CLOCK_FREQ;  // clock ycle: 10ns
localparam BAUD_RATE  = 9600;
localparam DIVIDER    = 10416; // 9600:10416, 115200:867,


always #(PERIOD/2) clk = ~clk;


integer bit_index = 0;    
reg [9:0] expected_bits; 
reg [3:0] all_check_error; 
reg check_error;         


initial begin
    clk   = 0;
    check_error     = 1'b0; 
    all_check_error = 1'b0; 
    expected_bits   = 10'h0;
    #(12*PERIOD);

    // test case1: 8'hA5 (10100101)
    expected_bits = {1'b1, data, 1'b0}; 
    #PERIOD;     // valid should last one clock
    check_uart_output(8'hA5);   
    #(100*PERIOD);

    // test case2: 8'h3C (00111100)
    expected_bits = {1'b1, data, 1'b0}; 
    #PERIOD;
    check_uart_output(data);   
    #(20000*PERIOD);

    // test case3: 8'hFF (11111111)
    expected_bits = {1'b1, data, 1'b0}; 
    #PERIOD;
    check_uart_output(8'hFF);   
    #(10000*PERIOD);

    // test case4: 8'h00 (00000000)
    expected_bits = {1'b1, data, 1'b0}; 
    #PERIOD;
    check_uart_output(data);   
    #(10*PERIOD);  

    // test case5: 8'h5A (01011010)
    expected_bits = {1'b1, data, 1'b0}; 
    #PERIOD;
    check_uart_output(data);   
    #(100*PERIOD);

    if (!all_check_error)
        $display("All tests passed successfully!");
    else
        $display("%d test failed!", all_check_error);

    $display("Uart baud rate = %d, freq divider = %d",BAUD_RATE, DIVIDER);
    $finish;
end


task check_uart_output;
    input [7:0]       i_data ;
    begin
        $display("Test case :%x start", i_data);
        bit_index   = 0;
        check_error = 0;
        repeat (10) begin         // total 10 bits
            #(DIVIDER*PERIOD);    // time for one bit
            if (dout !== expected_bits[bit_index]) begin
                $display("Error at time %t, %d th bit: Expected %b, Got %b", $time, bit_index, expected_bits[bit_index], dout);
                check_error = 1'b1;
            end
            bit_index = bit_index + 1; 
        end
        if (check_error) begin
            all_check_error = all_check_error + 1'b1; 
            $display("Test case %x failed\n", i_data);
        end 
        else $display("Test case %x success\n", i_data);
    end
endtask

endmodule*/
