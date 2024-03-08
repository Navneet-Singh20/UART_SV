`include "UART_RX.sv"
`include "UART_TX.sv"
`include "Interface.sv"
`include "Test.sv"

module top;
  
  logic clk;
  logic reset;
  
  parameter c_CLOCK_PERIOD_NS = 100;
  parameter c_CLKS_PER_BIT    = 20; //87
  
  UART_inf vif(clk,reset);
  
  test PB(vif);
  
  uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX
  (.i_Clock(vif.clk),
   .i_Tx_DV(vif.i_Tx_DV),
   .i_Tx_Byte(vif.i_Tx_Byte),
   .o_Tx_Active(vif.o_Tx_Active),
   .o_Tx_Serial(vif.io_Tx_Rx_Serial),
   .o_Tx_Done(vif.o_Tx_Done)
     );
  
   uart_rx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX
  (.i_Clock(vif.clk),
   .i_Rx_Serial(vif.io_Tx_Rx_Serial),
   .o_Rx_DV(vif.o_Rx_DV),
   .o_Rx_Byte(vif.o_Rx_Byte)
     );

  
  initial begin
    clk = 0;
    forever begin
      #(c_CLOCK_PERIOD_NS/2) clk = !clk;
    end
  end
  
  initial begin
    reset = 1;
    repeat(2) @(posedge vif.clk);
    reset = 0;
  end
  
  initial begin
    repeat(3) begin
    vif.i_Tx_DV = 1;
    repeat(10) @(posedge vif.clk);
    vif.i_Tx_DV = 0;
    wait(vif.o_Tx_Done);
    end
  end
  
  initial begin
    $dumpfile(".vcd");
    $dumpvars;
  end
  
endmodule
  