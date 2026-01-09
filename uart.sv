//blink all 8 leds on Alchitry-Cu Board

module uart (
  //inputs
  input clk,  //100MHz
  input rst,
  output tick
);
  counter counter_1 #(
    .max=400
  )(
    .in(clk),
    .rst(rst),
    .out(tick)
  );
  
endmodule
