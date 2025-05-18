
module arithmetic_logic_unit (
           input [7:0] input_a, input_b,  // 8-bit input operands
           input [3:0] operation_select,  // 4-bit operation selector
           output [7:0] result_output,    // 8-bit computation result
           output carry_flag              // Carry-out indicator
    );
    // Internal storage for computed result
    reg [7:0] computed_result;
    
    // Temporary 9-bit wire for handling carry detection
    wire [8:0] sum_with_carry;
    
    // Connect computed result to output port
    assign result_output = computed_result;
    
    // Calculate sum with extended precision for carry detection
    assign sum_with_carry = {1'b0, input_a} + {1'b0, input_b};
    
    assign carry_flag = sum_with_carry[4];
    
    // Combinational logic block for operation selection
    always @(*)
    begin
        case(operation_select)
            // Arithmetic Operations
            4'b0000: computed_result = input_a + input_b;      // Addition
            4'b0001: computed_result = input_a - input_b;      // Subtraction
            4'b0010: computed_result = input_a * input_b;      // Multiplication
            4'b0011: computed_result = input_a / input_b;      // Division
            
            // Shift Operations
            4'b0100: computed_result = input_a << 1;           // Logical left shift
            4'b0101: computed_result = input_a >> 1;           // Logical right shift
            
            // Rotation Operations
            4'b0110: computed_result = {input_a[6:0], input_a[7]};  // Left rotation
            4'b0111: computed_result = {input_a[0], input_a[7:1]};  // Right rotation
            
            // Bitwise Logical Operations
            4'b1000: computed_result = input_a & input_b;      // AND
            4'b1001: computed_result = input_a | input_b;      // OR
            4'b1010: computed_result = input_a ^ input_b;      // XOR
            4'b1011: computed_result = ~(input_a | input_b);   // NOR
            4'b1100: computed_result = ~(input_a & input_b);   // NAND
            4'b1101: computed_result = ~(input_a ^ input_b);   // XNOR
            
            // Comparison Operations
            4'b1110: computed_result = (input_a > input_b) ? 8'd1 : 8'd0;  // Greater than
            4'b1111: computed_result = (input_a == input_b) ? 8'd1 : 8'd0; // Equal to
            
            // Default to addition operation
            default: computed_result = input_a + input_b;
        endcase
    end
endmodule
