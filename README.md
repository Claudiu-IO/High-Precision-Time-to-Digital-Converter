High-Precision FPGA Time-to-Digital Converter

![alt text](<Screenshot from 2026-02-17 20-38-04.png>)

Key Specs:

    Architecture: Tapped Delay Line (CARRY4 Primitives)

    Platform: Xilinx Artix-7: xc7a35ticsg324-1L

    Resolution: ~287 ps (Verified via Post-Implementation Timing Simulation)

    Implementation Details:

    I used Xilinx CARRY4 primitives to access the FPGA's dedicated fast carry logic. This allowed me to bypass the general routing matrix, which is too slow and unpredictable for high-precision timing and instead use hardwired silicon paths to achieve uniform sub-nanosecond delay steps.

    


Performance Characterization:

    The TDC resolution was characterized using Post-Implementation Timing Simulation in Vivado (Artix-7 target).

        Methodology: A pulse was injected into the delay line and the propagation time across the full 32-tap chain was measured.

        Measurement Data:

            ΔT_total​ (Time for wave to traverse chain): 9.179 ns

            N_taps​ (Total delay stages): 32 taps

        Calculated Resolution (LSB):
        Resolution = N_taps/​ΔT_total ​​= 9179ps/32 ​≈ 286.8 ps

        Linearity: The waveform confirms a monotonic propagation of the signal through the carry chain, validating the use of dedicated routing resources.