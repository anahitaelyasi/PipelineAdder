`timescale 1ns/1ps

module tb_pipelineAdder;

    reg[7:0] A,B,C,D,E,F,G,H;
    reg clk, rst_n, valid_input;
    wire[10:0] result;
    wire valid_output;

    pipelineAdder uut(
        .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .H(H),
        .clk(clk), .rst_n(rst_n), .valid_input(valid_input),
        .result(result),
        .valid_output(valid_output)
    );
    
    // Clock generation: 10 time units period
    initial clk = 0;
    always #5 clk = ~clk;


    // Test stimulus
    initial begin

        $dumpfile("pipewave.vcd");
        $dumpvars(0, tb_pipelineAdder);
        
        // Initialize signals
        rst_n = 0; valid_input = 0;
        A = 0; B = 0; C = 0; D = 0;
        E = 0; F = 0; G = 0; H = 0;

        // Apply reset
        #10;
        rst_n = 1; valid_input = 1;

        // Test vector 1
        A = 8'd1; B = 8'd2; C = 8'd3; D = 8'd4;
        E = 8'd5; F = 8'd6; G = 8'd7; H = 8'd8;

        #20;

        // Test vector 2
        A = 8'd10; B = 8'd20; C = 8'd30; D = 8'd40;
        E = 8'd50; F = 8'd60; G = 8'd70; H = 8'd80;

        #50;

        // Finish simulation
        $finish;
    end

    // Waveform dump for GTKWave or similar
    initial begin
        $dumpfile("pipelineAdder.vcd");
        $dumpvars(0, tb_pipelineAdder);
    end

endmodule