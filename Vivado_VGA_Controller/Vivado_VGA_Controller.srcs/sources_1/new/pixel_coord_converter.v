module pixel_coord_converter
    (input clk, reset_p,
    input addr_x, addr_y,
    output addr_x_scaler, addr_y_scaler);

    parameter scale_factor = 2;
    localparam bit_shift = $clog2(scale_factor);

    assign addr_x_scaler = addr_x>>bit_shift;
    assign addr_y_scaler = addr_y>>bit_shift;
endmodule