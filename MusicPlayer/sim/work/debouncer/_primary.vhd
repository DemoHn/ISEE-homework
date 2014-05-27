library verilog;
use verilog.vl_types.all;
entity debouncer is
    generic(
        WIDTH           : integer := 3
    );
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic;
        \out\           : out    vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic
    );
end debouncer;
