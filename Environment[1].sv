`include "Transaction.sv"
`include "Generator.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

class Environment_c;
  
  Scoreboard_c sb_h;
  Generator_c gen_h;
  Monitor_c mon_h;
  Driver_c drv_h;
  
  mailbox mon2sb;
  mailbox Gen2Driv;
  mailbox Gen2sb;
  
  event receiver_done;
  
  virtual UART_inf vif;
  
  function new(virtual UART_inf vif);
    this.vif = vif;
    mon2sb = new();
    Gen2sb = new();
    Gen2Driv = new();
    
    gen_h = new(Gen2Driv,Gen2sb);
    drv_h = new(Gen2Driv,vif);
    mon_h = new(mon2sb,vif,receiver_done);
    sb_h  = new(Gen2sb,mon2sb,receiver_done);
    
  endfunction
  
  task pre_test();
    $display("Test is started");
  endtask
  
  task test();
    fork
      gen_h.run_t();
      drv_h.run_t();
      mon_h.run_t();
      sb_h.run_t();
    join_any
  endtask
  
  task post_test();
    fork
      wait(gen_h.no_of_pkts_to_be_generated == sb_h.no_of_pkts_compared);
      
      repeat(2000) @(posedge vif.clk);	// to save from DEAD_LOCK
      
    join_any
    
  endtask
  
  task run_t();
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass
  
    