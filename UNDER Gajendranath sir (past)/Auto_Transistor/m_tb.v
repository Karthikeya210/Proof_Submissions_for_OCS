module m_tb;
wire Ch1,Ch_inv,A_zero,Rest,Ch2,Ch2_inv;
wire [5:0] t_count;
reg t_clk=1;
always #1 t_clk = ~t_clk;
clks mygate (.clk(t_clk),.clk2(Ch1),.clk3(Ch_inv),.clk4(A_zero),.clk5(Rest),.count(t_count),.clk22(Ch2),.clk23(Ch2_inv));

initial 
begin 
    $dumpfile("simulation.vcd"); // Specify the VCD filename
    $dumpvars(0, m_tb); // Dump all variables in module m_tb
    #2;
    $monitor($time, " t_clk=%b t_clk2=%b t_clk3=%b t_clk4=%b t_clk5= %b t_clk22= %b t_clk23= %b t_count=%b",
                 t_clk, Ch1, Ch_inv, A_zero, Rest, Ch2, Ch2_inv, t_count);
    
    #60;
    $finish;
end 
endmodule