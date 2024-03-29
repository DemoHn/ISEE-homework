library verilog;
use verilog.vl_types.all;
entity D_FFR is
    generic(
        WIDTH           : integer := 1
    );
    port(
        d               : in     vl_logic_vector;
        r               : in     vl_logic;
        clk             : in     vl_logic;
        q               : out    vl_logic_vector
    );
end D_FFR;
