# creating project
create_project riscv_extended_singlecycle ./build -part xc7a35tcpg236-1 -force

# adding xdc constraints
add_files -fileset constrs_1 "/home/24EC01019/RV32I-SINGLE-CYCLE-EXTENDED/constraint_files/riscv_extended.xdc"

# adding all verilog files
add_files [glob "/home/24EC01019/RV32I-SINGLE-CYCLE-EXTENDED/source_files/*.v"]

# setting top module
set_property top main_file [current_fileset]

# synthesis step
launch_runs synth_1
wait_on_run synth_1

# implementation
launch_runs impl_1
wait_on_run impl_1

# bitstream generation
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# opening reports
open_run impl_1

report_timing_summary
report_utilization

puts "Bitstream Generated Successfully"

exit
