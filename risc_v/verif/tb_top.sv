// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
// Description : Testbench for top.sv module

module tb_top;
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  import rv32i_pkg::DPW;
      // Input Ports
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-parameter
  //////////////////////////////////////////////////////////////////////////////////////////////////
  parameter int ADW = 5;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////
    
    logic           clk;
    logic           flushF;
    logic           stallF;
    logic [DPW-1:0] PCNext;

    logic [DPW-1:0] PCF;
    logic [DPW-1:0] instr;

    logic [DPW-1:0] aluresultM;
    logic [DPW-1:0] Rd2M;
    logic           memwriteM;
    logic [DPW-1:0] rd;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
    top
  #(
   .ADW(ADW)
  ) u_top(
    // Input Ports
      .clk        (clk),
      .flushF     (flushF),
      .stallF     (stallF),
      .PCNext     (PCNext),

      .PCF        (PCF),
      .instr      (instr),

      .aluresultM (aluresultM),
      .Rd2M       (Rd2M),
      .memwriteM  (memwriteM),
      .rd         (rd)
);
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  task start_tclk ();
  fork
      forever begin
          clk = 1; #5;
          clk = 0; #5;
      end
  join_none
  endtask

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
    $dumpfile("raw.vcd");
    $dumpvars;
    
    end
    
    final begin
    $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
    end
    initial 
    begin
      start_tclk ();

      repeat(5) @(negedge clk);
      $finish;
    end
 
endmodule
