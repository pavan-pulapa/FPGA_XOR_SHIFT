module tb_xorshift();
  reg clk;
  wire [15:0] data_out;
  wire output_ready;

  xorshift x1(
    .clk_in(clk),
    .data_out(data_out),
    .output_ready(output_ready)
    );

  initial
  begin
    $dumpfile("test_xorshift.vcd");
    $dumpvars;
    clk  = 0;
    #100000 $finish;
  end

  always
  begin
    #5 clk = ~clk;
  end

endmodule
