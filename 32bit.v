module alu #( parameter N = 32
) (
 a,
 b,
 ALUControl,
 Result,
 ALUFlags
);


input [N-1:0] a;
input [N-1:0] b;
input [2:0] ALUControl;
output reg [N-1:0] Result;
output [3:0] ALUFlags;
//3 Neg?, 2 0?, 1 Cout?, 0 OF?

wire neg_tmp;
wire zero_tmp;
wire cout_tmp;
wire oflow_tmp;
wire res_tmp;

reg flag;
reg cout;

assign zero_tmp = (Result == 0) ? 1 : 0;
assign oflow_tmp = ( (ALUControl==4'b0010) & a[31] & b[31] & ~Result[31]) ? 1 
                      :( (ALUControl==4'b0010) & ~a[31] & ~b[31] & Result[31]) ? 1 
                      :( (ALUControl==4'b0001) & a[31] & ~b[31] & ~(Result[31])) ? 1 
                      :( (ALUControl==4'b0001) & ~a[31] & b[31] & Result[31]) ? 1 
                      : 0;
assign neg_tmp = (Result[31] == 1) ? 1 : 0;
assign cout_tmp = (cout) ? 1 : 0;

assign ALUFlags[0] = oflow_tmp ;
assign ALUFlags[1] = cout_tmp ;
assign ALUFlags[2] = zero_tmp ;
assign ALUFlags[3] = neg_tmp ;

always@(a, b, ALUControl, ALUFlags)begin
    
    case(ALUControl)
        3'b000:begin //add

            Result <= a + b;
            if(a[31] == 0 && b[31] == 0 && Result[31] == 1) cout <= 1;
            else if(a[31] == 1 && b[31] == 1 && Result[31] == 0) cout <= 1;
				else if(a != 0 && b != 0 && Result == 0) cout <= 1;

				else cout <= 0;
        end
        3'b001:begin //sub
 
            Result <= a - b;
            if(b == 0) cout <= 1;
				else cout <= 0;
        end
        3'b010:begin //and

            Result <= a & b;
            cout <= 0;
        end
        3'b011:begin //or

            Result <= a | b;
            cout <= 0;

        end
        3'b100:begin //xor

            Result <= a ^ b;
            cout <= 0;

        end
        3'b101:begin //mean

            Result <= (a + b) / 2;
				if(a[31] && b[31]) Result[31] <= 1;
            cout <= 0;

        end
        3'b110:begin //min

            Result <= (a < b) ? a : b;
            cout <= 0;

        end
        3'b111:begin //Re

            Result <= (a[31] == 0) ? a : 0;
            cout <= 0;
        end
          default: ;

endcase

end

endmodule