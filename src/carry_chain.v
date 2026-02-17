module carry_chain #(
    parameter NUM_TAPS = 32   // number of delay taps (must be multiple of 4)
)(
    input  wire        start,      // start pulse (the event to be delayed)
    output wire [NUM_TAPS-1:0] taps // tapped outputs
);

    // Number of CARRY4 instances needed
    localparam NUM_CARRY4 = NUM_TAPS / 4;

    genvar i;
    generate
        // Internal wires to connect COUT to CIN of next stage
        wire [NUM_CARRY4-1:0] cout;

        for (i = 0; i < NUM_CARRY4; i = i + 1) begin : carry_slice
            wire [3:0] o;

            if (i == 0) begin
                // First stage: CYINIT gets the start pulse
                CARRY4 #() carry_inst (
                    .CO({cout[i]}),
                    .O (o),
                    .CI(1'b0),
                    .CYINIT(start),
                    .DI(4'b0),
                    .S (4'b1111)
                );
            end else begin
                // Subsequent stages: CI connects to previous COUT
                CARRY4 #() carry_inst (
                    .CO({cout[i]}),
                    .O (o),
                    .CI(cout[i-1]),
                    .CYINIT(1'b0),
                    .DI(4'b0),
                    .S (4'b1111)
                );
            end

            // Assign the four taps to the appropriate positions in the output vector
            assign taps[i*4 +: 4] = o;
        end
    endgenerate

endmodule