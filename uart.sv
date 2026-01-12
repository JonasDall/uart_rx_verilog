module uart #(
  parameter int unsigned clock_rate = 100000000,
  parameter int unsigned baud_rate = 250000,
  parameter int unsigned n_bits = 8,
  parameter int unsigned n_samples = 1
)(
  //inputs
  input clk,
  input data,
  output bit,
  output bit_ready,
  output packet_complete,
  output packet_successfull
);
  // Enums
  typedef enum logic [2:0] { 
    IDLE,
    INIT,
    DELAY,
    READ,
    STOP
  } state_t;

  // Definitions
  localparam integer unsigned rate_ratio = clock_rate / baud_rate; // Ratio of clock to baud
  localparam integer unsigned sample_count = rate_ratio / n_samples; // Amount of clock cycles per sample
  localparam integer unsigned delay_cycles = (1/(clock_rate/rate_ratio))*(1+1/(n_samples+1)); // Amount of clock cycles to wait before sampling
  state_t current_state = IDLE, next_state; // Initial states
  logic delay_reset = 0, delay_out; // Delay clock connections
  logic [$clog2(delay_cycles):0] empty_1; // Delay clock empty connection
  logic [$clog2(sample_count):0] empty_2; // Delay clock empty connection
  logic [$clog2(n_samples):0] bit_value; // Accumulated value of a single

  // Modules
  counter #(.max(delay_cycles), .width($clog2(delay_cycles))) delay_clock (
    .in(clk),
    .rst(delay_reset),
    .out(delay_out),
    .count(empty_1)
  );

  counter #(.max(sample_count), .width($clog2(sample_count))) sample_clock (
    .in(clk),
    .rst(rst),
    .out(tick),
    .count(empty_2)
  );

  counter #(.max(127), .width(7)) bit_clock (
    .in(tick),
    .rst(rst),
    .out(led[7]),
    .count(led[6:0])
  );

  always_ff @(posedge clk) begin
    current_state <= next_state;
    case(current_state)
      IDLE: begin
        if (!data)
          next_state <= INIT;
        else
          next_state <= IDLE;
      end
      INIT: begin
        delay_reset <= 1;
        next_state <= DELAY;
      end
      DELAY: begin
        delay_reset <= 0;
        if (delay_out)
          next_state <= READ;
        else
          next_state <= DELAY;
      end
      READ: begin

      end
    endcase
  end
endmodule