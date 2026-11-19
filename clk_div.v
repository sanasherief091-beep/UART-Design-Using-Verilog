module ClkDiv (
//interface signals
input  wire       i_ref_clk,
input  wire       i_rst_n,
input  wire       i_clk_en,
input  wire [7:0] i_div_ratio,
output wire        o_div_clk
);

//internal signals
wire       ev_od;
wire [7:0] togg;
wire       changed; // to detect change
reg  [7:0] pre_ratio;
reg  [7:0] counter;
reg        odd_sel;
reg        o_div_clk_reg;

assign changed =(pre_ratio != i_div_ratio);//high if any changed happend
assign togg  = i_div_ratio >> 1; //divided by 2
assign ev_od = i_div_ratio[0];   //0:even , 1:odd

always @(posedge i_ref_clk or negedge i_rst_n) 
 begin
 if (!i_rst_n)
   begin
    counter       <= 'd0;
    odd_sel       <= 'd0;
    o_div_clk_reg <=  i_ref_clk;
    pre_ratio     <= 'd0; 
   end
 else
  begin
   pre_ratio <= i_div_ratio;// save last ratio
   //if ratio = 1 | 0 or the enable = 0 
   if(!i_clk_en || i_div_ratio == 1 || i_div_ratio == 0 )
    begin 
     o_div_clk_reg <= i_ref_clk;
     counter       <= 'd0; 
     odd_sel       <= 'd0; 
    end 
   else if (changed)
    begin
     counter       <= 'd0;
     odd_sel       <= 'd0;
     o_div_clk_reg <=  i_ref_clk;  
    end 
   //even case
   else if(!ev_od && counter == togg - 1)
    begin
     o_div_clk_reg <= !o_div_clk_reg;
     counter       <='d0;
    end
   else if(ev_od && counter == togg - 1 && !odd_sel)
    begin 
     o_div_clk_reg <= !o_div_clk_reg;
     counter       <= 'd0;
     odd_sel       <= 'd1;
    end
   else if (ev_od && counter == (i_div_ratio - togg) - 1 && odd_sel)
    begin
     o_div_clk_reg <= !o_div_clk_reg;
     counter   <= 'd0;
     odd_sel   <= 'd0;
    end
   else 
     counter    <= counter + 1;
  end   
    end 
 assign o_div_clk = (!i_clk_en || i_div_ratio == 1 || i_div_ratio == 0) ? i_ref_clk : o_div_clk_reg;
endmodule




