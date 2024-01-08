`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 09:52:21 PM
// Design Name: 
// Module Name: btn_debouncer
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


module btn_debouncer(
        input logic btn, clk,
        output logic debounced_btn
    );
    
    logic clock_out;
    
    clockDiv div(clk,clock_out);
    
    typedef enum logic [1:0] {idle, debounce, stall} tstate;
        tstate [1:0] state;
   
    always_ff @(posedge clock_out) begin
       case (state)
        idle: begin
            debounced_btn <= 0;
            if(btn) begin
                state<=debounce;
            end
            else if (!btn) begin
                state <= idle;
            end
        end  
        
        debounce: begin
            debounced_btn <= 1;
            state<=stall;
        end 
        
        stall: begin
            debounced_btn <= 0;
            if( btn) begin
                debounced_btn <= 0;
            end
            else begin
                state <= idle;
            end
        end   
        endcase

    end
endmodule
