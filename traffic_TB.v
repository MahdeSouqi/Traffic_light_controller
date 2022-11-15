module traffic_tb;
  
  
  wire [2:0] light_highway;
  wire [2:0] light_farm;
  reg S;
  reg clk;
  reg rst;
  
  traffic_light

  traffic_light_inst
   ( 
    .light_highway (  light_highway   ),
    .light_farm    (  light_farm    ),
    .S     (  S  ),
    .clk     (  clk   ),
    .rst   ( rst ) 
   );
  
  task expect_HIGH ;
    input [2:0] exp_out_light_highway;
    if ( light_highway!==exp_out_light_highway) begin
      $display("TEST FAILED");
      $display("At time %0d light_highway=%b light_farm=%b S=%b rst=%b" ,
                $time,light_highway ,light_farm , S, rst);
      $display("light_highway should be %b", exp_out_light_highway);
      $finish;
    end
    else begin
      
      $display("At time %0d light_highway=%b light_farm=%b S=%b rst=%b" ,
                $time,light_highway ,light_farm , S, rst);
      
    end
  endtask
  
  task expect_FARM ;
    input [2:0] exp_out_light_farm;
    if (light_farm!==exp_out_light_farm ) begin
      $display("TEST FAILED");
      $display("At time %0d light_highway=%b light_farm=%b S=%b rst=%b" ,
                $time,light_highway ,light_farm , S, rst);
      $display("light_farm should be %b", exp_out_light_farm);
      $finish;
    end
   
  endtask
  
  initial begin
     clk = 1'b0;
     rst = 1'b0;
       S = 1'b0;
  end
  
  initial repeat (500) begin #5 clk=~clk; end

  initial @(negedge clk) begin
    $dumpfile("dump.vcd"); $dumpvars;
    //note that the yellow color needs 4 clks to turn to the next color
    rst=0;  S=0; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    rst=1;  S=0; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (4); expect_FARM (1);
    rst=1;  S=0; @(negedge clk) expect_HIGH (4); expect_FARM (2);
    rst=1;  S=0; @(negedge clk) expect_HIGH (4); expect_FARM (2);
    rst=1;  S=0; @(negedge clk) expect_HIGH (4); expect_FARM (2);
    rst=1;  S=0; @(negedge clk) expect_HIGH (4); expect_FARM (2);
    rst=1;  S=0; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    rst=1;  S=0; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (2); expect_FARM (4);
    rst=1;  S=1; @(negedge clk) expect_HIGH (4); expect_FARM (1);
    rst=1;  S=1; @(negedge clk) expect_HIGH (4); expect_FARM (1);
    rst=0;  S=1; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    rst=0;  S=0; @(negedge clk) expect_HIGH (1); expect_FARM (4);
    
    
      
    $display("TEST PASSED");
    $finish;
  end

endmodule
