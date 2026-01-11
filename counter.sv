module counter #( // Emits a rising edge when the count is reached
    parameter int unsigned max
)(
    input logic in,
    input logic rst,
    output logic out
);
    logic [31:0] count = 0; // Consists of enough bits to represent the full count

    always_ff @(posedge in or posedge rst) begin
        if (rst) begin
            count <= 0;
            out <= 0;
        end
        else begin
            if (count >= max) begin
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