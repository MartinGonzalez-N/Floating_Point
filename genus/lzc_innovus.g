######################################################################

# Created by Genus(TM) Synthesis Solution 21.10-p002_1 on Tue Sep 24 20:53:51 UTC 2024

# This file contains the Genus script for /designs/lzc_32

######################################################################

::legacy::set_attribute -quiet init_lib_search_path /home/joc/jc_work/Floating_Point/genus/ /
::legacy::set_attribute -quiet common_ui false /
::legacy::set_attribute -quiet design_mode_process no_value /
::legacy::set_attribute -quiet phys_assume_met_fill 0.0 /
::legacy::set_attribute -quiet map_placed_for_route_early_global false /
::legacy::set_attribute -quiet phys_use_invs_extraction true /
::legacy::set_attribute -quiet phys_route_time_out 120.0 /
::legacy::set_attribute -quiet capacitance_per_unit_length_mmmc {} /
::legacy::set_attribute -quiet resistance_per_unit_length_mmmc {} /
::legacy::set_attribute -quiet runtime_by_stage {{PBS_Generic-Start 0 14 0.0 12.0} {to_generic 1 15 0 12} {first_condense 1 16 0 13} {PBS_Generic_Opt-Post 2 16 0.9547980000000003 12.954798} {{PBS_Generic-Postgen HBO Optimizations} 0 16 0.0 12.954798}} /
::legacy::set_attribute -quiet timing_adjust_tns_of_complex_flops false /
::legacy::set_attribute -quiet hdl_language sv /
::legacy::set_attribute -quiet tinfo_tstamp_file .rs_joc.tstamp /
::legacy::set_attribute -quiet script_search_path /home/joc/jc_work/Floating_Point/genus/ /
::legacy::set_attribute -quiet timing_disable_library_data_to_data_checks false /
::legacy::set_attribute -quiet timing_disable_non_sequential_checks false /
::legacy::set_attribute -quiet flow_metrics_snapshot_uuid 20df2bb2-24c1-4cee-85e3-425b2d7c652a /
::legacy::set_attribute -quiet phys_use_segment_parasitics true /
::legacy::set_attribute -quiet probabilistic_extraction true /
::legacy::set_attribute -quiet ple_correlation_factors {1.9000 2.0000} /
::legacy::set_attribute -quiet maximum_interval_of_vias inf /
::legacy::set_attribute -quiet layer_aware_buffer true /
::legacy::set_attribute -quiet interconnect_mode wireload /
::legacy::set_attribute -quiet wireload_mode top /
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkbufkapwr_1
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkbufkapwr_16
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkbufkapwr_2
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkbufkapwr_4
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkbufkapwr_8
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkinvkapwr_1
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkinvkapwr_16
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkinvkapwr_2
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkinvkapwr_4
::legacy::set_attribute -quiet is_always_on true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_clkinvkapwr_8
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_inputiso0n_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_inputiso0p_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_inputiso1n_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_inputiso1p_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_inputisolatch_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrc_1
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrc_16
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrc_2
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrc_4
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrc_8
::legacy::set_attribute -quiet is_isolation_cell true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_isobufsrckapwr_16
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet level_shifter_direction bidir /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_1
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet level_shifter_direction bidir /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_2
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet level_shifter_direction bidir /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap_4
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet level_shifter_direction up /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_4
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet level_shifter_direction up /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_1
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet level_shifter_direction up /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_2
::legacy::set_attribute -quiet is_level_shifter true /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet min_input_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet max_input_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet min_output_voltage 1.2000000476837158 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet max_output_voltage 2.0999999046325684 /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet level_shifter_valid_location any /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet level_shifter_direction up /libraries/sky130_fd_sc_hd__ff_100C_1v65/libcells/sky130_fd_sc_hd__lpflow_lsbuf_lh_isowell_tap_4
::legacy::set_attribute -quiet wireload_selection none /
::legacy::set_attribute -quiet tree_type balanced_tree /libraries/sky130_fd_sc_hd__ff_100C_1v65/operating_conditions/ff_100C_1v65
::legacy::set_attribute -quiet tree_type balanced_tree /libraries/sky130_fd_sc_hd__ff_100C_1v65/operating_conditions/_nominal_
# BEGIN MSV SECTION
# END MSV SECTION
# BEGIN DFT SECTION
::legacy::set_attribute -quiet dft_scan_style muxed_scan /
::legacy::set_attribute -quiet dft_scanbit_waveform_analysis false /
# END DFT SECTION
::legacy::set_attribute -quiet seq_reason_deleted_internal {} /designs/lzc_32
::legacy::set_attribute -quiet qos_by_stage {{to_generic {wns -11111111} {tns -111111111} {vep -111111111} {area 761} {cell_count 98} {utilization  0.00} {runtime 1 15 0 12} }{first_condense {wns -11111111} {tns -111111111} {vep -111111111} {area 749} {cell_count 89} {utilization  0.00} {runtime 1 16 0 13} }} /designs/lzc_32
::legacy::set_attribute -quiet seq_mbci_coverage 0.0 /designs/lzc_32
::legacy::set_attribute -quiet hdl_user_name lzc_32 /designs/lzc_32
::legacy::set_attribute -quiet hdl_filelist {{default -sv {SYNTHESIS} {../rtl/lz/lzc_32.sv} {/home/joc/jc_work/Floating_Point/rtl/lz/} {}} {default -sv {SYNTHESIS} {../rtl/lz/lzc_4.sv} {/home/joc/jc_work/Floating_Point/rtl/lz/} {}} {default -sv {SYNTHESIS} {../rtl/lz/lzc_8.sv} {/home/joc/jc_work/Floating_Point/rtl/lz/} {}} {default -sv {SYNTHESIS} {../rtl/lz/lzc_16.sv} {/home/joc/jc_work/Floating_Point/rtl/lz/} {}}} /designs/lzc_32
::legacy::set_attribute -quiet verification_directory fv/lzc_32 /designs/lzc_32
::legacy::set_attribute -quiet arch_filename ./../rtl/lz/lzc_32.sv /designs/lzc_32
::legacy::set_attribute -quiet entity_filename ./../rtl/lz/lzc_32.sv /designs/lzc_32
::legacy::set_attribute -quiet original_name {a[31]} {/designs/lzc_32/ports_in/a[31]}
::legacy::set_attribute -quiet original_name {a[30]} {/designs/lzc_32/ports_in/a[30]}
::legacy::set_attribute -quiet original_name {a[29]} {/designs/lzc_32/ports_in/a[29]}
::legacy::set_attribute -quiet original_name {a[28]} {/designs/lzc_32/ports_in/a[28]}
::legacy::set_attribute -quiet original_name {a[27]} {/designs/lzc_32/ports_in/a[27]}
::legacy::set_attribute -quiet original_name {a[26]} {/designs/lzc_32/ports_in/a[26]}
::legacy::set_attribute -quiet original_name {a[25]} {/designs/lzc_32/ports_in/a[25]}
::legacy::set_attribute -quiet original_name {a[24]} {/designs/lzc_32/ports_in/a[24]}
::legacy::set_attribute -quiet original_name {a[23]} {/designs/lzc_32/ports_in/a[23]}
::legacy::set_attribute -quiet original_name {a[22]} {/designs/lzc_32/ports_in/a[22]}
::legacy::set_attribute -quiet original_name {a[21]} {/designs/lzc_32/ports_in/a[21]}
::legacy::set_attribute -quiet original_name {a[20]} {/designs/lzc_32/ports_in/a[20]}
::legacy::set_attribute -quiet original_name {a[19]} {/designs/lzc_32/ports_in/a[19]}
::legacy::set_attribute -quiet original_name {a[18]} {/designs/lzc_32/ports_in/a[18]}
::legacy::set_attribute -quiet original_name {a[17]} {/designs/lzc_32/ports_in/a[17]}
::legacy::set_attribute -quiet original_name {a[16]} {/designs/lzc_32/ports_in/a[16]}
::legacy::set_attribute -quiet original_name {a[15]} {/designs/lzc_32/ports_in/a[15]}
::legacy::set_attribute -quiet original_name {a[14]} {/designs/lzc_32/ports_in/a[14]}
::legacy::set_attribute -quiet original_name {a[13]} {/designs/lzc_32/ports_in/a[13]}
::legacy::set_attribute -quiet original_name {a[12]} {/designs/lzc_32/ports_in/a[12]}
::legacy::set_attribute -quiet original_name {a[11]} {/designs/lzc_32/ports_in/a[11]}
::legacy::set_attribute -quiet original_name {a[10]} {/designs/lzc_32/ports_in/a[10]}
::legacy::set_attribute -quiet original_name {a[9]} {/designs/lzc_32/ports_in/a[9]}
::legacy::set_attribute -quiet original_name {a[8]} {/designs/lzc_32/ports_in/a[8]}
::legacy::set_attribute -quiet original_name {a[7]} {/designs/lzc_32/ports_in/a[7]}
::legacy::set_attribute -quiet original_name {a[6]} {/designs/lzc_32/ports_in/a[6]}
::legacy::set_attribute -quiet original_name {a[5]} {/designs/lzc_32/ports_in/a[5]}
::legacy::set_attribute -quiet original_name {a[4]} {/designs/lzc_32/ports_in/a[4]}
::legacy::set_attribute -quiet original_name {a[3]} {/designs/lzc_32/ports_in/a[3]}
::legacy::set_attribute -quiet original_name {a[2]} {/designs/lzc_32/ports_in/a[2]}
::legacy::set_attribute -quiet original_name {a[1]} {/designs/lzc_32/ports_in/a[1]}
::legacy::set_attribute -quiet original_name {a[0]} {/designs/lzc_32/ports_in/a[0]}
::legacy::set_attribute -quiet original_name {c[4]} {/designs/lzc_32/ports_out/c[4]}
::legacy::set_attribute -quiet original_name {c[3]} {/designs/lzc_32/ports_out/c[3]}
::legacy::set_attribute -quiet original_name {c[2]} {/designs/lzc_32/ports_out/c[2]}
::legacy::set_attribute -quiet original_name {c[1]} {/designs/lzc_32/ports_out/c[1]}
::legacy::set_attribute -quiet original_name {c[0]} {/designs/lzc_32/ports_out/c[0]}
::legacy::set_attribute -quiet original_name v /designs/lzc_32/ports_out/v
# BEGIN PMBIST SECTION
# END PMBIST SECTION
#############################################################
#####   FLOW WRITE   ########################################
##
## Written by Genus(TM) Synthesis Solution version 21.10-p002_1
## flowkit v21.10-d047_1
## Written on 20:53:51 24-Sep 2024
#############################################################
#####   Flow Definitions   ##################################

