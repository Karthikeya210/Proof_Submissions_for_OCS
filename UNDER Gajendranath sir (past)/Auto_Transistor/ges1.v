module clks(
    input wire clk,
    output wire clk2, clk3, clk4, clk5,
    output wire [5:0] count
);
    wire [1:0] b_eq_11;
    wire [1:0] b_neq_11;
    wire [5:0] count_lte_10;
    wire [5:0] count_lte_20;
    wire [5:0] count_lte_18;
    wire [5:0] count_lt_20;
    
    and #2 u_b_eq_11 (b_eq_11, b, 2'b11);
    and #2 u_b_neq_11 (b_neq_11, b, 2'b00);
    and #2 u_count_lte_10 (count_lte_10, count, 6'b000000);
    and #2 u_count_lte_20 (count_lte_20, count, 6'b000000);
    and #2 u_count_lte_18 (count_lte_18, count, 6'b000000);
    and #2 u_count_lt_20 (count_lt_20, count, 6'b000000);
    
    assign clk2 = clk & count_lte_10[5];
    assign clk3 = ~clk2;
    assign clk4 = clk2 & count_lt_20[5];
    assign clk5 = count_lte_18[5] & ~count_lt_20[5];
    
    always @(posedge clk) begin
        count_reg <= count_reg + 1'b1; // Increment the counter value
        q <= q + 1'b1; // Use non-blocking assignment
        b <= b_neq_11; // Reset b to 2'b00
    end
    
    always @(posedge clk) begin
        if (b_eq_11[1])
            b <= b_neq_11[1];
        else
            b <= b + 1'b1; // Use non-blocking assignment
    end
    
    always @* begin
        if (count_lte_10[5])
            clk2_d <= clk ;
        else if (count_lte_20[5])
            clk2_d <= 1'b0;
        
        if (count_lte_20[5])
            clk3_d <= 1'b0;
        
        if (count_lte_18[5])
            clk5_d <= 1'b1;
        
        if (count_lt_20[5]) begin
            clk4_d <= 1'b1;
            clk5_d <= 1'b0;
        end
        
        if (count > 20) 
            count_reg <= 6'b000000; // Reset count_reg
    end 
    
    assign count = count_reg;
endmodule
