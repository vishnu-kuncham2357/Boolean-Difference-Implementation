
module true_circuit(Cin, A, B, true_output);
    input Cin, A, B;
    output true_output;
    assign true_output = ((A & B) | ((A ^ B) & Cin));
endmodule

module faulty_circuit(Cin, A, B, fault_output);
    input Cin, A, B;
    output fault_output;
    wire G1;
    assign G1 = 0;
    assign fault_output = ((A & B) | (G1 & Cin));
endmodule

module test_bench();
    reg [2:0] test_cases [0:1];
    reg [2:0] inputs;
    reg Cin, A, B;
    wire true_output, fault_output;

    true_circuit true_instance (.Cin(Cin), .A(A), .B(B), .true_output(true_output));
    faulty_circuit faulty_instance (.Cin(Cin), .A(A), .B(B), .fault_output(fault_output));

    integer i;
    initial begin


        // Initialize test cases
        test_cases[0] = 3'b101;
        test_cases[1] = 3'b110;

        // Apply test cases
        for (i = 0; i <= 1; i = i + 1) begin
            inputs = test_cases[i];
            Cin = inputs[2];
            A = inputs[1];
            B = inputs[0];
            #1; // Wait for outputs to stabilize
            $display("Test case = %b, True Output = %b, Faulty Output = %b", inputs, true_output, fault_output);
        end
        $finish;
    end
endmodule
