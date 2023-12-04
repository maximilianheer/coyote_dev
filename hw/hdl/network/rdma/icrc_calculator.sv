`include "axi_macros.svh"
`include "lynx_macros.svh"

/**
 * @brief ICRC-calculation and insertion
 *
 * Directly connected to roce_v2_ip on the outgoing network path. 
 */

module icrc_calculator (
    input wire nclk, 
    input wire nresetn, 

    // Network Input from the roce_v2_ip
    AXI4S.s m_axis_rx, 

    // Network Output to the output of roce_stack
    AXI4S.m m_axis_tx
);

// 