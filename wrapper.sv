module wrapper (

    input logic CLOCK_50,
    input logic [1:0] SW,
    input logic [3:0] KEY,
    output logic [1:0] LEDR,
    output logic [3:0] LEDG,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic VGA_HS,
    output logic VGA_VS,
    output logic VGA_CLK,
    output logic VGA_BLANK,
    output logic [7:0] VGA_R,
    output logic [7:0] VGA_G,
    output logic [7:0] VGA_B
  );
  assign LEDR[1:0] = SW[1:0];
  assign LEDG[3:0] = KEY[3:0];
  top top_inst (
        .clk_i(CLOCK_50),
        .reset_i(SW[0]),
        .enter_i(SW[1]),
        .KEY_0(KEY[0]),
        .KEY_1(KEY[1]),
        .KEY_2(KEY[2]),
        .KEY_3(KEY[3]),
        .hang_chuc(HEX1),
        .hang_don_vi(HEX0),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .display_on(VGA_BLANK),
        .vga_clk(VGA_CLK),
        .r_o(VGA_R),
        .g_o(VGA_G),
        .b_o(VGA_B)
      );
endmodule
