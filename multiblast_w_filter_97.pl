#!/bin/perl
#takes a list of mutations and surrounding DNA and uses blastn to determine matches across the genome
#parameters for mathes are hardcoded as 97% identity and >90bp long
use Getopt::Std;
getopt('m:p:');

$post_fix=$opt_p; #to stop file collosions when running multiple copies
$mutation_file=$opt_m;

open my $mutfile, '<', $mutation_file or die;
while (<$mutfile>){
    $new_l= $_;
    @file_line=split("\t", $new_l);
    $match_count=0;
    $sequence_of_interest=$file_line[0];
    #write out sequence file to temp
    open (TMPFILE, ">tmpfile.$post_fix") or die;
    print TMPFILE ">lala\n$sequence_of_interest\n";
    close (TMPFILE);
    #do blast search
    system("blastn -db gr37db -query tmpfile.$post_fix -outfmt 6 > blast.$post_fix");
    #read in result
    open (RESULTFILE, '<', "blast.$post_fix");
    $linecount=0;
    while(<RESULTFILE>){
	$res_line= $_;
	@file_line_res=split("\t", $res_line);
	#0-Query id
        #1-Subject id
	#2-% identity
	#3-alignment length
	#4-mismatches
	#5-gap
	#6-openings
	#7-q. start
	#8-q. end
	#9-s. start
	#10-s. end
	#11-e-value
	#12-bit score
	
	if ($file_line_res[3]>90 && $file_line_res[2]>97){ 
	    #if the length of the allignment is greater than 90bp
	    #and %id > 97
	    $linecount++;
	}
    }
    close (RESULTFILE);
    print "match_count $linecount\t$file_line[1]\t$file_line[2]\t$file_line[3]\t$file_line[4]\t$file_line[5]\t$file_line[6]\t$file_line[7]\t$sequence_of_interest\n";
}


