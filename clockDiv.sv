`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 09:04:33 PM
// Design Name: 
// Module Name: clockDiv
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



module clockDiv(clock_in,clock_out
    );
    parameter baud_rate = 9600;
    
        input clock_in; 
        output reg clock_out; 
        reg[27:0] counter;
        
        always @(posedge clock_in)
        begin
            counter <= counter + 1;
            if(counter>=(100_000_000/baud_rate))
            begin
                counter <= 0;
                clock_out <= ~clock_out;
            end
        end
endmodule