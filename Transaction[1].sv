class Transaction_c;
  
  rand bit [7:0] Tx_Byte;
  
  bit [7:0] Rx_Byte;
  
  function void print(string name);
    $display($time," %s :> Tx_Byte = %0h, Rx_Byte = %0h ",name,Tx_Byte,Rx_Byte);
  endfunction
  
endclass
  