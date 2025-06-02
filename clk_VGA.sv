module clk_VGA(
    input  logic clk_i,    
  
    output logic clk_vga     
);

    logic clk_div;
    always_ff @(posedge clk_i) begin
		clk_div <= ~clk_div;  // Toggle every clock edge
    end
    assign clk_vga = clk_div;

endmodule
