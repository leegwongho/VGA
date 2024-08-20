`timescale 1ns / 1ps


// Tracks current pixel coordinates on monitor
module pixel_coordinate_tracker (
    input clk, reset_p,
    input Hsync, Vsync, pixel_clock_pusle, in_display_on,
    output reg [9:0] pixel_coord_x, pixel_coord_y
);

    wire Hsync_nedeg, Vsync_nedeg;
    edge_detector_n Hsync_edge_module (.clk(clk), .reset_p(reset_p), .cp(Hsync), .n_edge(Hsync_nedeg));
    edge_detector_n Vsync_edge_module (.clk(clk), .reset_p(reset_p), .cp(Vsync), .n_edge(Vsync_nedge));

    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            pixel_coord_x = 10'h3ff;
            pixel_coord_y = 10'h3ff;
        end
        else begin
            if (Vsync_nedeg) begin
                pixel_coord_x = 10'h3ff;
                pixel_coord_y = 10'h3ff;
            end
            else if (Hsync_nedeg) begin
                pixel_coord_x = 10'h3ff;
                pixel_coord_y = pixel_coord_y + 1;
            end
            else if (pixel_clock_pusle && in_display_on) begin
                pixel_coord_x = pixel_coord_x + 1;
            end
        end
    end

endmodule