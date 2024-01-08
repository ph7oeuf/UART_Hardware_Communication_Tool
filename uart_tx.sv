
module uart_tx(
	input logic clk,
	input logic rst,
	input logic [7:0] data,
	input logic BTNC,
	input logic BTND,
	output logic done,
	output logic tx,
	output logic [7:0] TXREG
	);
    
	typedef enum logic {idle, transmit} typename;
	typename state;
    
	logic [3:0] bitcntr;
	logic clock_out;
	logic [10:0]data_hold = 0;
	logic BTND_db;
	logic BTNC_db;
	logic btnDcntr;
	
    logic [7:0] Tdata1;
    logic [7:0] Tdata2;
    logic [7:0] Tdata3;
    logic [7:0] Tdata4;
    
    logic [31:0] Tdata;
    
    clockDiv div(clk,clock_out);
    btn_debouncer btn_dbcr (BTND, clk, BTND_db);
    btn_debouncer btn_dbcr2 (BTNC, clk, BTNC_db);
    
	always_ff @(posedge clock_out) begin
    	if (rst) begin
        	state <= idle;
        	done <= 1'b0;
    	end
    	else begin
        	case (state)
        	
            	idle: begin
            	    btnDcntr <= 0;
            	    bitcntr <=0;
                	done <= 1'b0;
                	tx <= 1'b1;
                  	if(BTND_db) begin
                       Tdata3 <= Tdata4;
                       Tdata2 <= Tdata3;
                       Tdata1 <= Tdata2;
                       Tdata4 <= data;
                                  
                       TXREG <= data;
                  	end
                  	if(BTNC_db) begin
                  	    data_hold <= {1'b1, 1'b1, Tdata1, 1'b0};
                    	state<=transmit;
                    	bitcntr <=0;
                  	end
            	end
           	 
            	transmit: begin
                    tx <= data_hold[bitcntr];
                    bitcntr<=bitcntr+1;
                 
                    if(bitcntr==10) begin
                        done <= 1'b1;
                        state <= idle;
                    end
               
            	end
        	endcase
   	 
//        	if (BTNC) begin
//            	state <= idle;
//        	end
    	end
	end
endmodule
