
module speed_control (
    input logic clk_i,
    output update_clk_o
);
  logic [24:0] count;

  always @(posedge clk_i) begin
    count <= count + 1;
    if (count == 12500000) begin
      update_clk_o <= ~update_clk_o;
      count  <= 0;
    end
  end
endmodule

//12500000
//25000000