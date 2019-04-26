module xorshift(
    input clk_in,
    output reg [15:0] data_out,
    output reg output_ready
  );

  reg [63:0] state0, state1;
  reg [63:0] s, t, temp;
  reg clk;
  reg [26:0] clk_delay;
  integer state;

  initial begin
    clk = 0;
    clk_delay = 0;
    state0 = 64'd100000;
    state1 = 64'd100;
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
      s <= state1;
      state <= 1;
      output_ready <= 0;
    end
    else if(state==1)
    begin
    state0 <= s;
      t <= t^(t<<23);
      state <= 2;
    end
    else if(state==2)
    begin
      t <= t^(t>>17);
      state <= 3;
    end
    else if(state==3)
    begin
      t <= t^(s^(s>>26));
      state <= 4;
    end
    else if(state == 4)
    begin
      state1 <= t;
      temp = t+s;
      data_out <= temp[15:0];
      output_ready <= 1;
      state <= 0;
    end
  end

endmodule
