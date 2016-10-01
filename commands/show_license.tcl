proc show_license {} {
	set fsize [file size "resources/gpl.txt"]
	set fp [open "resources/gpl.txt" r]
	set data [read $fp $fsize]
	close $fp
    	puts $data;
	flush stdout;
}
