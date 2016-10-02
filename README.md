# Bowler_et_al_2016
Code to generate Fig 2 part C

##Required Data
##Chromosome files from	http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/
## chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa chr6.fa chr7.fa chr8.fa chr9.fa
## chr10.fa chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa chr16.fa chr17.fa chr18.fa
## chr19.fa chr20.fa chr21.fa chrX.fa chrY.fa
##Cosmic SNP file from cancer.sanger.ac.uk/cosmic downloaded on October 15th 2014
##CosmicMutantExport.tsv

##Supplied scripts
##runme_fig2.sh
##cosmic_splitter.pl
##chrsplitter.pl
##extractor.pl
##multiblast_w_filter_97.pl
##frequency.R

##Required installed UNIX utiliities
##tail sort uniq cat split awk
##perl with the following modules: Bio::SeqIO Getopt::Std
##R with the following modules: plyr
##standalone blastn with the gr37 human genome database

##Usage
#Download files to the same directory
#Run ./runme_fig2.sh
