library verilog;
use verilog.vl_types.all;
entity mcu is
    generic(
        \RESET\         : integer := 0;
        \WAIT\          : integer := 1;
        \NEXT\          : integer := 3;
        \PLAY\          : integer := 2;
        \END\           : integer := 6
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        play_button     : in     vl_logic;
        \next\          : in     vl_logic;
        play            : out    vl_logic;
        song            : out    vl_logic_vector(1 downto 0);
        reset_play      : out    vl_logic;
        song_done       : in     vl_logic
    );
end mcu;
