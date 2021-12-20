`timescale 1ns/1ps
module tb; 

reg [31:0] a,b ;
reg [2:0]  ALUControl;

wire[31:0] Result;
wire[3:0]  ALUFlags;

alu32 dut(
 .a(a),
 .b(b),
 .ALUControl(ALUControl),
 .Result(Result),
 .ALUFlags(ALUFlags)
 );
 
initial begin 
a = 0;
b = 0;
ALUControl = 0;
#5
if( (Result !== 0) || (ALUFlags !== 4'd4) ) $display("ADD 0+0 error");

#10
a = 0;
b = 32'hFFFFFFFF;
ALUControl = 0;
#5
if( (Result !== 32'hFFFFFFFF) || (ALUFlags !== 4'd8) ) $display("ADD 0+(-1) error");

#10
a = 32'd1;
b = 32'hFFFFFFFF;
ALUControl = 0;
#5
if( (Result !== 0) || (ALUFlags !== 4'd6) ) $display("ADD 1+(-1) error");

#10 
a = 32'h000000FF;
b = 32'd1 ;
ALUControl = 0;
#5
if( (Result !== 32'h00000100) || (ALUFlags !== 4'd0) ) $display("ADD FF + 1 error");

#10 
a = 0;
b = 0 ;
ALUControl = 3'd1;
#5
if( (Result !== 0 )|| (ALUFlags !== 4'd6) ) $display("SUB 0- 0 error");

#10 
a = 0;
b = 32'hFFFFFFFF ;
ALUControl = 3'd1;
#5
if( (Result !== 32'h00000001) || (ALUFlags !== 4'd0) ) $display("SUB 0-(-1) error");

#10 
a = 32'd1;
b = 32'd1;
ALUControl = 3'd1;
#5
if( (Result !== 0) || (ALUFlags !== 4'd4) ) $display("SUB 1-1 error");

#10 
a = 32'h00000100;
b = 32'd1;
ALUControl = 3'd1;
#5
if( (Result !== 32'h000000FF) || (ALUFlags !== 4'd0) ) $display("SUB 100-1 error");

#10
a = 32'hFFFFFFFF;
b = 32'hFFFFFFFF;
ALUControl = 3'd2;
#5
if( (Result !== 32'hFFFFFFFF) || (ALUFlags !== 4'd8) ) $display("AND F,F error");

#10
a = 32'h87654321;
b = 32'hFFFFFFFF;
ALUControl = 3'd3;
#5
if( (Result !== 32'hFFFFFFFF ) || (ALUFlags !== 8) ) $display("OR 87654321, F error");

#10 
a = 32'hFFFFFFFF;
b = 32'h12345678;
ALUControl = 3'd4;
#5
if( (Result !== 32'hEDCBA987) || (ALUFlags !== 4'd8) ) $display("XOR F,12345678");

#10 
a = 32'hFFFFFFFF;
b = 32'hFFFFFFFF;
ALUControl = 3'd5;
#5
if( (Result !== 32'hFFFFFFFF) || (ALUFlags !== 4'd8) ) $display("Mean F,F error");

#10 
a = 0;
b = 32'h00000001;
ALUControl = 3'd5;
#5
if( (Result !== 0) || (ALUFlags !== 4'd4) ) $display("Mean 0,1 error");

#10 
a = 32'h11111111;
b = 32'h00000001;
ALUControl = 3'd5;
#5
if( (Result !== 32'h08888889) || (ALUFlags !== 4'd0) ) $display("Mean 32'h1,1 error");

#10 
a = 32'hFFFFFFFF;
b = 32'hFFFFFFFF;
ALUControl = 3'd6;
#5
if( (Result !== 32'hFFFFFFFF) || (ALUFlags !== 4'd8) ) $display("Min F,F error");

#10 
a = 0;
b = 32'h00000001;
ALUControl = 3'd6;
#5
if( (Result !== 0) || (ALUFlags !== 4'd4) ) $display("Min 0,1 error");

#10 
a = 32'h11111111;
b = 32'h00000001;
ALUControl = 3'd6;
#5
if( (Result !== 32'h00000001) || (ALUFlags !== 4'd0) ) $display("Min 32'h1,1 error");

#10
a = 32'h00000001;
b = 0; 
ALUControl = 3'd7;
#5
if( (Result !== 32'h00000001) || (ALUFlags !==4'd0) ) $display("ReLU 1,0 error");

#10
a = 32'hFFFFFFFF;
b = 0;
ALUControl = 3'd7;
#5
if( (Result !== 32'h00000000) || (ALUFlags !==4'd4) ) $display("ReLU F,0 error");

#10 
a = 32'h12345678;
b = 0;
ALUControl = 3'd7;
#5
if( (Result !== 32'h12345678) || (ALUFlags !== 4'd0) ) $display("ReLU 12345678,0 error");






end


endmodule