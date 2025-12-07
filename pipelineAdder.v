module pipelineAdder(
    input[7:0] A,B,C,D,E,F,G,H,
    input clk, rst_n, valid_input,
    output reg [10:0] result,
    output reg valid_output
);

    // Declare storage
    reg[7:0] store_A, store_B, store_C, store_D, store_E, store_F, store_G, store_H;
    reg valid_in;
    // stage 2 sum registers
    reg[8:0] I, J, K, L;
    // stage 3 sum registers
    reg[9:0] M, N;
    // result register
    reg[10:0] res;
    reg valid_stage2;
    reg valid_stage3;
    reg valid_out;

    //Stage 1
    always @ (posedge clk) 
    begin

        if (rst_n == 0) begin
            store_A <= 8'b0; store_B <= 8'b0; store_C <= 8'b0; store_D <= 8'b0;
            store_E <= 8'b0; store_F <= 8'b0; store_G <= 8'b0; store_H <= 8'b0; 
            valid_in <= 0;
        end
        else begin
            // Store them for later use or to avoid changes
            store_A <= A; store_B <= B; store_C <= C; store_D <= D;
            store_E <= E; store_F <= F; store_G <= G; store_H <= H;
            valid_in <= valid_input; 
        end
    end


    //Stage 2
    always @ (posedge clk)
    begin
        if (rst_n == 0) begin
            I <= 9'b0; J <= 9'b0; K <= 9'b0; L <= 9'b0;
            valid_stage2 <= 0;
        end
        else begin
            I <= store_A + store_B;
            J <= store_C + store_D;
            K <= store_E + store_F;
            L <= store_G + store_H;

            valid_stage2 <= valid_in;
        end
    end

    // Stage 3
    always @ (posedge clk)
    begin

        if (rst_n == 0) begin
            M <= 10'b0; N <= 10'b0;
            valid_stage3 <= 0;
        end
        else begin
            M <= I + J;
            N <= K + L; 
            valid_stage3 <= valid_stage2;
        end
    end

    // Stage 4 
    always @ (posedge clk) begin
        if (rst_n == 0) begin
            res <= 11'b0;
            valid_out <= 0;
            result <= 11'b0;
            valid_output <= 0;
        end 
        else begin
            res <= M + N; 
            valid_out <= valid_stage3;

            result = res;
            valid_output = valid_out;
        end
    end
        
endmodule