module uart (
  //inputs
  // input clk,  //100MHz
  input btn,
  // input rst,
  output [7:0] led
);
  logic rst;

  counter #(.max(3)) counter_1 (
    .in(!btn),
    .rst(rst),
    .out(led[0])
  );

  assign led[1] = !btn;
  assign rst = '0;
  assign led[7:2] = '0;
  
endmodule