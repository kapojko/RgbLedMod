`timescale 1ns / 1ps

module RgbLed # (
    parameter BLINK_PERIOD = 31'd2700_0000, // 1.0 s
    parameter VALUE_ON     = 1'b0 // default is active low
) (
    input         clk,      // 27 MHz default
    input         n_rst,    // Reset, active low
    input         blink_en, // Blink enable
    input  [23:0] rgb,      // RGB value (8 bits each)
    output        led_r,    // Red input of 3-input RGB LED (PWM), pull-up
    output        led_g,    // Green input of 3-input RGB LED (PWM), pull-up
    output        led_b     // Blue input of 3-input RGB LED (PWM), pull-up
);

localparam VALUE_OFF = ~VALUE_ON;

reg [31:0] counter;   // Blink counter
reg [7:0]  cycle;     // PWM cycle
reg        blink_cur; // Current blink state
reg [2:0]  led;       // LED output

always @(posedge clk or negedge n_rst) begin
    if (!n_rst || ~blink_en)
        blink_cur <= 1'b0;
    else if (counter < BLINK_PERIOD / 2)
        blink_cur <= 1'b0;
    else
        blink_cur <= 1'b1;
end

always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        counter <= 31'd0;
        cycle <= 8'd0;
        led <= {3{VALUE_OFF}};
    end
    else begin
        // Red PWM
        if (cycle < rgb[23:16])
            led[2] <= VALUE_ON ^ blink_cur; // light on when blink inactive
        else
            led[2] <= VALUE_OFF; // light off

        // Green PWM
        if (cycle < rgb[15:8])
            led[1] <= VALUE_ON ^ blink_cur; // light on when blink inactive
        else
            led[1] <= VALUE_OFF; // light off

        // Blue PWM
        if (cycle < rgb[7:0])
            led[0] <= VALUE_ON ^ blink_cur; // light on when blink inactive
        else
            led[0] <= VALUE_OFF; // light off

        // Update PWM cycle
        if (cycle == 8'd254)
            cycle <= 8'd0;
            // NOTE: cycle consist of 255 steps (not 256) to enable full-off and full-on
        else
            cycle <= cycle + 1'd1;

        // Update blink counter
        if (counter == BLINK_PERIOD - 1)
            counter <= 31'd0;
        else
            counter <= counter + 1'd1;
    end
end

assign led_r = led[2];
assign led_g = led[1];
assign led_b = led[0];

endmodule
