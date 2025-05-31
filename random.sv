module random (
    input  logic clk,
    input  logic rst,
    output logic [4:0] random_out
);
    logic [4:0] lfsr;

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 5'b00001;
        else begin
            lfsr[4:1] <= lfsr[3:0];
            lfsr[0]   <= lfsr[2] ^ lfsr[4];
        end
    end

    assign random_out = lfsr;
endmodule
