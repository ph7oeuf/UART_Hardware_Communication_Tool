`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2023 09:02:19 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
	input logic clk,
	input logic rst,
	input logic txbit,
	output logic done,
	output logic [7:0] RXBUF
	);
    
	typedef enum logic {idle, receive} tstate;
	tstate state;
   
	logic [3:0] bitcntr;
	logic clock_out;
	
	logic [7:0] Rdata1;
    logic [7:0] Rdata2;
    logic [7:0] Rdata3;
    logic [7:0] Rdata4;
        
	clockDiv div(clk,clock_out);
    
	always_ff @(posedge clock_out) begin
    	if (rst) begin
        	state <= idle;
        	done <= 1'b0;
    	end
    	else begin
        	case (state)
            	idle: begin
            	    RXBUF <= Rdata4;
                	done <= 1'b0;
                	bitcntr <=0;
                  	if(!txbit) begin
                    	state<=receive;
                  	end
            	end
            	receive: begin
                    RXBUF[bitcntr] <= txbit;
                    bitcntr<=bitcntr+1;
                 
                    if(bitcntr==7) begin
                        
                        Rdata3 <= Rdata4;
                        Rdata2 <= Rdata3;
                        Rdata1 <= Rdata2;
                        Rdata4 <= RXBUF;
                        
                        
                       
                        done <= 1'b1;
                        state <= idle;
                    end
               
            	end
        	endcase
    	end
	end
endmodule
