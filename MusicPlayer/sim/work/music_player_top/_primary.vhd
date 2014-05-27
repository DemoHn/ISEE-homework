library verilog;
use verilog.vl_types.all;
entity music_player_top is
    port(
        play_button     : in     vl_logic;
        next_button     : in     vl_logic;
        reset_n         : in     vl_logic;
        clk             : in     vl_logic;
        AC97Clk         : in     vl_logic;
        SData_In        : in     vl_logic;
        AC97Reset_n     : out    vl_logic;
        SData_Out       : out    vl_logic;
        Sync            : out    vl_logic;
        play_led        : out    vl_logic;
        song_led        : out    vl_logic_vector(1 downto 0)
    );
end music_player_top;