#############################################################
#####   Step Definitions   ##################################


#############################################################
#####   Attribute Definitions   #############################

if {[is_attribute flow_edit_end_steps -obj_type root]} {set_flowkit_db flow_edit_end_steps {}}
if {[is_attribute flow_edit_start_steps -obj_type root]} {set_flowkit_db flow_edit_start_steps {}}
if {[is_attribute flow_footer_tcl -obj_type root]} {set_flowkit_db flow_footer_tcl {}}
if {[is_attribute flow_header_tcl -obj_type root]} {set_flowkit_db flow_header_tcl {}}
if {[is_attribute flow_metadata -obj_type root]} {set_flowkit_db flow_metadata {}}
if {[is_attribute flow_setup_config -obj_type root]} {set_flowkit_db flow_setup_config {HUDDLE {!!map {}}}}
if {[is_attribute flow_step_begin_tcl -obj_type root]} {set_flowkit_db flow_step_begin_tcl {}}
if {[is_attribute flow_step_check_tcl -obj_type root]} {set_flowkit_db flow_step_check_tcl {}}
if {[is_attribute flow_step_end_tcl -obj_type root]} {set_flowkit_db flow_step_end_tcl {}}
if {[is_attribute flow_step_order -obj_type root]} {set_flowkit_db flow_step_order {}}
if {[is_attribute flow_summary_tcl -obj_type root]} {set_flowkit_db flow_summary_tcl {}}
if {[is_attribute flow_template_feature_definition -obj_type root]} {set_flowkit_db flow_template_feature_definition {}}
if {[is_attribute flow_template_type -obj_type root]} {set_flowkit_db flow_template_type {}}
if {[is_attribute flow_template_tools -obj_type root]} {set_flowkit_db flow_template_tools {}}
if {[is_attribute flow_template_version -obj_type root]} {set_flowkit_db flow_template_version {}}
if {[is_attribute flow_user_templates -obj_type root]} {set_flowkit_db flow_user_templates {}}


