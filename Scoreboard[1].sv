class Scoreboard_c;
  
  Transaction_c pkt_h1;
  Transaction_c pkt_h2;
  
  mailbox Gen2sb;
  mailbox mon2sb;
  
  event receiver_done;
  
  int no_of_pkts_compared;
  
  function new(mailbox Gen2sb, mailbox mon2sb, event receiver_done);
    this.Gen2sb = Gen2sb;
    this.mon2sb = mon2sb;
    this.receiver_done = receiver_done;
  endfunction
  
  task run_t;
    while(1) begin
      wait(receiver_done.triggered);
      
      mon2sb.get(pkt_h2);
      
      $display($time," -----------------Inside Scoreboard---------------");
      $display($time," -------------Get packet from Monitor-------------");
      pkt_h2.print("Score_Mon");
      
      Gen2sb.get(pkt_h1);
 
      $display($time," -------------Get packet from Generator-----------");
      pkt_h1.print("Score_Gen");
      
      if(pkt_h1.Tx_Byte == pkt_h2.Rx_Byte)
        begin
          $display($time," --------------------PASS---------------------");
          $display();
        end
      else
        begin
          $display($time," --------------------FAIL---------------------");
          $display();
        end
      no_of_pkts_compared++;
     
    end
  endtask
  
endclass
      