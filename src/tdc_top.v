module tdc_top #(
    parameter NUM_TAPS = 32
)(
    input  wire start,     
    input  wire stop,       
    output wire [NUM_TAPS-1:0] taps_raw, 
    output wire [$clog2(NUM_TAPS)-1:0] time_out 
);

    wire [NUM_TAPS-1:0] taps;

    // Instantiation of the carry chain
    carry_chain #(.NUM_TAPS(NUM_TAPS)) delay_line (
        .start(start),
        .taps(taps)
    );

    reg [NUM_TAPS-1:0] taps_q;
    always @(posedge stop) begin
        taps_q <= taps;
    end

    assign taps_raw = taps_q;

    thermometer_encoder #(.NUM_TAPS(NUM_TAPS)) encoder (
        .thermo(taps_q),
        .binary(time_out)
    );

endmodule