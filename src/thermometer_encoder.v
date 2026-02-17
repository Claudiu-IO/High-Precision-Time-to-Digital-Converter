module thermometer_encoder #(
    parameter NUM_TAPS = 32
)(
    input  wire [NUM_TAPS-1:0] thermo,
    output reg  [$clog2(NUM_TAPS)-1:0] binary
);

    integer i;
    always @(*) begin
        binary = 0;
        for (i = 0; i < NUM_TAPS; i = i + 1) begin
            if (thermo[i] == 1'b1)
                binary = i + 1;   // number of ones = position of last one + 1
        end
    end

endmodule