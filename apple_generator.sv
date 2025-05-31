module apple_generator(
    input  logic clk_i,
    input  logic reset_i,
    input  logic apple_colline_o,       // báo rắn vừa ăn táo
    input  logic [4:0] lfsr_x,
    input  logic [4:0] lfsr_y,
    input  logic valid_apple,           // kiểm tra trùng đầu/thân

    output logic [4:0] rand_x,
    output logic [4:0] rand_y,
    output logic [9:0] apple_x,
    output logic [9:0] apple_y,
    output logic [8:0] apple_count
);

    typedef enum logic [1:0] {
        IDLE,
        GENERATE,
        CHECK
    } state_t;

    state_t state;

    logic [9:0] random_apple_x;
    logic [9:0] random_apple_y;

    assign random_apple_x = 35 + (rand_x * 30);
    assign random_apple_y = 45 + (rand_y * 30);

    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            state       <= IDLE;
            apple_x     <= 10'd425;
            apple_y     <= 10'd135;
            apple_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (apple_colline_o) state <= GENERATE;
                end

                GENERATE: begin
                    rand_x <= lfsr_x % 19;
                    rand_y <= lfsr_y % 13;
                    state  <= CHECK;
                end

                CHECK: begin
                    if (valid_apple) begin
                        apple_x     <= random_apple_x;
                        apple_y     <= random_apple_y;
                        apple_count <= apple_count + 1;
                        state       <= IDLE;
                    end else begin
                        state <= GENERATE; // thử lại nếu trùng rắn
                    end
                end
            endcase
        end
    end

endmodule