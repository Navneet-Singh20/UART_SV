interface UART_inf(input logic clk,reset);
  logic i_Tx_DV;					//	IMP
  logic [7:0] i_Tx_Byte;			// IMP
  logic o_Tx_Active;
  logic o_Tx_Done;
  
  logic io_Tx_Rx_Serial;		    // output for Tx and input for Rx
  
  logic o_Rx_DV;
  logic [7:0] o_Rx_Byte;			// IMP
  
endinterface
  