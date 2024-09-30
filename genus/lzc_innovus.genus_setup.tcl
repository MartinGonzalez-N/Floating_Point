################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 21.10-p002_1
#   on 09/30/2024 21:30:22
#
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 21.10-p002_1


# Remove Existing Design
################################################################################
if {[::legacy::find -design /designs/lzc_24] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj /designs/lzc_24
}


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
::legacy::set_attribute library {/home/joc/jc_work/Floating_Point/genus//sky130_fd_sc_hd__ff_100C_1v65.lib} /


# Design
################################################################################
read_netlist -top lzc_24 ./lzc_innovus.v
read_metric -id current ./lzc_innovus.metrics.json

phys::read_script ./lzc_innovus.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
################################################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "21.10-p002_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 21.10-p002_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack /designs/lzc_24]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "inf"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: inf,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns /designs/lzc_24]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area /designs/lzc_24]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "551"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 551,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area /designs/lzc_24]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 0,  current net area: $_net_area_"
}
unset _net_area_
