module xorshift_final(
    input clk_in,
    output reg [15:0] data_out,
    output reg output_ready
  );

  reg [63:0] state0;
  reg [63:0] s, t, temp;
  reg clk;
  reg [26:0] clk_delay;
  integer state;

  initial begin
    clk = 0;
    clk_delay = 0;
    state0 = 64'd100000;
    
    state = 0;
  end

  always @ (posedge clk_in) begin
    clk_delay = clk_delay+1;
    if(clk_delay==27'd10)
    begin
      clk_delay = 0;
      clk = ~clk;
    end
  end

  always @ ( posedge clk ) begin
    if(state==0)
    begin
      t <= state0;
      
      state <= 1;
      output_ready <= 0;
    end
    else if(state==1)
    begin
    state0 <= s;
      t <= t^(t<<13);
      state <= 2;
    end
    else if(state==2)
    begin
      t <= t^(t>>17);
      state <= 3;
    end
    else if(state==3)
    begin
      t <= t^(t<<5);
      state <= 4;
    end
    else if(state == 4)
    begin
      state0 <= t;
      temp = t;
      data_out <= temp[15:0];
      output_ready <= 1;
      state <= 0;
    end
  end

endmodule
