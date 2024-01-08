
module top( 
      input logic clk,
      input logic rst,
      input logic [7:0] data,
      input logic BTNC,
      input logic BTND,
      input logic received,
      output logic transmitted,
      output logic [7:0] RXBUF,
      output logic [7:0] TXREG
    );
    
   logic Rdone, Tdone;
     
   uart_tx transmitter(
       clk, rst, data, BTNC, BTND, Tdone, transmitted, TXREG
   );
       
   uart_rx receiver(
    clk, rst, received, Rdone, RXBUF
   );
          
endmodule