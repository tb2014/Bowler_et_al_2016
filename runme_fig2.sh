#!/bin/bash
##master script for figure 2 Bowler et. al 2016
##Please see README for list of dependencies

#remove top line from CosmicMutantExport.tsv
tail -n +2  CosmicMutantExport.tsv > Cosmic_split.tsv

#cosmic_splitter.pl converts "chr:postion" into  "chr\tposition" 
./cosmic_splitter.pl < Cosmic_split.tsv > Cosmic_split.toplineremoved.tsv
sort Cosmic_split.toplineremoved.tsv > Cosmic_split.toplineremoved.sort.tsv
uniq  Cosmic_split.toplineremoved.sort.tsv > Cosmic_split.toplineremoved.sort.uniq.tsv

#separates the cosmic SNPS by chromosome and also makes a file containing the flanking DNA regions
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 X Y
do
echo $i
#convert the chr files to capitals for use by extractor.pl
tr a-z A-Z < chr$i.fa > chr$i.caps.fa
perl ./chrspliter.pl -c $i -f Cosmic_split.toplineremoved.sort.uniq.tsv > cs.$i.tsv
perl ./extractor.pl -c $i -w 50 -f cs.$i.tsv > cs.$i.plusminus50.tsv
done

#remove  any previous intermediate file 
rm cosmic.all.plusminus50.tsv
#put all the seperate chromosome data together
cat cs.*.plusminus50.tsv > cosmic.all.plusminus50.tsv

#remove duplicate SNPS
sort -k 3 -n cosmic.all.plusminus50.tsv > cosmic.all.plusminus50.tsv.sort
uniq  cosmic.all.plusminus50.tsv.sort > cosmic.all.plusminus50.tsv.sort.uniq

#split into 6 files, one for each thread
split -n 6  cosmic.all.plusminus50.tsv.sort.uniq cosmic.all.plusminus50.tsv.sort.uniq.

#blast each region around the SNP against the known genome
for i in aa ab ac ad ae af
do
nohup perl ./multiblast_w_filter_97.pl -p $i -m cosmic.all.plusminus50.tsv.sort.uniq.$i > cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97$i &
done

#concatentate the 6 output files
cat cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97aa \
    cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97ab \
    cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97ac \
    cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97ad \
    cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97ae \
    cosmic.all.plusminus50.tsv.multiblast.sort.uniq.multi_process.min_len_90.ident_97af >> min_len_90.ident_97.all


awk '$2>1' min_len_90.ident_97.all > min_len_90.ident_97.all.gt1
sort -k 9 min_len_90.ident_97.all.gt1 > min_len_90.ident_97.all.gt1.sort 
uniq min_len_90.ident_97.all.gt1.sort > min_len_90.ident_97.all.gt1.sort.uniq 
sort -k 9 min_len_90.ident_97.all.gt1.sort.uniq > min_len_90.ident_97.all.gt1.sort.uniq.sort
awk '{print $9}' min_len_90.ident_97.all.gt1.sort.uniq.sort > SNP_hits.txt


#calculate frequency of matching SNPs per gene
Rscript frequency.R
