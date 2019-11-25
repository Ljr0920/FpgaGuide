proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir D:/lab2_Smart_responder/lab2_Smart_responder.cache/wt [current_project]
  set_property parent.project_path D:/lab2_Smart_responder/lab2_Smart_responder.xpr [current_project]
  set_property ip_repo_paths d:/lab2_Smart_responder/lab2_Smart_responder.cache/ip [current_project]
  set_property ip_output_repo d:/lab2_Smart_responder/lab2_Smart_responder.cache/ip [current_project]
  add_files -quiet D:/lab2_Smart_responder/lab2_Smart_responder.runs/synth_1/Smart_responder.dcp
  read_xdc D:/lab2_Smart_responder/lab2_Smart_responder.srcs/constrs_1/new/Smart_responder.xdc
  link_design -top Smart_responder -part xc7a35tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force Smart_responder_opt.dcp
  report_drc -file Smart_responder_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file Smart_responder.hwdef}
  place_design 
  write_checkpoint -force Smart_responder_placed.dcp
  report_io -file Smart_responder_io_placed.rpt
  report_utilization -file Smart_responder_utilization_placed.rpt -pb Smart_responder_utilization_placed.pb
  report_control_sets -verbose -file Smart_responder_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Smart_responder_routed.dcp
  report_drc -file Smart_responder_drc_routed.rpt -pb Smart_responder_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file Smart_responder_timing_summary_routed.rpt -rpx Smart_responder_timing_summary_routed.rpx
  report_power -file Smart_responder_power_routed.rpt -pb Smart_responder_power_summary_routed.pb
  report_route_status -file Smart_responder_route_status.rpt -pb Smart_responder_route_status.pb
  report_clock_utilization -file Smart_responder_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force Smart_responder.mmi }
  write_bitstream -force Smart_responder.bit 
  catch { write_sysdef -hwdef Smart_responder.hwdef -bitfile Smart_responder.bit -meminfo Smart_responder.mmi -file Smart_responder.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

