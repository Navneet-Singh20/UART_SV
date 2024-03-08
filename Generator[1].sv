class Generator_c;
  
  mailbox Gen2Driv;
  mailbox Gen2sb;
  
  int no_of_pkts_to_be_generated;
  
  function new(mailbox Gen2Driv, mailbox Gen2sb);
    this.Gen2Driv = Gen2Driv;
    this.Gen2sb = Gen2sb;
  endfunction
  
  task run_t;
    
    Transaction_c pkt_h;
    
    repeat(no_of_pkts_to_be_generated)
    begin
      pkt_h = new();
      
      if(!pkt_h.randomize())
        begin
          $display("Randomization fail");
        end
      
      Gen2Driv.put(pkt_h);
      Gen2sb.put(pkt_h);
      
      pkt_h.print("Generator");
      
    end
    
  endtask
  
endclass
      
      