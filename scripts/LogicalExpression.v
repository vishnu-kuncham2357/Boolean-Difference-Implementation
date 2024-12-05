module LogicalExpression(
    input Cin, A, B,
    output result
);
    assign result = (A ^ B) & ((((A & B) | (1 & Cin))) ^ (((A & B) | (0 & Cin))));
endmodule
module Testbench();
    reg Cin, A, B;
    wire result;

    // Instantiate the module
    LogicalExpression dut (
        .Cin(Cin), .A(A), .B(B),
        .result(result)
    );

    // Test all possible binary combinations
    integer i;
    reg found_pattern;

    initial begin
        found_pattern = 0;
        for (i = 0; i < 8; i = i + 1) begin
            { Cin, A, B } = i;
            #1; // Small delay for each evaluation
            if (result) begin
                found_pattern = 1;
                $display("%b,", { Cin, A, B });
            end
        end
        if (!found_pattern) begin
        end
    end
endmodule
