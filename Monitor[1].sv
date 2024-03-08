class Monitor_c;
  
  mailbox mon2sb;
  
  virtual UART_inf vif;
  
  Transaction_c pkt_h;
  
  event receiver_done;
  
  function new(mailbox mon2sb, virtual UART_inf vif,event receiver_done);
    this.mon2sb = mon2sb;
    this.vif = vif;
    this.receiver_done = receiver_done;
  endfunction
  
  task run_t;
    while(1) 
      begin
        if(!vif.reset)
          begin
            pkt_h = new();
            wait(vif.o_Rx_DV);
            pkt_h.Rx_Byte = vif.o_Rx_Byte;
            mon2sb.put(pkt_h);
            
            pkt_h.print("Monitor");
            
            -> receiver_done;
            @(posedge vif.clk);
            
          end
        else
          begin
            wait(!vif.reset);
          end
      end
  endtask
  
endclass
            
            