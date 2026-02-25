module drawer (
    input logic display_enable_i,
    input logic head_snake_gfx_i,
    input logic body_snake_gfx_i,
    input logic apple_gfx_i,
    input logic border_gfx_i,
    output logic [7:0] r_o,
    output logic [7:0] g_o,
    output logic [7:0] b_o
);

    always_comb begin
        // nền màu trắng
        r_o = 8'd255;
        g_o = 8'd255;
        b_o = 8'd255;

        if (display_enable_i) begin
            if (border_gfx_i) begin
                //  màu xanh dương
                r_o = 8'd0;
                g_o = 8'd0;
                b_o = 8'd255;
            end else if (head_snake_gfx_i) begin
                //  màu đỏ
                r_o = 8'd255;
                g_o = 8'd0;
                b_o = 8'd0;
				end else if ( body_snake_gfx_i) begin
					// màu đỏ nhạt 
					 r_o = 8'd0255;
					 g_o = 8'd100;
					 b_o = 8'd100;
            end else if (apple_gfx_i) begin
                // Táo màu xanh lá cây
                r_o = 8'd0;
                g_o = 8'd255;
                b_o = 8'd0;
            end
        end
    end

endmodule