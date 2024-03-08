`include "Environment.sv"

program test(UART_inf vif);
  
  Environment_c env_h;
  
  initial begin
    env_h = new(vif);
    env_h.gen_h.no_of_pkts_to_be_generated = 3 ;
    env_h.run_t();
  end
  
endprogram
  