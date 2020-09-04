`timescale 1ns / 1ps

import lynxTypes::*;

/**
 * User logic
 * 
 */
module design_user_logic_0 (
    // Clock and reset
    input  wire                 aclk,
    input  wire[0:0]            aresetn,

    // AXI4 control
    AXI4L.s                     axi_ctrl,

    // AXI4S
    AXI4S.m                     axis_src,
    AXI4S.s                     axis_sink
);

/* -- Tie-off unused interfaces and signals ----------------------------- */
//always_comb axi_ctrl.tie_off_s();
always_comb axis_src.tie_off_m();
//always_comb axis_sink.tie_off_s();

/* -- USER LOGIC -------------------------------------------------------- */
// Reg input
AXI4S axis_sink_r ();
//AXI4S axis_src_r ();
axis_reg_rtl inst_reg_sink (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_sink), .axis_out(axis_sink_r));
//axis_reg_rtl inst_reg_src (.aclk(aclk), .aresetn(aresetn), .axis_in(axis_src_r), .axis_out(axis_src));

logic clr;
logic done;
logic [31:0] minimum;
logic [31:0] maximum;
logic [31:0] summation;

// Slave
minmaxsum_slave inst_slave (
    .aclk(aclk),
    .aresetn(aresetn),
    .axi_ctrl(axi_ctrl),
    .clr(clr),
    .done(done),
    .minimum(minimum),
    .maximum(maximum),
    .summation(summation)
)

// Minmaxsum
minmaxsum inst_top (
    .clk(aclk),
    .rst_n(aresetn),
    .clr(clr),
    .done(done),
    .min_out(minimum),
    .max_out(maximum),
    .sum_out(summation),
    .axis_in_tvalid(axis_sink_r.tvalid),
    .axis_in_tdata(axis_sink_r.tdata),
    .axis_in_tlast(axis_sink_r.tlast)
);

assign axis_sink_r.tready = 1'b1;

endmodule
