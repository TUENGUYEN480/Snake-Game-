

module snake_top (
    input logic clk_i,  //50MHz
    input logic KEY_0, KEY_1, KEY_2, KEY_3,
    input logic reset_i,
	 input logic enter,
	 output logic vga_clk,
    output logic hsync_no,
    output logic vsync_no,
	 output logic display_enable,
    output logic [9:0] r_o,
    output logic [9:0] g_o,
    output logic [9:0] b_o
);

 
 // logic	vga_clk ;
  logic update_clk;  //1Hz
  
  logic snake_collide, playing, game_over;
  logic head_snake_gfx, body_snake_gfx, border_gfx, apple_gfx;
  logic [3:0] direction;
  logic [9:0] hpos, vpos;

// assign vga_clk_1 = vga_clk;

    
  key_board keyboard1 (
      .clk_i(clk_i),
		.reset(reset_i),
		.KEY_0(KEY_0),
      .KEY_1(KEY_1),
		.KEY_2(KEY_2),
		.KEY_3(KEY_3),
      .direction_o(direction)
  );
  clk_VGA clk_VGA1 (
      .clk_i(clk_i),
      .clk_vga(vga_clk)
  );
  speed_control speed_control1 (
      .clk_i(clk_i),
      .update_clk_o(update_clk)
  );
VGA_controller VGA_controller1 (
    .clk_i(vga_clk),
    .hsync(hsync_no),
    .vsync(vsync_no),
    .display_on_o(display_enable),
    .hpos(hpos),
    .vpos(vpos),
	 .reset(reset_i)
  );

  game_stage_machine game_stage_machine1 (
    .clk_i(vga_clk),
    .enter_i(enter),
    .reset_i(reset_i),
    .snake_colline_i(snake_collide),
    .playing_o(playing),
    .game_over_o(game_over)
  );
  snake_and_apple snake_and_apple (
    .clk_i(vga_clk),
    .reset_i(reset_i),
    .playing_i(playing),
    .snake_clk_i(update_clk),    
    .direction_i(direction),
    .hpos_i(hpos),
    .vpos_i(vpos),
    .head_snake_gfx_o(head_snake_gfx),
    .body_snake_gfx_o(body_snake_gfx),
    .apple_gfx_o(apple_gfx),
    .border_gfx_o(border_gfx),
    .snake_colline_o(snake_collide),
	 .game_over_i(game_over)
  );
     


  drawer drawer1 (
    .display_enable_i(display_enable),
    .head_snake_gfx_i(head_snake_gfx),
    .body_snake_gfx_i(body_snake_gfx),
    .apple_gfx_i(apple_gfx),
    .border_gfx_i(border_gfx),
    .r_o(r_o),
    .g_o(g_o),
    .b_o(b_o)
  );

endmodule


