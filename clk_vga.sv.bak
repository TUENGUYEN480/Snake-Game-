module clk_VGA(
input logic clk_i,
output logic clk_vga
);
 logic a=0  ;
 always_ff @(posedge clk_i) begin 
 a <= ~a;
 clk_vga <= a;
 end 
 endmodule 
 
 