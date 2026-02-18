⏱️ FPGA-TDC: High-Precision Time-to-Digital Converter

    Sub-nanosecond timing measurement using dedicated FPGA Carry Chains.

This project implements a high-resolution Time-to-Digital Converter (TDC) in Verilog, capable of measuring time intervals with precision far exceeding the standard system clock. By manually instantiating Xilinx CARRY4 primitives, it bypasses standard routing delays to utilize the FPGA's fastest dedicated silicon paths.

Current Resolution: ~287 ps (Verified via Post-Implementation Timing Simulation on Artix-7 xc7a35ticsg324-1L model).

![alt text](<Screenshot from 2026-02-17 20-38-04.png>)

Yellow Cursor: Marks the completion of the propagation event (T≈211.986 ns).

Waveform: The taps signal shows the "Inverted Thermometer" code draining from all ones (f) to all zeros (0) as the pulse propagates through the delay line.



    
Performance Characterization:

    The TDC resolution was characterized using Post-Implementation Timing Simulation in Vivado (Artix-7 target).

        Methodology: A pulse was injected into the delay line and the propagation time across the full 32-tap chain was measured.

        Measurement Data:

            ΔT_total​ (Time for wave to traverse chain): 9.179 ns

            N_taps​ (Total delay stages): 32 taps

        Calculated Resolution (LSB):
        Resolution = N_taps/​ΔT_total ​​= 9179ps/32 ​≈ 286.8 ps

        Linearity: The waveform confirms a monotonic propagation of the signal through the carry chain, validating the use of dedicated routing resources.

Project Structure

    carry_chain.v: The core delay line using generate loops and CARRY4 primitives.

    tdc_top.v: Top-level module handling signal capture and synchronization.

    tb_tdc.v: Testbench configured with GSR wait times and wide input pulses for accurate timing simulation.

    tdc_constraints.xdc: Placement constraints to lock the logic to specific slices for maximum linearity.