import lynxTypes::*;

module crc32_calc(
    // Networking interface - Incoming and outgoing traffic 
    AXI4S.m m_axis_rx, 
    AXI4S.m m_axis_tx, 

    // Incoming clock and reset
    input logic nclk, 
    input logic nresetn
);

