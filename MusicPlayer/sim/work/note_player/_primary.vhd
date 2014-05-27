library verilog;
use verilog.vl_types.all;
entity note_player is
    generic(
        \RESET\         : integer := 0;
        PLAY            : integer := 1;
        LOAD            : integer := 2;
        DONE            : integer := 3
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        play_enable     : in     vl_logic;
        note_to_load    : in     vl_logic_vector(5 downto 0);
        duration_to_load: in     vl_logic_vector(5 downto 0);
        done_with_note  : out    vl_logic;
        load_new_note   : in     vl_logic;
        beat            : in     vl_logic;
        generate_next_sample: in     vl_logic;
        sample_out      : out    vl_logic_vector(15 downto 0);
        new_sample_ready: out    vl_logic
    );
end note_player;
