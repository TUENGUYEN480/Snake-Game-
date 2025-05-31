module snake_and_apple(
    input  logic        clk_i,
    input  logic        snake_clk_i,
    input  logic        reset_i,
	 input  logic 			enter_i,
    input  logic [3:0]  direction_i,
    input  logic [9:0]  hpos_i,
    input  logic [9:0]  vpos_i,
    input  logic        playing_i,
    input  logic        game_over_i,
    output logic        snake_colline_o,
	 output logic        apple_colline_o,
    output logic        head_snake_gfx_o,
    output logic        body_snake_gfx_o,
    output logic        apple_gfx_o,
    output logic        border_gfx_o
);
    // Parameters
    localparam SNAKE_SIZE    = 30;
    localparam MAX_LENGTH    = 20;
    localparam SNAKE_MOVE    = 30;
    localparam SNAKE_START_X = 10'd335;
    localparam SNAKE_START_Y = 10'd225;
    localparam APPLE_SIZE    = 30;

    // Snake position/storage
    logic [9:0] head_snake_x, head_snake_y;
    logic [9:0] body_snake_x [MAX_LENGTH-1:0];
    logic [9:0] body_snake_y [MAX_LENGTH-1:0];
    logic [MAX_LENGTH-1:0] body_snake_gfx;

    // Apple signals (provided by apple_generator)
    logic [9:0] apple_x, apple_y;
    logic [8:0] apple_count;

    // Random and validation signals
    logic [4:0] lfsr_x, lfsr_y;
    logic [4:0] rand_x, rand_y;
    logic [9:0] random_apple_x, random_apple_y;
    logic        valid_apple;
    logic        head_collision;
    logic        body_collision;

    // Border and body collision detection
    logic border_collision;
    logic body_collision_detect;
	
	
    // Instantiate LFSR modules
    random lfsr_gen_x (
        .clk      (clk_i),
        .rst      (reset_i),
        .random_out(lfsr_x)
    );
    random lfsr_gen_y (
        .clk      (clk_i),
        .rst      (reset_i),
        .random_out(lfsr_y)
    );

    // Instantiate apple_generator FSM
    apple_generator apple_gen_inst (
        .clk_i           (clk_i),
        .reset_i         (reset_i),
        .apple_colline_o (apple_colline_o),
        .lfsr_x          (lfsr_x),
        .lfsr_y          (lfsr_y),
        .valid_apple     (valid_apple),
        .rand_x          (rand_x),
        .rand_y          (rand_y),
        .apple_x         (apple_x),
        .apple_y         (apple_y),
        .apple_count     (apple_count)
    );

    // Compute potential apple coords for validation
    assign random_apple_x = 35 + (rand_x * APPLE_SIZE);
    assign random_apple_y = 45 + (rand_y * APPLE_SIZE);

    // Check head collision with candidate apple
    assign head_collision = 
        (random_apple_x < head_snake_x + SNAKE_SIZE) &&
        (random_apple_x + APPLE_SIZE > head_snake_x) &&
        (random_apple_y < head_snake_y + SNAKE_SIZE) &&
        (random_apple_y + APPLE_SIZE > head_snake_y);

    // Check body collision with candidate apple
    always_comb begin
        body_collision = 0;
        for (int i = 0; i < MAX_LENGTH; i++) begin
            if (i < apple_count) begin
                body_collision |= 
                    (random_apple_x < body_snake_x[i] + SNAKE_SIZE) &&
                    (random_apple_x + APPLE_SIZE > body_snake_x[i]) &&
                    (random_apple_y < body_snake_y[i] + SNAKE_SIZE) &&
                    (random_apple_y + APPLE_SIZE > body_snake_y[i]);
            end
        end
    end

    // Valid apple if no collision
    assign valid_apple = !head_collision && !body_collision;

    // Snake movement FSM (on snake_clk_i)
    always_ff @(posedge snake_clk_i) begin
        if (reset_i) begin
            head_snake_x <= SNAKE_START_X;
            head_snake_y <= SNAKE_START_Y;
            // Reset body segments
            for (int i = 0; i < MAX_LENGTH; i++) begin
                body_snake_x[i] <= 0;
                body_snake_y[i] <= 0;
            end
        end else begin
            // Reset on game over or not playing
            if (!playing_i || snake_colline_o) begin
                head_snake_x <= SNAKE_START_X;
                head_snake_y <= SNAKE_START_Y;
                for (int i = 0; i < MAX_LENGTH; i++) begin
                    body_snake_x[i] <= 0;
                    body_snake_y[i] <= 0;
                end
            end else begin 
				 if (playing_i | reset_i) begin
                // Move body segments
                body_snake_x[0] <= head_snake_x;
                body_snake_y[0] <= head_snake_y;
                for (int i = 0; (i < apple_count) && (i+1 < MAX_LENGTH); i++) begin
                    body_snake_x[i+1] <= body_snake_x[i];
                    body_snake_y[i+1] <= body_snake_y[i];
                end
                // Move head
                case (direction_i)
                    4'b1000: head_snake_x <= head_snake_x + SNAKE_MOVE;
                    4'b0100: head_snake_x <= head_snake_x - SNAKE_MOVE;
                    4'b0001: head_snake_y <= head_snake_y - SNAKE_MOVE;
                    4'b0010: head_snake_y <= head_snake_y + SNAKE_MOVE;
                    default: begin
                        head_snake_x <= head_snake_x;
                        head_snake_y <= head_snake_y;
                    end
                endcase
            end
        end
		end 
    end
