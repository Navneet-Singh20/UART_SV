class Driver_c;
  
  mailbox Gen2Driv;
  
  virtual UART_inf vif;
  
  Transaction_c pkt_h;
  
  function new(mailbox Gen2Driv,virtual UART_inf vif);
    this.Gen2Driv = Gen2Driv;
    this.vif = vif;
  endfunction
  
  task run_t;
    while(1) begin
    if(!vif.reset)
      begin
        Gen2Driv.get(pkt_h);
        wait(vif.i_Tx_DV);
        vif.i_Tx_Byte = pkt_h.Tx_Byte;
        pkt_h.print("Driver");
        wait(vif.o_Rx_DV);
      end
    else
      begin
        $display("Reset started");
        //vif.i_Tx_Byte = 8'b0000_0000;
        //vif.i_Tx_Byte = 0;
        wait(!vif.reset);
        $display("Reset stopped");
      end
    end
  endtask
        
endclass