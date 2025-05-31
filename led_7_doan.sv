
module led_7_doan (
    input  logic  clk_i,
    input  logic  reset_i,
    input  logic  apple_colline,
    output logic [6:0] hang_chuc,
    output logic [6:0] hang_don_vi
);

    // Biến đếm trung gian, tăng mỗi khi apple_colline cao
    // Cần đủ bit để đếm tới 99 * 5 = 495. 9 bit (0-511) là đủ.
    logic [8:0] count;

    // BCD digits for displayed score
    logic [3:0] bcd_tens;
    logic [3:0] bcd_units;

    // Bộ đếm trung gian
    always_ff @(posedge clk_i, posedge reset_i) begin
        if (reset_i)
            count <= 9'd0; // Đặt lại bộ đếm trung gian về 0
        else if (apple_colline)
            // Tăng bộ đếm trung gian khi apple_colline cao
            // Giới hạn bộ đếm ở 99 * 5 = 495 để điểm hiển thị max là 99
            if (count < 9'd495)
                count <= count + 9'd1;
            else
                count <= count; // Giữ nguyên nếu đã đạt giới hạn
        else
            count <= count; // Giữ nguyên bộ đếm
    end

    // Chuyển đổi bộ đếm trung gian sang điểm số BCD hiển thị
    // score = count / 5. Điểm hiển thị sẽ tăng 1 sau mỗi 5 lần count tăng.
    always_comb begin
        logic [8:0] displayed_score; // Biến tạm tính điểm hiển thị

        // Tính điểm dựa trên bộ đếm, chia lấy phần nguyên cho 5
        displayed_score = count / 9'd5;

        // Đảm bảo điểm hiển thị không vượt quá 99
        if (displayed_score > 9'd99)
            displayed_score = 9'd99;

        // Chuyển điểm hiển thị sang BCD
        bcd_tens = displayed_score / 9'd10;    // Lấy phần nguyên khi chia cho 10 để được hàng chục
        bcd_units = displayed_score % 9'd10;   // Lấy phần dư khi chia cho 10 để được hàng đơn vị
    end

    // Hàm chuyển đổi số BCD 4 bit sang mẫu 7 đoạn (Common Cathode)
    // Sử dụng các mẫu đúng đã sửa trước đó
    // Thứ tự bit đầu ra: [a, b, c, d, e, f, g]
      function automatic logic [6:0] bcd_to_7seg (input logic [3:0] bcd);
        case (bcd)
            4'b0000:  return 7'b1000000;
            4'b0001: return 7'b1111001;
            4'b0010: return 7'b0100100;
            4'b0011: return 7'b0110000;
            4'b0100: return 7'b0011001;
            4'b0101: return 7'b0010010;
            4'b0110: return 7'b0000010;
            4'b0111: return 7'b1111000;
            default: return  7'b1111111;
        endcase
    endfunction

    // Gán tín hiệu đầu ra 7 đoạn
    assign hang_chuc   = bcd_to_7seg(bcd_tens);
    assign hang_don_vi = bcd_to_7seg(bcd_units);

endmodule