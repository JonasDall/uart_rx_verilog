module uart #(
  parameter CLOCK_BAUD_RATIO = 400,
  parameter BIT_WIDTH = 8
)(
  input wire clk,
  input wire rst,
  input wire ready,
  input wire success,
  output reg [BIT_WIDTH-1:0] byte
);
  timer #(.times(100_000_000)) timer_1 (
    .in(clk),
    .rst(rst),
    .out(out)
  );

  always_ff @(negedge rst or posedge out) begin
    if (!rst)
      count <= 0;
    else
    count <= count + 1;
  end
endmodule