`timescale 1ps / 1ps

module tb_tdc();

    parameter NUM_TAPS = 32;
    reg start, stop;
    wire [NUM_TAPS-1:0] taps_raw;
    wire [$clog2(NUM_TAPS)-1:0] time_out;

    // Instantiating the TDC
    tdc_top #(.NUM_TAPS(NUM_TAPS)) dut (
        .start(start),
        .stop(stop),
        .taps_raw(taps_raw),
        .time_out(time_out)
    );

    initial begin
        $dumpfile("tb_tdc.vcd");
        $dumpvars(0, tb_tdc);

        start = 0;
        stop  = 0;
       
        #100;
        start = 1;
        #1;
        start = 0;

        #150;
        stop = 1;
        #1;
        stop = 0;

        #500;    
        $display("Time out = %0d taps", time_out);
        $display("Taps raw = %b", taps_raw);
        $finish;
    end

endmodule