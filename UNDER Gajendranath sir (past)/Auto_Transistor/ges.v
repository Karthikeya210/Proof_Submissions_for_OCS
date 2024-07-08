module clks(
    input wire clk,
    output clk2, clk3, clk4,clk5,clk22,clk23,
    output [5:0] count
);
    reg [5:0] count_reg = 6'b000000; // Initialize count_reg

    reg clk2_d,clk3_d,clk4_d,clk5_d;
    reg clk2_d2,clk3_d2,clk4_d2,clk5_d2;

    always @(posedge clk) begin
        count_reg <= count_reg + 1; // Increment the counter value
    end
    always @(*) begin
        if (count<=10)
        begin
            clk2_d <= clk ;
            clk3_d <= ~clk2_d;
            clk4_d <= 1'b0;
            clk5_d <= 1'b0;
            clk2_d2 <= 1'b0 ;
            clk3_d2 <= 1'b0;
        end 
        if (count > 10 && count <= 20)
        begin
            clk2_d2 <= clk ;
            clk3_d2 <= ~clk2_d2;
            clk2_d <= 1'b0;
            clk3_d <= 1'b0;
        end
        if (count > 10 && count <= 18)
            clk5_d <= 1'b1;
        if (count > 18 && count < 20)
        begin
            clk4_d <= 1'b1;
            clk5_d <= 1'b0;
        end
        if (count > 20) 
            count_reg <= 6'b000000; // Reset count_reg
    end 

    assign clk2 = clk2_d;
    assign clk4 = clk4_d;
    assign clk3 = clk3_d;
    assign clk5 = clk5_d;
    assign clk22 = clk2_d2;
    assign clk23 = clk3_d2;
    assign count = count_reg;
endmodule

//Qestions Should i make channel 2 in a different code or the same
// cadence
