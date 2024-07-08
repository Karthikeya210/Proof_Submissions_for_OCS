module SignalGenerator (
    input wire clk_2sec,   // 2-second clock signal
    output wire signal_out // Generated signal
);

    reg [31:0] counter = 0; // 32-bit counter for tracking cycles

    always @(posedge clk_2sec) begin
        if (counter < 10) begin // 10 cycles = 20 seconds (on duration)
            signal_out <= 1'b1; // Signal is high for 20 seconds
        end else if (counter < 20) begin // 10 cycles = 20 seconds (off duration)
            signal_out <= 1'b0; // Signal is low for 20 seconds
        end else begin
            counter <= 0; // Reset the counter to repeat the cycle
        end

        counter <= counter + 1;
    end

endmodule






