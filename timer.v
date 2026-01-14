module counter #( // Emits a rising edge when the count is reached
    parameter integer time,
)(
    input wire in,
    input wire rst,
    output wire out = 0,
);
    reg [width:0] count

    always @(posedge in or posedge rst) begin
        if (rst) begin
            count <= 0;
            out <= 0;
        end
        else begin
            if (count >= max_u) begin
                count <= 0;
                out <= 1;
            end
            else begin
                count <= count + 1;
                out <= 0;
            end
        end
    end
endmodule