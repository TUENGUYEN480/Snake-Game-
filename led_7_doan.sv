module led_7_doan (
    input  logic  clk_i,
    input  logic  reset_i,
    input  logic  apple_colline,
    output logic [6:0] hang_chuc,
    output logic [6:0] hang_don_vi
);

    logic [6:0] score;         // Đếm từ 0-99
    logic [3:0] bcd_tens;
    logic [3:0] bcd_units;

    // -------------------------------
    // Bắt cạnh lên của apple_colline
    logic apple_colline_d1;
    logic apple_colline_rising;

    always_ff @(posedge clk_i, posedge reset_i) begin
        if (reset_i)
            apple_colline_d1 <= 0;
        else
            apple_colline_d1 <= apple_colline;
    end

    assign apple_colline_rising = apple_colline & ~apple_colline_d1;
    // -------------------------------

    // Bộ đếm điểm số
    always_ff @(posedge clk_i, posedge reset_i) begin
        if (reset_i)
            score <= 7'd0;
        else if (apple_colline_rising) begin
            if (score < 7'd99)
                score <= score + 7'd1;
        end
    end

    // Chuyển đổi sang BCD
    always_comb begin
        bcd_tens  = score / 10;
        bcd_units = score % 10;
    end

    // Hàm chuyển BCD sang 7 đoạn
    function automatic logic [6:0] bcd_to_7seg (input logic [3:0] bcd);
        case (bcd)
            4'b0000: return 7'b1000000;
            4'b0001: return 7'b1111001;
            4'b0010: return 7'b0100100;
            4'b0011: return 7'b0110000;
            4'b0100: return 7'b0011001;
            4'b0101: return 7'b0010010;
            4'b0110: return 7'b0000010;
            4'b0111: return 7'b1111000;
            4'b1000: return 7'b0000000;
            4'b1001: return 7'b0010000;
            default: return 7'b1111111;
        endcase
    endfunction

    assign hang_chuc   = bcd_to_7seg(bcd_tens);
    assign hang_don_vi = bcd_to_7seg(bcd_units);

endmodule
