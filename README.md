##Pipeline Adder in Verilog
##

#Overview

This project implements a pipelined adder in Verilog that sums eight 8-bit numbers in a multi-stage pipeline. The design demonstrates:

*Pipelining in digital design

*Stage-by-stage computation with registers

*Synchronization with clock and reset

*Conceptual use of memory and multiplexers to prepare inputs

##

#Features

*Input: Eight 8-bit numbers (A to H)

*Output: 11-bit result (sum of all inputs)

*Stages:

-Store inputs in registers

-Add pairs of inputs (A+B, C+D, E+F, G+H)

-Add first stage sums (I+J, K+L)

-Add second stage sums (M+N) → final result

-Valid signal propagation: Tracks when output is valid through stages
