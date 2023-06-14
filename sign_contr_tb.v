`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 21:53:23
// Design Name: 
// Module Name: sign_contr_tb
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

module sign_contr_tb;
wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD;
reg CLOCK, CLEAR;

sign_contr utt(MAIN_SIG,CNTRY_SIG,CAR_ON_CNTRY_RD,CLOCK,CLEAR);
initial
$monitor($time, "Main Sig = %b Country Sig=%b Car_on_cntry=%b",MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);

initial
begin
CLOCK =`FALSE;
forever #5 CLOCK =~CLOCK;
end

//control clear signal

initial 
begin
CLEAR =`TRUE;
repeat (5) @(negedge CLOCK); 
CLEAR=`FALSE;

end

//apply stimulus

initial
begin
CAR_ON_CNTRY_RD =`FALSE;

#200 CAR_ON_CNTRY_RD=`TRUE; 
#100 CAR_ON_CNTRY_RD=`FALSE;

#200 CAR_ON_CNTRY_RD=`TRUE;
#100 CAR_ON_CNTRY_RD=`FALSE;

#200 CAR_ON_CNTRY_RD=`TRUE; 
#100 CAR_ON_CNTRY_RD=`FALSE;

#100 $stop;

end 
endmodule
