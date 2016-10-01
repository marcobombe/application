source utils/findFiles.tcl
source globals.tcl

proc show_help {command} {
    	puts "Unknown command < $command >. Please type ? or help for available command list.";
	flush stdout;
}

proc check_exit_command {input_string} {
	set ret 1;
	set check1 [string compare -nocase $input_string "q"];
	set check2 [string compare -nocase $input_string "quit"];
	set check3 [string compare -nocase $input_string "exit"];

	if {$check1 == 0} {set ret 0} 
	if {$check2 == 0} {set ret 0} 
	if {$check3 == 0} {set ret 0}

	return $ret
}

proc command_interpreter {command} {
	set check1 0;
	set check2 0;
	set check3 0;
	set check4 0;
	
	set check1 [string compare -nocase $command "show_license"];
	set check3 [string compare -nocase $command "platform_info"];
	set check4 [string compare -nocase $command "showAbout"];
	set check2 [string compare -nocase $command ""];
	if {$check1 == 0} {show_license; return 0;}
	if {$check3 == 0} {platform_info; return 0;}
	if {$check4 == 0} {showAbout; return 0;}
	if {$check2 == 0} {return 0;}
	if {[check_exit_command $command]} {show_help $command;}
	return -1 
}

proc source_files {directory} {
	set check 0;
	global debug_very_verbose;

	set list_of_files [findFiles $directory *.tcl ]
	if {$debug_very_verbose != 0} {puts "Sourcing Files in < $directory > folder:"}
	foreach a $list_of_files {
		set line ""
      		append line "source " 
		append line $a
		set check [string match "*main.tcl*" $line ];	
		if {$check == 0} {eval $line}	

		if {$debug_very_verbose != 0} {puts "\t $line"}
  	}
}

proc load_command_list {directory} {
	set check 0;
	set command_list \{;
	global debug_very_verbose;

	set list_of_files [findFilesTail $directory *.tcl ]
	if {$debug_very_verbose != 0} {puts "Populating command list from < $directory > folder:"}
	if {$debug_very_verbose != 0} {puts -nonewline "\t"}
	foreach a $list_of_files {	
		set command [ string trim $a "*.tcl" ];	
		lappend $command_list $command
		if {$debug_very_verbose != 0} {puts -nonewline " | $command"}
  	}
	if {$debug_very_verbose != 0} {puts "."}
	return $command_list
}



set response ""
set command_error 0
source_files core
source_files utils
source_files commands
load_command_list commands
while {[check_exit_command $response]} {
    	puts -nonewline "prompt > ";
	flush stdout;
	set response [gets stdin];

	command_interpreter $response;
}
