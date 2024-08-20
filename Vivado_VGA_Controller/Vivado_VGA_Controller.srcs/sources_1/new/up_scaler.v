module up_scaler (
    input clk, reset_p,
    input addr_x,
    input addr_y,

    output addr_x_scaler,
    output addr_y_scaler);

    wire w_25mhz;
    clock_div_4 mh_25(
                .clk(clk), .reset_p(reset_p),
                .clk_div_100(w_25mhz),
                .cp_div_100());

    integer pixel_counter;
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            pixel_counter = 0;
        end
        else if(w_25mhz) begin
            pixel_counter = pixel_counter + 1;
            if (pixel_counter >= 76800) pixel_counter = 0;
        end
    end

    assign addr_x_scaler = addr_x>>1;
    assign addr_y_scaler = addr_y>>1;
endmodule