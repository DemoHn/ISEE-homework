library verilog;
use verilog.vl_types.all;
entity frequency_rom is
    port(
        clk             : in     vl_logic;
        dout            : out    vl_logic_vector(19 downto 0);
        addr            : in     vl_logic_vector(5 downto 0)
    );
end frequency_rom;
