module game_stage_machine (
	input logic clk_i,
	input logic reset_i,
	input logic snake_colline_i,
	input logic enter_i,
	output logic playing_o,
	output logic game_over_o
);
	logic state;
	localparam PLAYING =1'b1;
	localparam GAMEOVER = 1'b0;

	always_ff @( posedge clk_i) begin 
		if (reset_i) begin  // SUA RESET
			state <= GAMEOVER;
			playing_o <= 1'b0;
			game_over_o <= 1'b1;
		end else begin 
			case (state) 
				PLAYING :begin
								playing_o <= 1'b1;
								game_over_o <= 1'b0;
								if(snake_colline_i) state <= GAMEOVER;
							end 
				GAMEOVER : begin
								playing_o <= 1'b0;
								game_over_o <= 1'b1;
								if ( enter_i) state <= PLAYING;
							  end
				default : state <= GAMEOVER;
			endcase 
		end 
	end 		
	
endmodule 
	 