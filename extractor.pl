#!/usr/bin/perl -w                                                                  
# extractor.pl -f <input_file> -c chromosome -w <window size> 
#input file is <chr> <pos> make sure its ordered and names chromsomes without chr 
#output  is <chr>> <pos> <sequence 1+ +/- window size>
use Getopt::Std;
use Bio::SeqIO;

getopts("f:w:c:");
$window_size=1+(2*$opt_w);
$filename=$opt_f;
$chr_file="chr" . $opt_c . ".caps.fa";
my $seqio_object = Bio::SeqIO->new(-file=> $chr_file, -format=> "fasta");
my $dna = $seqio_object->next_seq;
$dna_str=$dna->seq();


open my $file, '<', $filename;
while(<$file>){
    $new_line= $_;
    @fields=split('\t', $new_line);
    $start=$fields[1]-$opt_w;
    $end=$fields[1]+$opt_w;
    $my_string=$dna->subseq($start,$end);
    chop($my_string);
print "$my_string\t$fields[0]\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t$fields[5]\t$fields[6]\t$fields[7]\n";
}
