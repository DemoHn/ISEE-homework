library verilog;
use verilog.vl_types.all;
entity song_rom is
    port(
        clk             : in     vl_logic;
        dout            : out    vl_logic_vector(11 downto 0);
        addr            : in     vl_logic_vector(6 downto 0)
    );
end song_rom;
