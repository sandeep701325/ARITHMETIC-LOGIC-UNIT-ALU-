
module alu_tb;
    // Testbench Registers (Inputs)
    reg [7:0] input_a_tb;       // First operand
    reg [7:0] input_b_tb;       // Second operand
    reg [3:0] operation_select_tb;  // Operation selector
    
    // Testbench Wires (Outputs)
    wire [7:0] result_output_tb; // ALU result
    wire carry_flag_tb;          // Carry flag
    
    // Instantiate the modified ALU
    arithmetic_logic_unit uut (
        .input_a(input_a_tb),
        .input_b(input_b_tb),
        .operation_select(operation_select_tb),
        .result_output(result_output_tb),
        .carry_flag(carry_flag_tb)
    );

    // Test procedure
    initial begin
        // Initialize Inputs
        input_a_tb = 8'b0;
        input_b_tb = 8'b0;
        operation_select_tb = 4'b0;
        
        // Monitor changes
        $monitor("Time=%0t A=%b B=%b Op=%b Result=%b Carry=%b", 
                $time, input_a_tb, input_b_tb, operation_select_tb, 
                result_output_tb, carry_flag_tb);
        
        // Test Case 1: Addition
        #10;
        input_a_tb = 8'h0F;
        input_b_tb = 8'hF0;
        operation_select_tb = 4'b0000;
        
        // Test Case 2: Subtraction
        #10;
        operation_select_tb = 4'b0001;
        
        // Test Case 3: Multiplication
        #10;
        input_a_tb = 8'h03;
        input_b_tb = 8'h04;
        operation_select_tb = 4'b0010;
        
        // Test Case 4: Logical Shift Left
        #10;
        input_a_tb = 8'b1010_1010;
        operation_select_tb = 4'b0100;
        
        // Test Case 5: Rotation Right
        #10;
        operation_select_tb = 4'b0111;
        
        // Test Case 6: Bitwise AND
        #10;
        input_a_tb = 8'hFF;
        input_b_tb = 8'h0F;
        operation_select_tb = 4'b1000;
        
        // Test Case 7: XNOR Operation
        #10;
        operation_select_tb = 4'b1101;
        
        // Test Case 8: Equality Check
        #10;
        input_a_tb = 8'hAA;
        input_b_tb = 8'hAA;
        operation_select_tb = 4'b1111;
        
        // End simulation
       
    end
    
    
   
endmodule
