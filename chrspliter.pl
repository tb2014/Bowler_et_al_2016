#!/bin/perl
use Getopt::Std;
getopt('c:');
while (my $line = <>){
    chomp $line;
    my  @fields=split( '\t', $line);
    if($fields[0] eq $opt_c){
	print "$fields[0]\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t$fields[5]\t$fields[6]\t$fields[7]\t$fields[8]\n";
    }
}
