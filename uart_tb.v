
// Testbench template

`default_nettype none `timescale 10 ns / 1 ns


module blinky_tb;

  // Input.
  reg clk = 0;
  reg rst = 0;
  reg tick = 0;

  uart uart_1 (
    .clk(clk),
    .rst(rst),
    .tick(tick)
  );

  initial begin
    // Dump vars to the output .vcd file
    $dumpvars(0, uart_tb);

    repeat (50) begin
      #10 clk = ~clk;
    end

    $display("End of simulation");
    $finish;
  end

endmodule
