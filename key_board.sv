module key_board (
    input logic clk_i,
    input logic reset ,                    // Thêm tín hiệu reset
    input logic KEY_0, KEY_1, KEY_2, KEY_3,
    output logic [3:0] direction_o
);

    // Tín hiệu đã qua debounce
    logic key0_db, key1_db, key2_db, key3_db;

    // Instance debounce cho từng phím
    debounce db0 (.button_in(KEY_0), .clk_i(clk_i), .reset(reset), .button_out(key0_db));
    debounce db1 (.button_in(KEY_1), .clk_i(clk_i), .reset(reset), .button_out(key1_db));
    debounce db2 (.button_in(KEY_2), .clk_i(clk_i), .reset(reset), .button_out(key2_db));
    debounce db3 (.button_in(KEY_3), .clk_i(clk_i), .reset(reset), .button_out(key3_db));

    // Invert logic vì button active-low
    logic up, down, left, right;
    assign up    = ~key0_db;
    assign down  = ~key1_db;
    assign left  = ~key2_db;
    assign right = ~key3_db;
	 
	 logic [3:0]current_direction;
	

    // Cập nhật hướng
    always_ff @(posedge clk_i) begin
		if (reset) begin 
		direction_o =4'b0000;
		current_direction =4'b0000;
		end else begin 
        if (up && !(down || left || right)&& (current_direction != 4'b0010))    begin 
			direction_o <= 4'b0001; // Up
			current_direction <= 4'b0001;
		 end else if (down && !(up || left || right)&& (current_direction != 4'b0001)) begin 
			direction_o <= 4'b0010; // Down
			current_direction <= 4'b0010;
       end else if (left && !(up || down || right)&& (current_direction !=4'b1000)) begin
			direction_o <= 4'b0100; // Left
			current_direction <= 4'b0100;
       end else if (right && !(up || down || left)&& (current_direction !=4'b0100)) begin
			direction_o <= 4'b1000; // Right
			current_direction <= 4'b1000;
       end else begin 
			direction_o <= direction_o;
			current_direction <=current_direction; // Giữ nguyên nếu nhiều nút nhấn hoặc không nhấn
		 end
end 
end 
endmodule