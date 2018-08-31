create_clock -name clk_50M_source -period 20 -waveform {0 10} [get_ports {clk_50M}] -add