assign apple_colline_o = (head_snake_x < apple_x + APPLE_SIZE) &&
                             (head_snake_x + SNAKE_SIZE > apple_x) &&
                             (head_snake_y < apple_y + APPLE_SIZE) &&
                             (head_snake_y + SNAKE_SIZE > apple_y);
    // Generate snake_colline_o: border or self collision
    always_comb begin
        // Border collision
        border_collision = 
            (head_snake_x < 35) || (head_snake_x + SNAKE_SIZE > 605) ||
            (head_snake_y < 45) || (head_snake_y + SNAKE_SIZE > 435);
        // Body collision
        body_collision_detect = 0;
        for (int i = 0; i < MAX_LENGTH; i++) begin
            if (i < apple_count) begin
                body_collision_detect |= 
                    (head_snake_x < body_snake_x[i] + SNAKE_SIZE) &&
                    (head_snake_x + SNAKE_SIZE > body_snake_x[i]) &&
                    (head_snake_y < body_snake_y[i] + SNAKE_SIZE) &&
                    (head_snake_y + SNAKE_SIZE > body_snake_y[i]);
            end
        end
        snake_colline_o = border_collision || body_collision_detect;
    end

    // Body GFX rendering (on clk_i)
    always_ff @(posedge clk_i) begin
        for (int j = 0; j < MAX_LENGTH; j++) begin
            body_snake_gfx[j] <= (j < apple_count) &&
                (hpos_i >= body_snake_x[j]) && (hpos_i <= body_snake_x[j] + SNAKE_SIZE) &&
                (vpos_i >= body_snake_y[j]) && (vpos_i <= body_snake_y[j] + SNAKE_SIZE);
        end
    end
    assign body_snake_gfx_o = |body_snake_gfx;

   
    always_ff @(posedge clk_i) begin
        head_snake_gfx_o <= 
            (hpos_i >= head_snake_x) && (hpos_i <= head_snake_x + SNAKE_SIZE) &&
            (vpos_i >= head_snake_y) && (vpos_i <= head_snake_y + SNAKE_SIZE);
        border_gfx_o <= 
            ((hpos_i >= 10'd0) && (hpos_i <= 10'd35)) ||
            ((hpos_i >= 10'd605) && (hpos_i <= 10'd640)) ||
            ((vpos_i >= 10'd0) && (vpos_i <= 10'd45)) ||
            ((vpos_i >= 10'd435) && (vpos_i <= 10'd480));
    end

    always_ff @(posedge clk_i) begin
        apple_gfx_o <= 
            (hpos_i >= apple_x + 2) && (hpos_i < apple_x + APPLE_SIZE - 2) &&
            (vpos_i >= apple_y + 2) && (vpos_i < apple_y + APPLE_SIZE - 2);
    end

endmodule
