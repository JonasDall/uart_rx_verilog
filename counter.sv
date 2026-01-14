module counter #( // Emits a rising edge when the count is reached
    parameter int unsigned max
)(
    input wire in,
    input wire rst,
    output wire out
);
    output logic [width:0] count

    always_ff @(posedge in or posedge rst) begin
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