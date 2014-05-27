library verilog;
use verilog.vl_types.all;
entity music_player is
    generic(
        BEAT_COUNT      : integer := 1000
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        play_button     : in     vl_logic;
        \next\          : in     vl_logic;
        New_Frame       : in     vl_logic;
        sample_out      : out    vl_logic_vector(15 downto 0);
        play            : out    vl_logic;
        song            : out    vl_logic_vector(1 downto 0)
    );
end music_player;
