library verilog;
use verilog.vl_types.all;
entity beat_generater is
    generic(
        CounterBits     : integer := 3;
        N               : integer := 5
    );
    port(
        clk             : in     vl_logic;
        ci              : in     vl_logic;
        co              : out    vl_logic;
        clear           : in     vl_logic
    );
end beat_generater;
