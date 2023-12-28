#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 <verilog_file> <testbench_file>"
    echo "       verilog_file: Verilog design file (e.g., module.v)"
    echo "       testbench_file: Verilog testbench file (e.g., module_tb.v)"
    exit 1
}

# Check if two arguments are given
if [ "$#" -ne 2 ]; then
    echo "Error: Incorrect number of arguments."
    usage
fi

# Check if the provided files exist
if [ ! -f "$1" ] || [ ! -f "$2" ]; then
    echo "Error: One or more files do not exist."
    usage
fi

# Compile Verilog files
iverilog -o simulation.vvp "$1" "$2"

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed."
    exit 2
fi

# Run simulation
vvp simulation.vvp

# Check if simulation was successful
if [ $? -eq 0 ]; then
    # Open waveform in GTKWave (assuming VCD file is named 'waveform.vcd')
    gtkwave waveform.vcd
else
    echo "Error: Simulation failed."
    exit 3
fi

