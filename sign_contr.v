`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 21:34:55
// Design Name: 
// Module Name: sign_contr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define TRUE 1'b1 
`define FALSE 1'b0
`define RED 2'd0
`define YELLOW 2'd1 
`define GREEN 2'd2


`define S0 3'd0
`define S1 3'd1 
`define S2 3'd2 
`define S3 3'd3 
`define S4 3'd4 
`define Y2RDELAY 3
`define R2GDELAY 2 

module sign_contr (hwy, cntry, X, clock, clear);
output [1:0] hwy, cntry; 
reg [1:0] hwy, cntry;
input X;
input clock, clear;
reg [2:0] state;
reg [2:0] next_state;

initial 
begin
state = `S0; 
next_state= `S0;
hwy = `GREEN;
cntry = `RED;
end

always @(posedge clock) 
state = next_state;

always @(state)
begin
case (state) 
`S0: begin
hwy = `GREEN; cntry = `RED;
end
`S1: begin
hwy = `YELLOW; cntry = `RED;
end 
`S2: begin
hwy = `RED; cntry = `RED;
end
`S3: begin
hwy = `RED;
cntry = `GREEN;
end
`S4: begin
hwy = `RED; 
cntry = `YELLOW;
end
endcase

end

//State machine using case statements @(state or clear or X)
always@(state or clear or X)
begin
if(clear)
next_state=`S0; 
else
case (state) 
`S0: if (X)
next_state=`S1;
else
next_state=`S0; 
`S1: begin //delay some positive edges of clock next_state= 'S2;
repeat (`Y2RDELAY) @ (posedge clock);
next_state=`S2; 
end
`S2: begin //delay some positive edges repeat (R2GDELAY) (posedge clock)
next_state=`S3;
end 
`S3: if (X)
next_state =`S3;
else
next_state= `S4; 
`S4: begin //delay some positive edges of clock repeat (Y2RDELAY) (posedge clock);
next_state= `S0;
end
default: next_state = `S0;
endcase
end
endmodule
