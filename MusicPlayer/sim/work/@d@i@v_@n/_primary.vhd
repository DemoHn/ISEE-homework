library verilog;
use verilog.vl_types.all;
entity DIV_N is
    generic(
        n               : integer := 17
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \out\           : out    vl_logic
    );
end DIV_N;
