module debounce (
    input logic button_in,
    input logic clk_i,
    input logic reset,
    output logic button_out
);
    parameter DELAY = 20000;
    logic [23:0] count;
    logic button_prev;//trạng thái nút nhấn trước đó

    always_ff @(posedge clk_i or posedge reset) begin
        if (reset) begin
            count <= 0;
            button_prev <= 1'b1;
            button_out <= 1'b1;
        end else begin
            if (button_in != button_prev) begin//nếu tt trước đó khác với nút được nhấn hiện tại thì phải đếm rồi ghi trạng thái đấy vào prev
                button_prev <= button_in;
                count <= 0;//có vấn đề, đáng lẽ khúc này delay mới đúng
            end else if (count < DELAY) begin//xuống dòng này đồng nghĩa trạng thái đang nhấn = trạng thái trước đó tức đang bị đè phím => 0 cần delay
                count <= count + 1;
            end
            if (count == DELAY) begin
                button_out <= button_in;
            end
        end
    end
endmodule