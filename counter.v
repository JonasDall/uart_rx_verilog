module counter #(
    parameter integer clock_rate=1000000000,
    parameter integer baud_rate=250000
)(
    input clk,
    input rst,
    output reg tick
);
    localparam integer max = clock_rate / baud_rate;
    reg [31:0] count; //32 bit to allow most numbers

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;

        if (clk) begin
            if (count >= max - 1)
                count <= 0;
            
            if (count == 0)
                tick <= 1'b1;
            else
                tick <= 1'b0;

            count <= count + 1;
        end
    end
endmodule