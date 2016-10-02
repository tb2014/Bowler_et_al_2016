library(plyr)
x<-read.table(file="SNP_hits.txt")
freqx<-count(x)
write.table(freqx, file="SNP_freq.txt") 
