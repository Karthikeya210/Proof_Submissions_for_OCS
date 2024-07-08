module tb_SignalGenerator;
    reg clk_2sec;
    wire signal_out;

    // Instantiate the module under test
    SignalGenerator dut (
        .clk_2sec(clk_2sec),
        .signal_out(signal_out)
    );

    // Clock generation
    reg clk = 0;
    always #1 clk = ~clk;

    // Clock the 2-second signal
    initial begin
        clk_2sec = 0;
        forever #100 clk_2sec = ~clk_2sec; // Generate 2-second signal
    end

    // Monitor and display signal_out
    initial begin
        // Wait for signal_out to stabilize
        repeat (10) begin
            #100;
        end

        // Print signal_out
        $monitor("Time: %0t, signal_out = %b", $time, signal_out);

        // Simulate for a while
        #200; // Simulate for 200 time units
        $finish; // Finish simulation
    end
endmodule
