#! /bin/env tclsh

source globals.tcl

proc showAbout {} {
	global application_name;
	global application_author;
	global application_date;
	global application_copyright;
    puts "Welcome to $application_name.";
}