#############################################################
#####   Flow History   ######################################

if {[is_attribute flow_user_templates -obj_type root]} {set_flowkit_db flow_user_templates {}}
if {[is_attribute flow_plugin_steps -obj_type root]} {set_flowkit_db flow_plugin_steps {}}
if {[is_attribute flow_template_type -obj_type root]} {set_flowkit_db flow_template_type {}}
if {[is_attribute flow_template_tools -obj_type root]} {set_flowkit_db flow_template_tools {}}
if {[is_attribute flow_template_version -obj_type root]} {set_flowkit_db flow_template_version {}}
if {[is_attribute flow_template_feature_definition -obj_type root]} {set_flowkit_db flow_template_feature_definition {}}
if {[is_attribute flow_remark -obj_type root]} {set_flowkit_db flow_remark {}}
if {[is_attribute flow_features -obj_type root]} {set_flowkit_db flow_features {}}
if {[is_attribute flow_feature_values -obj_type root]} {set_flowkit_db flow_feature_values {}}
if {[is_attribute flow_write_db_args -obj_type root]} {set_flowkit_db flow_write_db_args {}}
if {[is_attribute flow_write_db_sdc -obj_type root]} {set_flowkit_db flow_write_db_sdc true}
if {[is_attribute flow_write_db_common -obj_type root]} {set_flowkit_db flow_write_db_common false}
if {[is_attribute flow_post_db_overwrite -obj_type root]} {set_flowkit_db flow_post_db_overwrite {}}
if {[is_attribute flow_step_order -obj_type root]} {set_flowkit_db flow_step_order {}}
if {[is_attribute flow_step_begin_tcl -obj_type root]} {set_flowkit_db flow_step_begin_tcl {}}
if {[is_attribute flow_step_end_tcl -obj_type root]} {set_flowkit_db flow_step_end_tcl {}}
if {[is_attribute flow_step_last -obj_type root]} {set_flowkit_db flow_step_last {}}
if {[is_attribute flow_step_current -obj_type root]} {set_flowkit_db flow_step_current {}}
if {[is_attribute flow_step_canonical_current -obj_type root]} {set_flowkit_db flow_step_canonical_current {}}
if {[is_attribute flow_step_next -obj_type root]} {set_flowkit_db flow_step_next {}}
if {[is_attribute flow_working_directory -obj_type root]} {set_flowkit_db flow_working_directory .}
if {[is_attribute flow_branch -obj_type root]} {set_flowkit_db flow_branch {}}
if {[is_attribute flow_caller_data -obj_type root]} {set_flowkit_db flow_caller_data {}}
if {[is_attribute flow_metrics_snapshot_uuid -obj_type root]} {set_flowkit_db flow_metrics_snapshot_uuid 20df2bb2-24c1-4cee-85e3-425b2d7c652a}
if {[is_attribute flow_starting_db -obj_type root]} {set_flowkit_db flow_starting_db {}}
if {[is_attribute flow_db_directory -obj_type root]} {set_flowkit_db flow_db_directory dbs}
if {[is_attribute flow_report_directory -obj_type root]} {set_flowkit_db flow_report_directory reports}
if {[is_attribute flow_log_directory -obj_type root]} {set_flowkit_db flow_log_directory logs}
if {[is_attribute flow_mail_to -obj_type root]} {set_flowkit_db flow_mail_to {}}
if {[is_attribute flow_exit_when_done -obj_type root]} {set_flowkit_db flow_exit_when_done false}
if {[is_attribute flow_mail_on_error -obj_type root]} {set_flowkit_db flow_mail_on_error false}
if {[is_attribute flow_summary_tcl -obj_type root]} {set_flowkit_db flow_summary_tcl {}}
if {[is_attribute flow_history -obj_type root]} {set_flowkit_db flow_history {}}
if {[is_attribute flow_step_last_status -obj_type root]} {set_flowkit_db flow_step_last_status not_run}
if {[is_attribute flow_step_last_msg -obj_type root]} {set_flowkit_db flow_step_last_msg {}}
if {[is_attribute flow_run_tag -obj_type root]} {set_flowkit_db flow_run_tag {}}
if {[is_attribute flow_current_cache -obj_type root]} {set_flowkit_db flow_current_cache {}}
if {[is_attribute flow_step_order_cache -obj_type root]} {set_flowkit_db flow_step_order_cache {}}
if {[is_attribute flow_step_results_cache -obj_type root]} {set_flowkit_db flow_step_results_cache {}}
if {[is_attribute flow_metadata -obj_type root]} {set_flowkit_db flow_metadata {}}
if {[is_attribute flow_execute_in_global -obj_type root]} {set_flowkit_db flow_execute_in_global true}
if {[is_attribute flow_overwrite_db -obj_type root]} {set_flowkit_db flow_overwrite_db false}
if {[is_attribute flow_print_run_information -obj_type root]} {set_flowkit_db flow_print_run_information false}
if {[is_attribute flow_verbose -obj_type root]} {set_flowkit_db flow_verbose true}
if {[is_attribute flow_print_run_information_full -obj_type root]} {set_flowkit_db flow_print_run_information_full false}
if {[is_attribute flow_header_tcl -obj_type root]} {set_flowkit_db flow_header_tcl {}}
if {[is_attribute flow_footer_tcl -obj_type root]} {set_flowkit_db flow_footer_tcl {}}
if {[is_attribute flow_init_header_tcl -obj_type root]} {set_flowkit_db flow_init_header_tcl {}}
if {[is_attribute flow_init_footer_tcl -obj_type root]} {set_flowkit_db flow_init_footer_tcl {}}
if {[is_attribute flow_edit_start_steps -obj_type root]} {set_flowkit_db flow_edit_start_steps {}}
if {[is_attribute flow_edit_end_steps -obj_type root]} {set_flowkit_db flow_edit_end_steps {}}
if {[is_attribute flow_step_last_number -obj_type root]} {set_flowkit_db flow_step_last_number 0}
if {[is_attribute flow_autoload_applets -obj_type root]} {set_flowkit_db flow_autoload_applets false}
if {[is_attribute flow_autoload_dir -obj_type root]} {set_flowkit_db flow_autoload_dir error}
if {[is_attribute flow_skip_auto_db_save -obj_type root]} {set_flowkit_db flow_skip_auto_db_save true}
if {[is_attribute flow_skip_auto_generate_metrics -obj_type root]} {set_flowkit_db flow_skip_auto_generate_metrics false}
if {[is_attribute flow_top -obj_type root]} {set_flowkit_db flow_top {}}
if {[is_attribute flow_hier_path -obj_type root]} {set_flowkit_db flow_hier_path {}}
if {[is_attribute flow_schedule -obj_type root]} {set_flowkit_db flow_schedule {}}
if {[is_attribute flow_step_check_tcl -obj_type root]} {set_flowkit_db flow_step_check_tcl {}}
if {[is_attribute flow_script -obj_type root]} {set_flowkit_db flow_script {}}
if {[is_attribute flow_yaml_script -obj_type root]} {set_flowkit_db flow_yaml_script {}}
if {[is_attribute flow_cla_enabled_features -obj_type root]} {set_flowkit_db flow_cla_enabled_features {}}
if {[is_attribute flow_cla_inject_tcl -obj_type root]} {set_flowkit_db flow_cla_inject_tcl {}}
if {[is_attribute flow_error_message -obj_type root]} {set_flowkit_db flow_error_message {}}
if {[is_attribute flow_error_errorinfo -obj_type root]} {set_flowkit_db flow_error_errorinfo {}}
if {[is_attribute flow_reset_time_after_flow_init -obj_type root]} {set_flowkit_db flow_reset_time_after_flow_init false}
if {[is_attribute flow_error_write_db -obj_type root]} {set_flowkit_db flow_error_write_db true}
if {[is_attribute flow_advanced_metric_isolation -obj_type root]} {set_flowkit_db flow_advanced_metric_isolation flow}
if {[is_attribute flow_yaml_root -obj_type root]} {set_flowkit_db flow_yaml_root {}}
if {[is_attribute flow_yaml_root_dir -obj_type root]} {set_flowkit_db flow_yaml_root_dir {}}
if {[is_attribute flow_setup_config -obj_type root]} {set_flowkit_db flow_setup_config {HUDDLE {!!map {}}}}
if {[is_attribute flow_yamllint_exec -obj_type root]} {set_flowkit_db flow_yamllint_exec yamllint}

#############################################################
#####   User Defined Attributes   ###########################

