// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
// Description : Testbench for top.sv module

module tb_top;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
  // Input Ports


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic           clk;
  logic           flushF = 0;
  logic           stallF = 0;
  logic [DPW-1:0] PCNext;

  logic [DPW-1:0] PCF;
  logic [DPW-1:0] instr;

  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0] Rd2M;
  logic           memwriteM;
  logic [DPW-1:0] rd;

  logic           data_en;
  logic [DPW-1:0] input_data;
  logic [DPW-1:0] input_addr;
  logic [DPW-1:0] data_array[16];

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  top  u_top (
         .clk(clk),
         .flushF(flushF),
         .stallF(stallF),
         .PCNext(PCNext),
         .data_en(data_en),
         .input_data(input_data),
         .input_addr(input_addr),
         .PCF(PCF),
         .instr(instr),
         .aluresultM(aluresultM),
         .Rd2M(Rd2M),
         .memwriteM(memwriteM),
         .rd(rd)
       );


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  task start_tclk();
    fork
      forever
      begin
        clk = 1;
        #5;
        clk = 0;
        #5;
      end
      join_none
      endtask

      //////////////////////////////////////////////////////////////////////////////////////////////////
      //-PROCEDURALS
      //////////////////////////////////////////////////////////////////////////////////////////////////

      initial
      begin
        $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
        $dumpfile("raw.vcd");
        $dumpvars;
      end

      final
        begin
          $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
        end

        initial
        begin
          for(int i=0;i<10;i++)
          begin
          data_array[i]=$urandom;
          $display("%h",data_array[i]);
          end
          for(int i=0;i<16;i++)
          begin
          
          end
          start_tclk();
          PCNext <= 32'b0;
          repeat (100) @(posedge clk);
          $monitor("PCF =%h,instr = %h, aluresultM=%h,Rd2M =%h, memwriteM=%h, rd =%h", PCF, instr,
                   aluresultM, Rd2M, memwriteM, rd);
          PCNext <= 32'h00000004;
          repeat (20) @(posedge clk);
          //$display("PCF =%h,instr = %h, aluresultM=%h,Rd2M =%h, memwriteM=%h, rd =%h",PCF,instr,aluresultM,Rd2M,memwriteM,rd);
          $finish;
        end

      endmodule
