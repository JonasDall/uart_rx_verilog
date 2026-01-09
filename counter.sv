module counter #( // Emits a resing edge when the count is reached
    parameter integer max
)(
    input in,
    input rst,
    output reg out
);
    logic [$clog2(MAX_COUNT+1)-1:0] count;

    always @(posedge in or posedge rst) begin
        if (rst)
            count = 0;
    end
endmodule