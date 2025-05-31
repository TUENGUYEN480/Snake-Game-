module wrapper (
  
     input logic CLOCK_50,
    input logic [2:0] SW,
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

    logic vga_clk, update_clk, display_on;
    logic [3:0] direction;
    logic [9:0] hpos, vpos;
    logic head_snake_gfx, body_snake_gfx, apple_gfx, border_gfx;
    logic snake_colline, playing,enter, game_over,apple_colline_o;



    // Module key_board
    key_board key_inst (
        .clk_i(CLOCK_50),
        .reset(SW[0]),
        .KEY_0(KEY[0]),
        .KEY_1(KEY[1]),
        .KEY_2(KEY[2]),
        .KEY_3(KEY[3]),
        .direction_o(direction)
    );
    //module clk_VGA
	 clk_VGA clk_VGA1(
	     .clk_i(CLOCK_50),
		  .clk_vga(vga_clk)
	 );
    // Module speed_control
    speed_control speed_inst (
        .clk_i(CLOCK_50),
        
        .update_clk_o(update_clk)
    );

    // Module VGA_controller
    VGA_controller vga_inst (
        .clk_i(vga_clk),
        .reset(SW[0]),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .display_on_o(display_on),
        .hpos(hpos),
        .vpos(vpos)
    );

    // Module game_state_machine
    game_stage_machine state_inst (
        .clk_i(vga_clk),
        .reset_i(SW[0]),
        .snake_colline_i(snake_colline),
        .enter_i(SW[1]),
        .playing_o(playing),
        .game_over_o(game_over)
    );

    // Module snake_and_apple
    snake_and_apple snake_inst (
        .clk_i(vga_clk),
        .snake_clk_i(update_clk),
        .reset_i(SW[0]),
        .direction_i(direction),
		  .enter_i(SW[1]),
        .hpos_i(hpos),
        .vpos_i(vpos),
        .playing_i(playing),
        .game_over_i(game_over),
        .snake_colline_o(snake_colline),
		  .apple_colline_o (apple_colline_o),
        .head_snake_gfx_o(head_snake_gfx),
        .body_snake_gfx_o(body_snake_gfx),
        .apple_gfx_o(apple_gfx),
        .border_gfx_o(border_gfx)
    );

    // Module drawer
    drawer draw_inst (
        .display_enable_i(display_on),
        .head_snake_gfx_i(head_snake_gfx),
        .body_snake_gfx_i(body_snake_gfx),
        .apple_gfx_i(apple_gfx),
        .border_gfx_i(border_gfx),
        .r_o(VGA_R),
        .g_o(VGA_G),
        .b_o(VGA_B)
    );

	 led_7_doan led_7_doan_inst (
		.clk_i(CLOCK_50),      
      .reset_i(SW[0]),   
   	.apple_colline(apple_colline_o), 
      .hang_chuc(HEX1), 
      .hang_don_vi(HEX0),
	);
 
    assign VGA_BLANK = display_on;
    assign VGA_CLK   = vga_clk;
	
endmodule
