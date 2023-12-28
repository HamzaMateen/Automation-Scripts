#!/bin/bash

# Compile Verilog files
iverilog -o dff_tb.vvp dff.v dff_tb.v

# Run simulation
vvp dff_tb.vvp

# Check if simulation was successful
if [ $? -eq 0 ]; then
    # Open waveform in GTKWave
    gtkwave dff_wave.vcd
else
    echo "Simulation failed."
fi

