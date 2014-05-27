library verilog;
use verilog.vl_types.all;
entity button_press_unit is
    generic(
        WIDTH           : integer := 17
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \in\            : in     vl_logic;
        \out\           : out    vl_logic
    );
end button_press_unit;
