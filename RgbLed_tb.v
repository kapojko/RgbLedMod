`timescale 1ns / 1ps

module RgbLed_tb;

// Inputs
reg        clk;
reg        n_rst;
reg        blink_en;
reg [23:0] rgb;

// Outputs
wire led_r;
wire led_g;
wire led_b;

// Instantiate the Unit Under Test (UUT)
RgbLed rgbLedInst (
    .clk(clk),
    .n_rst(n_rst),
    .blink_en(blink_en),
    .rgb(rgb),
    .led_r(led_r),
    .led_g(led_g),
    .led_b(led_b)
);

// Clock generation
always #18.52 clk = ~clk; // 27 MHz clock

initial begin
    // Initialize Inputs
    clk = 0;
    n_rst = 0;
    blink_en = 0;
    rgb = 24'hFF0000; // Red

    // Reset
    #100 n_rst = 1;

    // Test cases
    // Case 1: Blink disabled
    #500 blink_en = 0;
    #500 rgb = 24'h00FF00; // Green
    #500 rgb = 24'h0000FF; // Blue
    #500 rgb = 24'hFFA050; // Orange
    #500 rgb = 24'h000000; // Off

    // Case 2: Blink enabled
    #500 blink_en = 1;
    #10000 rgb = 24'hFF0000; // Red
    #10000 rgb = 24'h00FF00; // Green
    #10000 rgb = 24'h0000FF; // Blue
    #10000 rgb = 24'hFFA050; // Orange
    #10000 rgb = 24'h000000; // Off

    #1000 $finish;
end

endmodule
